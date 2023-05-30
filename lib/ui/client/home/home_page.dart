import 'package:flutter/material.dart';

import '../../../common/commons.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  goToPage({route}) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttons(),
            tip(),
            const MyPremiumButton(),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyCustomButton(
            label: "Appointment",
            onTap: () {
              goToPage(route: "/technicalList");
            },
          ),
          MyCustomButton(
            label: "Pending Appointment",
            onTap: () {
              goToPage(route: "/technicalList");
            },
          ),
          MyCustomButton(
            label: "Technicals",
            onTap: () {
              goToPage(route: "/technicalList");
            },
          ),
        ],
      ),
    );
  }

  Widget tip() {
    String tip =
        "Control the portion of your food using measuring guides such as your hands.";
    String tipImage =
        "https://s03.s3c.es/imag/_v0/770x420/1/9/8/490x_habitos-saludables.jpg";

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Nutrition tip",
              style: AppTextStyles.title(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              image: DecorationImage(
                image: NetworkImage(tipImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(child: Container()),
                  Flexible(
                    child: Text(
                      tip,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
