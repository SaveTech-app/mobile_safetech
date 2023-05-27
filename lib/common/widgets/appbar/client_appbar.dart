import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ClientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String clientName = "Vanessa";
  final String clientPlan = "Free";
  final String urlImage =
      "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.myWhite,
      title: ListTile(
        title: Text(
          "Hi, $clientName",
          style: const TextStyle(color: AppColors.myBlack),
        ),
        subtitle: Text(
          "Client, $clientPlan Plan",
          style: const TextStyle(color: AppColors.secundaryColor),
        ),
      ),
      titleSpacing: -10,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          urlImage,
        ),
      ),
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
