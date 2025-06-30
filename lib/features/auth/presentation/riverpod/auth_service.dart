import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // emailga tasdiqlash linkni jo'natish
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // tasdiqlangandan keyin firestorega yozamiz saqlab ketamiz
  Future<void> completeSignUp(User user) async {
    if (user.emailVerified) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        "email": user.email,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception("Email hali tasdiqlanmagan!");
    }
  }

  // sign in qilish
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // email tasdiqlashiga vaqt beramiz
  Future<bool> checkEmailVerification(
    User user, {
    int timeoutSeconds = 60,
  }) async {
    final Completer<bool> completer = Completer();
    final timer = Timer(Duration(seconds: timeoutSeconds), () {
      completer.complete(false);
    });

    Timer.periodic(Duration(seconds: 3), (pollTimer) async {
      await user.reload();
      if (_auth.currentUser!.emailVerified) {
        pollTimer.cancel();
        timer.cancel();
        completer.complete(true);
      }
    });

    return completer.future;
  }

  Stream<User?> get user => _auth.authStateChanges();
}
