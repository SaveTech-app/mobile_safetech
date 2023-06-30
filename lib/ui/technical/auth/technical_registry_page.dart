import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/technical.dart';
import 'package:mobile_safetech/domain/services/client_services.dart';
import 'package:mobile_safetech/domain/services/technical_services.dart';

import '../../../common/commons.dart';

class TechnicalRegistryPage extends StatefulWidget {
  const TechnicalRegistryPage({super.key});

  @override
  State<TechnicalRegistryPage> createState() => _TechnicalRegistryPageState();
}

class _TechnicalRegistryPageState extends State<TechnicalRegistryPage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final informationController = TextEditingController();
  final experienceController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    informationController.dispose();
    experienceController.dispose();

    super.dispose();
  }

  Future<void> _registry() async {
    if (_formKey.currentState!.validate()) {
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final information = informationController.text.trim();
      final experience = experienceController.text.trim();

      final technical = Technical(
        id: "",
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        information: information,
        experience: experience,
      );

      try {
        final registeredTechnical =
            await TechnicalServices().registerWithEmail(technical);
        // Cliente registrado exitosamente
        print("Técnico registrado: ${registeredTechnical.id}");
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/technicalTabs',
          (Route<dynamic> route) => false,
        );
      } catch (error) {
        // Error durante el registro del cliente
        print("Error al registrar el técnico: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.myWhite,
          appBar: const EmptyAppBar(),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Registremos tus datos",
                      style: AppTextStyles.title(),
                    ),
                    Text(
                      "Para empezar, cuéntanos...",
                      style: AppTextStyles.body(),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Nombre",
                          controller: firstNameController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Apellido",
                          controller: lastNameController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Email",
                          controller: emailController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Contraseña",
                          controller: passwordController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Información",
                          controller: informationController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Experiencia",
                          controller: experienceController,
                          isRequired: true,
                        ),
                      )
                    ],
                  ),
                ),
                MyCustomButton(
                  label: "Registrarse",
                  onTap: () {
                    _registry();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
