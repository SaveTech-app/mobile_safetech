import 'package:flutter/material.dart';

import '../../../common/commons.dart';

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
                    style: AppTextStyles.title(),
                  ),
                ],
              ),
              MyPremiumButton(),
              MyCustomButton(
                label: "Información personal",
                onTap: () {},
                textColor: AppColors.primaryColor,
                buttonColor: AppColors.secundaryColor,
                icon: Icons.pages,
              ),
              MyCustomButton(
                label: "Cuenta",
                onTap: () {},
                textColor: AppColors.primaryColor,
                buttonColor: AppColors.secundaryColor,
                icon: Icons.account_circle_outlined,
              ),
              MyCustomButton(
                label: "Método de pago",
                onTap: () {},
                textColor: AppColors.primaryColor,
                buttonColor: AppColors.secundaryColor,
                icon: Icons.credit_card,
              ),
              MyCustomButton(
                label: "Cambiar contraseña",
                onTap: () {},
                textColor: AppColors.primaryColor,
                buttonColor: AppColors.secundaryColor,
                icon: Icons.password,
              ),
              MyCustomButton(
                label: "Activar notificaciones",
                onTap: () {},
                textColor: AppColors.primaryColor,
                buttonColor: AppColors.secundaryColor,
                icon: Icons.notifications_none_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
