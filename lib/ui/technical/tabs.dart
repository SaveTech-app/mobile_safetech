// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../common/commons.dart';

import '../../common/widgets/appbar/technical_appbar.dart';
import 'home/appointment_page.dart';
import 'home/chat_page.dart';
import 'home/home_page.dart';
import 'home/settings_page.dart';

class TechnicalTabsPage extends StatefulWidget {
  const TechnicalTabsPage({super.key});

  @override
  State<TechnicalTabsPage> createState() => _TechnicalTabsPageState();
}

class _TechnicalTabsPageState extends State<TechnicalTabsPage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    TechnicalHomePage(),
    TechnicalAppointmentPage(),
    TechnicalChatPage(),
    TechnicalSettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.myWhite,
          body: _tabs[_selectedIndex],
          appBar: _selectedIndex != 3 ? TechnicalAppBar() : null,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.myBlack,
            unselectedItemColor: AppColors.secundaryColor,
            backgroundColor: AppColors.primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Inicio",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Citas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Ajustes",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
