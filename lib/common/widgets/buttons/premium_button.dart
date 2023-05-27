import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class MyPremiumButton extends StatelessWidget {
  const MyPremiumButton({super.key});

  goToPremiumPage() {
    print("premiun");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          goToPremiumPage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terciaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.5),
          ),
          side: const BorderSide(
            width: 3,
            color: AppColors.primaryColor,
          ),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.diamond_outlined,
                color: AppColors.primaryColor,
                size: 32,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Convertirse en Premium",
                style: AppTextStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
