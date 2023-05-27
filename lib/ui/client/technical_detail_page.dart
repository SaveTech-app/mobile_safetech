import 'package:flutter/material.dart';

import '../../common/commons.dart';

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
          child: Column(
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Jhony Roberto Coronel Manchego"),
                                  Text("jhony@email.com"),
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
                      children: const [
                        Icon(Icons.heart_broken),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
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
                child: const MyContainerWithTitle(
                  title: "Información",
                  body:
                      "Adipisicing laboris Lorem reprehenderit irure tempor aute.",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: const MyContainerWithTitle(
                  title: "Experiencia laboral",
                  body:
                      "Proident qui ex non Lorem enim laborum quis Lorem esse excepteur cupidatat incididunt. Consequat veniam esse est dolor amet minim deserunt aute aute labore cupidatat. Dolor id eiusmod fugiat veniam amet consectetur aliqua.",
                ),
              ),
              /*  MyGreenButton(
                label: "check availability",
                function: () {},
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
