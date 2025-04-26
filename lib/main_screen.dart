import 'package:flutter/material.dart';
import '/screens/scanner_screen.dart';
import '/screens/file_screen.dart';
import '/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    QRScannerScreen(),
    FileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code),
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'Camera',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.image),
            icon: Icon(Icons.image_outlined),
            label: 'File',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}