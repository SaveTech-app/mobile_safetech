import 'package:flutter/material.dart';

import '../../../common/commons.dart';
import '../../../domain/services/technical_services.dart';

class TechnicalSettingPage extends StatefulWidget {
  const TechnicalSettingPage({super.key});

  @override
  State<TechnicalSettingPage> createState() => _TechnicalSettingPageState();
}

class _TechnicalSettingPageState extends State<TechnicalSettingPage> {
  _goToStartPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (Route<dynamic> route) => false,
    );
  }

  void _signOut() async {
    try {
      await TechnicalServices().signOut();
      // Cierre de sesión exitoso
      print("Technicale cerró sesión");
      _goToStartPage();
    } catch (error) {
      // Error durante el cierre de sesión
      print("Error al cerrar sesión: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String clientName = TechnicalServices().getTechnicalName();

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
                      backgroundImage: AssetImage(AppAssets.technicalImagePath),
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
              MyCustomButton(
                label: "Cerrar sesión",
                onTap: () {
                  _signOut();
                },
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
