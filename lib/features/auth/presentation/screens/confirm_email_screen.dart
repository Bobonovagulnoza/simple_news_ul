import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/pinput_widget.dart';
class ConfirmEmailScreen extends StatelessWidget {
  ConfirmEmailScreen({super.key});
  final TextEditingController confirmationCodeController =
      TextEditingController();

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
                context.push(AppRoutes.signIn);
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
              Center(
                child: PinInputWidget(
                  controller: confirmationCodeController,
                  onCompleted: (value) {
                    context.push(AppRoutes.createPassword);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
