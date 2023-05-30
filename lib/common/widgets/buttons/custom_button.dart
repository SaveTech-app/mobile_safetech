import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class MyCustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;

  const MyCustomButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.5),
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 32,
                ),
              ),
            Expanded(
              flex: icon != null ? 2 : 3,
              child: Align(
                alignment:
                    icon != null ? Alignment.centerLeft : Alignment.center,
                child: Text(
                  label,
                  style: AppTextStyles.buttonText(
                      textColor: textColor ?? AppColors.myWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
