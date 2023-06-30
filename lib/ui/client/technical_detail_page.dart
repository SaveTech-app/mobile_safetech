import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/services/technical_services.dart';
import 'package:mobile_safetech/ui/client/appointment/add_appointment.dart';

import '../../common/commons.dart';
import '../../domain/models/technical.dart';

class TechnicalDetailPage extends StatefulWidget {
  final String technicalId;
  final String reportId;

  const TechnicalDetailPage(
      {super.key, required this.technicalId, required this.reportId});

  @override
  State<TechnicalDetailPage> createState() => _TechnicalDetailPageState();
}

class _TechnicalDetailPageState extends State<TechnicalDetailPage> {
  _goToAddAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAppointmentPage(
          technicalId: widget.technicalId,
          reportId: widget.reportId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        appBar: const EmptyAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: FutureBuilder<Technical>(
            future: TechnicalServices().getTechnicalById(widget.technicalId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              Technical technical = snapshot.data!;
              return technicalProfile(context: context, technical: technical);
            },
          ),
        ),
      ),
    );
  }

  Column technicalProfile(
      {required BuildContext context, required Technical technical}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.only(top: 25),
              width: double.infinity,
              child: Container(
                decoration: AppStyles.greyWithGreen,
                child: Column(
                  children: [
                    Flexible(child: Container()),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              technical.firstName,
                              style: AppTextStyles.body(),
                            ),
                            Text(
                              technical.email,
                              style: AppTextStyles.body(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.heart_broken),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2.0),
                    ),
                    child: const CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(
                        AppAssets.technicalImagePath,
                      ),
                    ),
                  ),
                  const Icon(Icons.chat),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: MyContainerWithTitle(
            title: "Información",
            body: technical.information,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          child: MyContainerWithTitle(
            title: "Experiencia laboral",
            body: technical.experience,
          ),
        ),
        MyCustomButton(
            label: "Crear Cita",
            onTap: () {
              _goToAddAppointment();
            })
      ],
    );
  }
}
