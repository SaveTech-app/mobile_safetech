import 'package:flutter/material.dart';

import '../../../common/commons.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/buttons/secundary_button.dart';

class ClientSettingPage extends StatefulWidget {
  const ClientSettingPage({super.key});

  @override
  State<ClientSettingPage> createState() => _ClientSettingPageState();
}

class _ClientSettingPageState extends State<ClientSettingPage> {
  final String clientName = "Pablito";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myWhite,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 100,
                    child: CircleAvatar(
                      radius: 95,
                      backgroundImage: AssetImage(AppAssets.clientImagePath),
                    ),
                  ),
                  Text(
                    clientName,
                    style: AppTextStyles.title,
                  ),
                ],
              ),
              MyPremiumButton(),
              MyGreyButton(
                label: "Información personal",
                onTap: () {},
                icon: Icons.pages,
              ),
              MyGreyButton(
                label: "Cuenta",
                onTap: () {},
                icon: Icons.account_circle_outlined,
              ),
              MyGreyButton(
                label: "Método de pago",
                onTap: () {},
                icon: Icons.credit_card,
              ),
              MyGreyButton(
                label: "Cambiar contraseña",
                onTap: () {},
                icon: Icons.password,
              ),
              MyGreyButton(
                label: "Activar notificaciones",
                onTap: () {},
                icon: Icons.notifications_none_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
