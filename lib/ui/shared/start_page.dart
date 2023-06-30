import 'package:flutter/material.dart';

import '../../common/commons.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  _goToSignPage({route}) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCustomButton(
                    label: "Regístrate",
                    buttonColor: AppColors.myWhite,
                    textColor: AppColors.primaryColor,
                    //icon: Icons.abc,
                    onTap: () {
                      _goToSignPage(route: "/signUp");
                    },
                  ),
                  const Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                      color: AppColors.myWhite,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      "Inicia sesión",
                      style: TextStyle(
                          color: AppColors.myWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onTap: () {
                      _goToSignPage(route: "/signIn");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
