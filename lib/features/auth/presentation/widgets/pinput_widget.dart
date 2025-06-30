import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/core/widgets/app_text.dart';
import 'package:news_app/core/widgets/app_textfield.dart';

class PinInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final String? errorText;

  const PinInputWidget({
    super.key,
    required this.controller,
    required this.onCompleted,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.1),
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Pinput(
          controller: controller,
          length: 6,
          keyboardType: TextInputType.number,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorText != null ? errorPinTheme : null,
          onCompleted: onCompleted,
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Kodni kiriting";
            }
            if (value.length != 6) {
              return "6 xonali kod kiriting";
            }
            return null;
          },
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: AppText(errorText!, color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }
}

class EmailStep extends StatelessWidget {
  final TextEditingController emailController;
  final bool isTimerActive;
  final int timerSeconds;
  final VoidCallback onSendVerificationCode;

  const EmailStep({
    super.key,
    required this.emailController,
    required this.isTimerActive,
    required this.timerSeconds,
    required this.onSendVerificationCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: "Email",
          controller: emailController,
          suffixIcon: InkWell(
            onTap: isTimerActive ? null : onSendVerificationCode,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: AppText(
                isTimerActive ? "$timerSeconds s" : "Send",
                color: isTimerActive ? AppColors.grey : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
