import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_safetech/domain/services/client_services.dart';
import 'package:mobile_safetech/domain/services/report_services.dart';

import '../../../common/commons.dart';
import '../../../domain/models/appointment.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/report.dart';
import '../../../domain/services/appointment_services.dart';

class AppointmentDetailPage extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailPage({super.key, required this.appointmentId});

  @override
  State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        appBar: const EmptyAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: FutureBuilder<Appointment>(
            future:
                AppointmentServices().getAppointmentById(widget.appointmentId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              Appointment appointment = snapshot.data!;
              return appointmentItemDetail(appointment: appointment);
            },
          ),
        ),
      ),
    );
  }

  Column appointmentItemDetail({required Appointment appointment}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<Report>(
          future: ReportService().getReportByUid(appointment.reportId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error obteniendo el informe");
            } else if (!snapshot.hasData) {
              return Text("Informe no encontrado");
            }
            Report report = snapshot.data!;
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: MyContainerWithTitle(
                    title: "Título",
                    body: report.title,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: MyContainerWithTitle(
                    title: "Descripción",
                    body: report.description,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<Client>(
          future: ClientServices().getClientById(appointment.clientId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error obteniendo el cliente");
            } else if (!snapshot.hasData) {
              return Text("Cliente no encontrado");
            }
            Client client = snapshot.data!;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: MyContainerWithTitle(
                title: "Cliente",
                body: '${client.firstName} ${client.lastName}',
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          child: MyContainerWithTitle(
            title: "Dirección",
            body: appointment.address,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          child: MyContainerWithTitle(
            title: "Fecha",
            body: DateFormat('dd/MM/yyyy').format(appointment.date.toDate()),
          ),
        ),
      ],
    );
  }
}
