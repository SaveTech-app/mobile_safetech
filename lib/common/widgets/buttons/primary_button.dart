import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class MyGreenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const MyGreenButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.5),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
