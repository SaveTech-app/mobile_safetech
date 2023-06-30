import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/report.dart';
import 'package:mobile_safetech/services/electrical_appliance_services.dart';

import '../../../common/commons.dart';
import '../../../domain/models/electrical_appliance.dart';
import '../../../services/report_services.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final clientId = FirebaseAuth.instance.currentUser!.uid;

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? electricalApplianceController;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  void _addReport() {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      final electricalApplianceId = electricalApplianceController;

      Report report = Report(
          id: "id",
          clientId: clientId,
          electricalApplianceId: electricalApplianceId!,
          title: title,
          description: description);

      //log(json.encode(report));

      ReportService().addReport(report);

      Navigator.of(context).pop();
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
                        child: FutureBuilder<List<ElectricalAppliance>>(
                          future: ElectricalApplianceService().getAppliances(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final appliances = snapshot.data!;
                              return DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  labelText: "Electrodoméstico",
                                  labelStyle: TextStyle(
                                    color: AppColors.myBlack,
                                    fontSize: 16,
                                  ),
                                  counterText: '',
                                ),
                                value: electricalApplianceController,
                                items: appliances.map((appliance) {
                                  return DropdownMenuItem<String>(
                                    value: appliance.id,
                                    child: Text(appliance.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    electricalApplianceController = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Requerido";
                                  }
                                  return null;
                                },
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                  "Error retrieving appliances"); // Manejo de error
                            }
                            return const CircularProgressIndicator(); // Indicador de carga mientras se obtienen los datos
                          },
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
