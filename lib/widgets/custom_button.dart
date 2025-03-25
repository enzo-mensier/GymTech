import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Arriere Plan
        foregroundColor: AppColors.backgroundColor, // Texte
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Coins
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: AppTextStyles.semiBold.copyWith(
          color: AppColors.backgroundColor,
          fontSize: 16,
        ),
      ),
    );
  }
}