import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/appointment.dart';

import '../../../common/commons.dart';
import '../../../domain/services/appointment_services.dart';

class AddAppointmentPage extends StatefulWidget {
  final String technicalId;
  final String reportId;
  const AddAppointmentPage(
      {super.key, required this.technicalId, required this.reportId});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final clientId = FirebaseAuth.instance.currentUser!.uid;

  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController();

  DateTime appointmentDateTime = DateTime.now();

  @override
  void dispose() {
    addressController.dispose();

    super.dispose();
  }

  void _addAppointment() {
    if (_formKey.currentState!.validate()) {
      final address = addressController.text.trim();

      Timestamp appointTimeStamp = Timestamp.fromMillisecondsSinceEpoch(
          appointmentDateTime.toUtc().millisecondsSinceEpoch);

      Appointment appointment = Appointment(
          id: clientId,
          clientId: clientId,
          technicalId: widget.technicalId,
          reportId: widget.reportId,
          address: address,
          date: appointTimeStamp);

      AppointmentServices().addAppointment(appointment);

      Navigator.pushNamed(context, "/clientTabs");
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
                  "Registremos los datos de la cita",
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
                          label: "Dirección",
                          controller: addressController,
                          isRequired: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _datePicker(),
                      ),
                    ],
                  ),
                ),
                MyCustomButton(
                  label: "Crear cita",
                  onTap: () {
                    _addAppointment();
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
        DateTime? date = await _pickDate(appointmentDateTime);
        if (date == null) return;

        final dt = DateTime(date.year, date.month, date.day);

        setState(() => appointmentDateTime = dt);
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
            "${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year}",
            style: AppTextStyles.body(),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(DateTime dateTime) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
  }
}
