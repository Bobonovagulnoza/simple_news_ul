import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/core/constants/app_fonts.dart';

class AppTextField extends StatefulWidget {
  final String? errorText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? hintText;

  const AppTextField({
    super.key,
    this.errorText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    required this.label,
    this.suffixIcon,
    this.keyboardType,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.hintText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      // Password field uchun visibility icon
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.grey,
        ),
        onPressed: () {
          setState(() => _obscureText = !_obscureText);
        },
      );
    } else if (widget.suffixIcon != null) {
      // Custom suffix icon
      return widget.suffixIcon;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          buildCounter: widget.maxLength != null 
              ? (context, {required currentLength, required isFocused, maxLength}) {
                  // Counter'ni yashirish uchun null qaytaramiz
                  return null;
                }
              : null,
          style: TextStyle(
            color: widget.enabled ? const Color(0xFF180E19) : AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            labelText: widget.label,
            hintText: widget.hintText,
            labelStyle: TextStyle(
              fontFamily: AppFonts.SFPro,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.enabled ? AppColors.grey : AppColors.grey.withOpacity(0.5),
            ),
            hintStyle: TextStyle(
              fontFamily: AppFonts.SFPro,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.grey.withOpacity(0.7),
            ),
            floatingLabelStyle: TextStyle(
              color: widget.enabled ? AppColors.black : AppColors.grey,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            errorText: widget.errorText,
            suffixIcon: _buildSuffixIcon(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.enabled ? const Color(0xFFEEEEEE) : AppColors.grey.withOpacity(0.3),
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey.withOpacity(0.3),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.enabled ? const Color(0xFF180E19) : AppColors.grey,
                width: 1.4,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.4),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.4),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}