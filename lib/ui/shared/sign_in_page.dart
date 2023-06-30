import 'package:flutter/material.dart';
import 'package:mobile_safetech/services/client_services.dart';

import '../../common/commons.dart';
import '../../common/widgets/buttons/custom_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.text = "admin@admin.com";
    passwordController.text = "admin1";
  }

  _goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/clientTabs',
      (Route<dynamic> route) => false,
    );
  }

  _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final client = await ClientServices().signInWithEmail(email, password);
      // Inicio de sesión exitoso
      print("Cliente inició sesión: ${client.id}");
      _goToHomePage();
    } catch (error) {
      // Error durante el inicio de sesión
      print("Error al iniciar sesión con correo electrónico: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const EmptyAppBar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AppAssets.loginBackgroundPath),
            ),
          ),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //! Title
                  Text(
                    "Inicia Sesión",
                    style: AppTextStyles.title(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //! Email
                        MyTextFormField(
                          label: "Email",
                          controller: emailController,
                          isRequired: true,
                        ),
                        //! Password
                        MyTextFormField(
                          label: "Contraseña",
                          controller: passwordController,
                          isRequired: true,
                        ),
                      ],
                    ),
                  ),
                  //! Login In
                  MyCustomButton(
                    label: "Ingresar",
                    onTap: () {
                      _signIn();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
