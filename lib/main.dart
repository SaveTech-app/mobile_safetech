import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_safetech/firebase_options.dart';
import 'package:mobile_safetech/ui/client/reports/add_report.dart';
import 'package:mobile_safetech/ui/client/reports/my_reports.dart';
import 'package:mobile_safetech/ui/client/tabs.dart';
import 'package:mobile_safetech/ui/client/technical_detail_page.dart';
import 'package:mobile_safetech/ui/client/technical_list_page.dart';
import 'package:mobile_safetech/ui/shared/registry_page.dart';
import 'package:mobile_safetech/ui/shared/sign_in_page.dart';
import 'package:mobile_safetech/ui/shared/sign_up_page.dart';
import 'package:mobile_safetech/ui/shared/start_page.dart';
import 'package:flutter/material.dart';

import 'ui/client/reports/my_report_detail.dart';

Future<void> main() async {
  // Your code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Tech',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        //!Shared
        '/': (context) => const StartPage(),
        '/signIn': (context) => const SignInPage(),
        '/signUp': (context) => const SignUpPage(),
        '/registry': (context) => RegistryStep1Page(
            userType: ModalRoute.of(context)?.settings.arguments as String),
        //!Client Pages
        '/clientTabs': (context) => const ClientTabsPage(),
        //Report
        '/myReports': (context) => const ReportListPage(),
        '/addReport': (context) => const AddReportPage(),
        '/reportDetail': (context) => ReportDetailPage(
            reportId: ModalRoute.of(context)?.settings.arguments as String),
        //Tecnico
        '/technicalDetail': (context) => TechnicalDetailPage(
            technicalId: ModalRoute.of(context)?.settings.arguments as String),
        "/technicalList": (context) => const TechnicalListPage()
        //!Technical Pages
      },
    );
  }
}
