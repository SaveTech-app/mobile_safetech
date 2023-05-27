import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../common/commons.dart';

class RegistryStep1Page extends StatefulWidget {
  final String userType;
  const RegistryStep1Page({super.key, required this.userType});

  @override
  State<RegistryStep1Page> createState() => _RegistryStep1PageState();
}

class _RegistryStep1PageState extends State<RegistryStep1Page> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  DateTime birthdayDate = DateTime.now();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();

    emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _registry() {
    if (_formKey.currentState!.validate()) {
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final phone = phoneController.text.trim();

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final userType = widget.userType;

      //Navigator.of(context).pop();
      final object = {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "password": password,
        "userType": userType
      };

      log(json.encode(object));
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
                      style: AppTextStyles.title,
                    ),
                    Text(
                      "Para empezar, cuéntanos...",
                      style: AppTextStyles.body,
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: MyTextFormField(
                                  label: "Teléfono",
                                  controller: phoneController,
                                  isRequired: true,
                                  isNumber: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: _datePicker(),
                              ),
                            ),
                          ],
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
                          label: "Repetir contraseña",
                          controller: password2Controller,
                          isRequired: true,
                        ),
                      )
                    ],
                  ),
                ),
                MyGreenButton(
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

  Widget _datePicker() {
    return InkWell(
      onTap: () async {
        DateTime? date = await _pickDate(birthdayDate);
        if (date == null) return;

        final dt = DateTime(date.year, date.month, date.day);

        setState(() => birthdayDate = dt);
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${birthdayDate.day}/${birthdayDate.month}/${birthdayDate.year}",
            style: AppTextStyles.body,
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(DateTime dateTime) {
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950, 1, 1),
      lastDate: DateTime.now(),
    );
  }

  //sa
}
