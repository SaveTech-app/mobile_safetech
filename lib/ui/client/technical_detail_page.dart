import 'package:flutter/material.dart';

import '../../common/commons.dart';
import '../../domain/models/technical.dart';
import '../../services/technical_services.dart';

class TechnicalDetailPage extends StatefulWidget {
  final String technicalId;

  const TechnicalDetailPage({super.key, required this.technicalId});

  @override
  State<TechnicalDetailPage> createState() => _TechnicalDetailPageState();
}

class _TechnicalDetailPageState extends State<TechnicalDetailPage> {
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
            future: TechnicalService().getTechnical(widget.technicalId),
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
                              technical.name,
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
                  Icon(Icons.heart_broken),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2.0),
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        technical.urlImage,
                      ),
                    ),
                  ),
                  Icon(Icons.chat),
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
        MyCustomButton(label: "Crear Cita", onTap: () {})
      ],
    );
  }
}
