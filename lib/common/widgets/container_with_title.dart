import 'package:flutter/material.dart';

import '../utils/utils.dart';

class MyContainerWithTitle extends StatelessWidget {
  final String title;
  final String body;
  const MyContainerWithTitle(
      {super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppStyles.borderRadius),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Center(child: Text(title)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.terciaryColor,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: AppStyles.borderWidth,
                ),
              ),
              child: Center(
                child: Text(
                  body,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
