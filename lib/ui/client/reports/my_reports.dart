import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/electrical_appliance.dart';
import 'package:mobile_safetech/services/electrical_appliance_services.dart';

import 'package:mobile_safetech/services/report_services.dart';

import '../../../common/commons.dart';
import '../../../domain/models/report.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({super.key});

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  _goToReportDetail({required String reportId}) {
    Navigator.pushNamed(context, "/reportDetail", arguments: reportId);
  }

  _goToAddReport() {
    Navigator.pushNamed(context, "/addReport");
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
                  "Mis reportes",
                  style: AppTextStyles.title(),
                ),
              ),
              FutureBuilder<List<Report>>(
                future: ReportService().getAllReports(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Report> reports = snapshot.data!;
                  return reportItemList(reports: reports);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _goToAddReport();
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget reportItemList({required List<Report> reports}) {
    if (reports.isEmpty) {
      return const Text("Hubo un error al obtener los reportes");
    }

    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        Report report = reports[index];

        return reportItemCard(report);
      },
    );
  }

  Widget reportItemCard(Report report) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          _goToReportDetail(reportId: report.id);
        },
        child: GridTile(
          footer: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            color: Colors.transparent,
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(report.title),
            ),
          ),
          child: FutureBuilder<ElectricalAppliance>(
            future: ElectricalApplianceService()
                .getElectricalAppliance(report.electricalApplianceId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              ElectricalAppliance electricalAppliance = snapshot.data!;

              return Image.network(electricalAppliance.urlImage);
            },
          ),
        ),
      ),
    );
  }
}
