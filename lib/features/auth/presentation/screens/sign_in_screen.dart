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
import '../riverpod/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> iconsList = [
    AppAssets.email,
    AppAssets.google,
    AppAssets.facebook,
    AppAssets.twitter,
    AppAssets.apple,
  ];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            forceMaterialTransparency: true,
            actions: [
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.signUp);
                },
                child: AppText(
                  "Sign Up",
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
                50.g,
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
                      AppTextField(
                        label: "Password",
                        controller: passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Parol kiriting";
                          }
                          if (value.length < 6) {
                            passwordController.clear();
                            return "Kamida 6 ta belgidan iborat bo'lsin";
                          }
                          return null;
                        },
                      ),
                      30.g,
                      AppButton(
                        title: "Sign In",
                        padding: EdgeInsets.only(right: 49, left: 49),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final user = await AuthService().signIn(
                                emailController.text,
                                passwordController.text,
                              );
                              if (user != null && user.emailVerified) {
                                AppSnackBar.show(context, "Xush kelibsiz!");
                                context.go(AppRoutes.homeTopNews);
                              } else {
                                AppSnackBar.show(
                                  context,
                                  "Iltimos, emailingizni tasdiqlang!",
                                );
                              }
                            } catch (e) {
                              AppSnackBar.show(
                                context,
                                "Kirishda xatolik: ${e.toString()}",
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                100.g,
                Row(
                  children: [
                    Expanded(child: AppDivider(color: AppColors.black)),
                    AppText(
                      "or sign in with",
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
                    (index) => AppImage(
                      image: iconsList[index],
                      width: 43,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
