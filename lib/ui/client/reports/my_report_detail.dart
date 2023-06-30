import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/services/technical_services.dart';

import '../../../common/commons.dart';
import '../../../domain/models/report.dart';
import '../../../domain/models/technical.dart';
import '../../../domain/services/report_services.dart';
import '../technical_detail_page.dart';

class ReportDetailPage extends StatefulWidget {
  final String reportId;

  const ReportDetailPage({super.key, required this.reportId});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  _goToTechnicalDetail({required String technicalId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TechnicalDetailPage(
          technicalId: technicalId,
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
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder<Report>(
                  future: ReportService().getReportByUid(widget.reportId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    Report report = snapshot.data!;
                    return reportItemDetail(report: report);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Postulantes",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                FutureBuilder<List<Technical>>(
                  future: TechnicalServices().getTechnicals(),
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
      ),
    );
  }

  Column reportItemDetail({required Report report}) {
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

  Widget technicalItemCard(Technical technical) {
    return GestureDetector(
      onTap: () => {_goToTechnicalDetail(technicalId: technical.id)},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: AppStyles.greyWithGreen,
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: ListTile(
          leading: const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(AppAssets.technicalImagePath)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${technical.firstName} ${technical.lastName}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Row(
                children: [
                  Text(
                    "4/5",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.star),
                ],
              )
            ],
          ),
          subtitle: const Text(
            "S/. 450",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
