import 'package:mobile_safetech/ui/client/tabs.dart';
import 'package:mobile_safetech/ui/client/technical_detail_page.dart';
import 'package:mobile_safetech/ui/client/technical_list_page.dart';
import 'package:mobile_safetech/ui/shared/registry_page.dart';
import 'package:mobile_safetech/ui/shared/sign_in_page.dart';
import 'package:mobile_safetech/ui/shared/sign_up_page.dart';
import 'package:mobile_safetech/ui/shared/start_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Tech',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        //Shared
        '/': (context) => const StartPage(),
        '/signIn': (context) => const SignInPage(),
        '/signUp': (context) => const SignUpPage(),
        '/registry': (context) => RegistryStep1Page(
              userType: ModalRoute.of(context)?.settings.arguments as String,
            ),
        //Client Pages
        '/clientTabs': (context) => const ClientTabsPage(),
        '/technicalDetail': (context) => TechnicalDetailPage(
              technicalId: ModalRoute.of(context)?.settings.arguments as String,
            ),
        "/technicalList": (context) => const TechnicalListPage()
        //Technical Pages
      },
    );
  }
}
