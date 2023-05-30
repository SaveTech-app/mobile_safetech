import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/report.dart';

import '../../../common/commons.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final electricalApplianceIdController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    electricalApplianceIdController.dispose();

    super.dispose();
  }

  void _addReport() {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      final electricalApplianceId = electricalApplianceIdController.text.trim();

      //Navigator.of(context).pop();
      Report report = Report(
          id: "id",
          clientId: "clientId",
          electricalApplianceId: electricalApplianceId,
          title: title,
          description: description);

      log(json.encode(report));
      //ReportService().createReport(report);
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
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Registremos los datos del reporte",
                  style: AppTextStyles.title(),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Título",
                          controller: titleController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "Descripción",
                          controller: descriptionController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyTextFormField(
                          label: "electricalApplianceId",
                          controller: electricalApplianceIdController,
                          isRequired: true,
                          isNumber: true,
                        ),
                      ),
                    ],
                  ),
                ),
                MyCustomButton(
                  label: "Crear reporte",
                  onTap: () {
                    _addReport();
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
