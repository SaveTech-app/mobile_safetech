import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_safetech/domain/services/appointment_services.dart';

import '../../../common/commons.dart';
import '../../../domain/models/appointment.dart';
import '../../../domain/models/technical.dart';
import '../../../domain/services/technical_services.dart';

class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  _goToAppointmentDetail({required String appointmentId}) {
    Navigator.pushNamed(context, "/appointmentDetail",
        arguments: appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Mis citas",
                  style: AppTextStyles.title(),
                ),
              ),
              FutureBuilder<List<Appointment>>(
                future: AppointmentServices().getAppointments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Appointment> appointments = snapshot.data!;
                  return appointmentItemList(appointments: appointments);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentItemList({required List<Appointment> appointments}) {
    if (appointments.isEmpty) {
      return const Text("Hubo un error al obtener los appointmentes");
    }

    return Column(
        children: appointments
            .map((appointment) => appointmentItemCard(appointment))
            .toList());
  }

  Widget appointmentItemCard(Appointment appointment) {
    return FutureBuilder<Technical>(
      future: TechnicalServices().getTechnicalById(appointment.technicalId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Error al obtener el técnico");
        } else if (!snapshot.hasData) {
          return const Text("No se encontró el técnico");
        }

        final technical = snapshot.data!;

        return GestureDetector(
          onTap: () => {_goToAppointmentDetail(appointmentId: appointment.id)},
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: AppStyles.greyWithGreen,
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${technical.firstName} ${technical.lastName}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Fecha: ${DateFormat('dd/MM/yyyy').format(appointment.date.toDate())}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(AppAssets.technicalImagePath),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
