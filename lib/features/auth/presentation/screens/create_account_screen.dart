import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_textfield.dart';
import '../riverpod/auth_service.dart';
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
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
                    AppTextField(
                      label: "Confirm password",
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Parol kiriting";
                        } else if (value.length < 6) {
                          confirmPasswordController.clear();
                          return "Kamida 6 ta belgidan iborat bo'lsin";
                        } else if (value != passwordController.text) {
                          confirmPasswordController.clear();
                          passwordController.clear();
                          return "Parollar bir xil emas";
                        }
                        return null;
                      },
                    ),
                    30.g,
                    AppButton(
                      title: "Create account",
                      padding: EdgeInsets.only(right: 49, left: 49),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final user = await AuthService().signIn(
                              emailController.text,
                              passwordController.text,
                            );
                            if (user != null && user.emailVerified) {
                              await AuthService().completeSignUp(user);
                              AppSnackBar.show(context, "Account yaratildi!");
                              context.go(AppRoutes.signIn);
                            } else {
                              AppSnackBar.show(
                                context,
                                "Email tasdiqlanmagan!",
                              );
                            }
                          } catch (e) {
                            AppSnackBar.show(context, "Xatolik: $e");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
