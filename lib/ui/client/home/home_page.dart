import 'dart:math';

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
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyCustomButton(
            label: "Crear reporte",
            onTap: () {
              goToPage(route: "/addReport");
            },
          ),
          MyCustomButton(
            label: "Mis reportes",
            onTap: () {
              goToPage(route: "/myReports");
            },
          ),
          MyCustomButton(
            label: "Mis citas",
            onTap: () {
              goToPage(route: "/technicalList");
            },
          ),
        ],
      ),
    );
  }

  Widget tip() {
    List<Map<String, String>> tips = [
      {
        "title": "Lee el manual de instrucciones",
        "subTitle":
            "Familiarízate con las recomendaciones específicas de cada electrodoméstico"
      },
      {
        "title": "Limpieza regular",
        "subTitle":
            "Mantén tus electrodomésticos limpios para un funcionamiento óptimo"
      },
      {
        "title": "Desconexión cuando no estén en uso",
        "subTitle":
            "Evita el consumo innecesario de energía desconectando los electrodomésticos"
      },
      {
        "title": "Cuidado con los cables",
        "subTitle":
            "Evita enredos y daños asegurándote de mantener los cables en buen estado"
      },
      {
        "title": "No sobrecargues los enchufes",
        "subTitle":
            "Evita sobrecalentamientos y cortocircuitos al no conectar demasiados electrodomésticos en el mismo enchufe"
      },
      {
        "title": "Ajusta la temperatura adecuada",
        "subTitle":
            "Configura la temperatura de acuerdo a las recomendaciones del fabricante y tus necesidades"
      },
      {
        "title": "No golpees los electrodomésticos",
        "subTitle":
            "Evita golpes y maltratos que puedan afectar el funcionamiento de los electrodomésticos"
      },
      {
        "title": "Utiliza utensilios adecuados",
        "subTitle":
            "Utiliza utensilios y accesorios específicos para cada electrodoméstico, evitando daños en las superficies"
      },
      {
        "title": "Revisa y cambia los filtros",
        "subTitle":
            "Mantén los filtros limpios y reemplázalos según sea necesario"
      },
      {
        "title": "Realiza un mantenimiento periódico",
        "subTitle":
            "Programa un mantenimiento regular para asegurar el buen funcionamiento de tus electrodomésticos"
      }
    ];

    Random random = Random();
    int randomIndex = random.nextInt(tips.length);

    Map<String, String> randomTip = tips[randomIndex];

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tip del día",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                randomTip["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                randomTip["subTitle"]!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
