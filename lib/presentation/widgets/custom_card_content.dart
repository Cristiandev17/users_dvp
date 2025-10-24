import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:users_dvp_app/core/constants/app_constants.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';
import 'package:users_dvp_app/core/theme/app_text_styles.dart';

class CustomCardContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const CustomCardContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 4.0,
      color: AppColors.white,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => onTap(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppConstants.animationUser,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleLarge),
                  SizedBox(height: 10),
                  Text(subtitle, style: AppTextStyles.bodyBoldLarge),
                ],
              ),
              Spacer(),
              Icon(icon, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
