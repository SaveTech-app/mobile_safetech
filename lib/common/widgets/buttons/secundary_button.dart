import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class MyGreyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const MyGreyButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terciaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 32,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: AppTextStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
