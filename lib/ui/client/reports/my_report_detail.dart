import 'package:flutter/material.dart';

import '../../../common/commons.dart';
import '../../../domain/models/report.dart';
import '../../../services/report_services.dart';

class ReportDetailPage extends StatefulWidget {
  final String reportId;

  const ReportDetailPage({super.key, required this.reportId});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        appBar: const EmptyAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: FutureBuilder<Report>(
            future: ReportService().getReport(widget.reportId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              Report report = snapshot.data!;
              return reportItemDetail(report: report);
            },
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
        const SizedBox(
          height: 20,
        ),
        MyCustomButton(label: "Ver postulantes", onTap: () {})
      ],
    );
  }
}
