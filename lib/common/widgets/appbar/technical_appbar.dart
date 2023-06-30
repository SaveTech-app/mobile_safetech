import 'package:flutter/material.dart';

import '../../../domain/services/technical_services.dart';
import '../../utils/utils.dart';

class TechnicalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TechnicalAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String clientPlan = "Free";

  @override
  Widget build(BuildContext context) {
    final String clientName = TechnicalServices().getTechnicalName();

    return AppBar(
      backgroundColor: AppColors.myWhite,
      title: ListTile(
        title: Text(
          "Hi, $clientName",
          style: const TextStyle(color: AppColors.myBlack),
        ),
        subtitle: Text(
          "Technical, $clientPlan Plan",
          style: const TextStyle(color: AppColors.myBlack),
        ),
      ),
      titleSpacing: -10,
      leading: const CircleAvatar(
          backgroundImage: AssetImage(AppAssets.technicalImagePath)),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.notifications_none_outlined,
            color: AppColors.myBlack,
          ),
        ),
      ],
    );
  }
}
