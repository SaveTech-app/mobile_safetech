import 'package:flutter/material.dart';

import '../../common/commons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  _registerUser({userType}) {
    Navigator.pushNamed(context, '/registry', arguments: userType);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const EmptyAppBar(),
        backgroundColor: AppColors.myWhite,
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titles(),
                _clientAvatar(),
                _technicalAvatar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _titles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Text(
            "¿Qué tipo de usuario eres?",
            style: AppTextStyles.title(),
            textAlign: TextAlign.center,
          ),
          Text(
            "Elige tu tipo de usuario para comenzar a utilizar la aplicación",
            style: AppTextStyles.body(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  GestureDetector _clientAvatar() {
    return GestureDetector(
      onTap: () => _registerUser(userType: "client"),
      child: Column(
        children: const [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 100,
            child: CircleAvatar(
              radius: 95,
              backgroundImage: AssetImage(AppAssets.clientImagePath),
            ),
          ),
          Text("Cliente"),
        ],
      ),
    );
  }

  GestureDetector _technicalAvatar() {
    return GestureDetector(
      onTap: () => _registerUser(userType: "technical"),
      child: Column(
        children: const [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 100,
            child: CircleAvatar(
              radius: 95,
              backgroundImage: AssetImage(AppAssets.technicalImagePath),
            ),
          ),
          Text("Técnico"),
        ],
      ),
    );
  }
}
