import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> iconsList = [
    AppAssets.email,
    AppAssets.google,
    AppAssets.facebook,
    AppAssets.twitter,
    AppAssets.apple,
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            GestureDetector(
              onTap: () {
                context.go(AppRoutes.signIn);
              },
              child: AppText(
                "Sign In",
                padding: EdgeInsets.only(right: 46),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(right: 46, left: 46, top: 125),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppImage(
                image: AppAssets.columnLogo,
                fit: BoxFit.cover,
                width: 90,
                height: 135,
              ),
              46.g,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: "Email",
                      controller: emailController,
                      validator: (value) {
                        final emailRegex = RegExp(r"^[\w-\.]+@gmail\.com$");
                        if (value == null || value.isEmpty) {
                          return "Emailni kiriting";
                        } else if (!emailRegex.hasMatch(value)) {
                          emailController.clear();
                          return "@gmail.com formatida kiritish majburiy";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              30.g,
              AppButton(
                title: "Send verification link",
                padding: EdgeInsets.only(right: 49, left: 49),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = emailController.text.trim();

                    try {
                      final methods = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(email);
                      if (methods.isNotEmpty) {
                        AppSnackBar.show(
                          context,
                          "Bu email allaqachon ro‘yxatdan o‘tgan",
                        );
                        return;
                      }

                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email,
                            password:
                                'temp_${DateTime.now().millisecondsSinceEpoch}',
                          );

                      final user = userCredential.user;
                      if (user == null) {
                        AppSnackBar.show(context, "Foydalanuvchi yaratilmadi");
                        return;
                      }

                      try {
                        await user.sendEmailVerification();
                        AppSnackBar.show(
                          context,
                          "Tasdiqlash linki emailingizga yuborildi",
                        );
                      } catch (e) {
                        AppSnackBar.show(
                          context,
                          "Tasdiqlash linkini yuborishda xato: ${e.toString()}",
                        );
                        await user.delete();
                        return;
                      }

                      await FirebaseAuth.instance.signOut();

                      context.go(
                        AppRoutes.createPassword,
                        extra: {'email': email},
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        AppSnackBar.show(
                          context,
                          "Bu email allaqachon ro‘yxatdan o‘tgan",
                        );
                      } else if (e.code == 'invalid-email') {
                        AppSnackBar.show(context, "Noto‘g‘ri email manzili");
                      } else if (e.code == 'network-request-failed') {
                        AppSnackBar.show(
                          context,
                          "Tarmoq xatosi, internetni tekshiring",
                        );
                      } else {
                        AppSnackBar.show(
                          context,
                          "Firebase xatolik: ${e.message}",
                        );
                      }
                    } catch (e) {
                      AppSnackBar.show(context, "Xatolik: ${e.toString()}");
                    }
                  }
                },
              ),
              100.g,
              Row(
                children: [
                  Expanded(child: AppDivider(color: AppColors.black)),
                  AppText(
                    "or sign up with",
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Expanded(child: AppDivider(color: AppColors.black)),
                ],
              ),
              40.g,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  iconsList.length,
                  (index) =>
                      AppImage(image: iconsList[index], width: 43, height: 40),
                ),
              ),
              62.g,
              AppText(
                "By signing up to News24 you are accepting our",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                "Terms & Conditions",
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
