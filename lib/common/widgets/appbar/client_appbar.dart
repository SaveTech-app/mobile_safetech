import 'package:flutter/material.dart';

import '../../../domain/services/client_services.dart';
import '../../utils/utils.dart';

class ClientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String clientPlan = "Free";

  @override
  Widget build(BuildContext context) {
    final String clientName = ClientServices().getClientName();

    return AppBar(
      backgroundColor: AppColors.myWhite,
      title: ListTile(
        title: Text(
          "Hola, Juanito",
          style: const TextStyle(color: AppColors.myBlack),
        ),
        subtitle: Text(
          "Cliente, $clientPlan Plan",
          style: const TextStyle(color: AppColors.myBlack),
        ),
      ),
      titleSpacing: -10,
      leading: const CircleAvatar(
          backgroundImage: AssetImage(AppAssets.clientImagePath)),
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
