/* import 'package:flutter/material.dart';

import 'package:mobile_safetech/services/technical_services.dart';

import '../../common/commons.dart';

import '../../domain/models/technical.dart';

class TechnicalListPage extends StatefulWidget {
  const TechnicalListPage({super.key});

  @override
  State<TechnicalListPage> createState() => _TechnicalListPageState();
}

class _TechnicalListPageState extends State<TechnicalListPage> {
  _goToTechnicalDetail({required String technicalId}) {
    Navigator.pushNamed(context, "/technicalDetail", arguments: technicalId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        appBar: const EmptyAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Lista de técnicos",
                  style: AppTextStyles.title(),
                ),
              ),
              FutureBuilder<List<Technical>>(
                future: TechnicalService().getAllTechnicals(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Technical> technicals = snapshot.data!;
                  return technicalItemList(technicals: technicals);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget technicalItemList({required List<Technical> technicals}) {
    if (technicals.isEmpty) {
      return const Text("Hubo un error al obtener los técnicos");
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: technicals.length,
      itemBuilder: (context, index) {
        Technical technical = technicals[index];

        return technicalItemCard(technical);
      },
    );
  }

  Container technicalItemCard(Technical technical) {
    return Container(
      decoration: AppStyles.greyWithGreen,
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            technical.urlImage,
          ),
        ),
        title: Text(technical.name),
        subtitle: Text("${technical.name} años, ${technical.name}/5"),
        trailing: IconButton(
          icon: const Icon(Icons.remove_red_eye_rounded),
          onPressed: () {
            _goToTechnicalDetail(technicalId: technical.id);
          },
        ),
      ),
    );
  }
}
 */