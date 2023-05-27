import 'package:flutter/material.dart';

import '../../common/commons.dart';

class TechnicalListPage extends StatefulWidget {
  const TechnicalListPage({super.key});

  @override
  State<TechnicalListPage> createState() => _TechnicalListPageState();
}

class _TechnicalListPageState extends State<TechnicalListPage> {
  _goToTechnicalDetail({technicalId}) {
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
                  style: AppTextStyles.title,
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: AppStyles.greyWithGreen,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                      ),
                      title: const Text("Mariana Cruz"),
                      subtitle: const Text("35 años, 4/5"),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_red_eye_rounded),
                        onPressed: () {
                          _goToTechnicalDetail(technicalId: "technicalId");
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
