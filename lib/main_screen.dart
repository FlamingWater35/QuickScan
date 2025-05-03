import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:simple_scanner/l10n/app_localizations.dart';

import '/screens/scanner_screen.dart';
import '/screens/file_screen.dart';
import '/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _log = Logger('MainScreenState');
  int _selectedIndex = 0;
  int _previousIndex = 0;

  final GlobalKey<QRScannerScreenState> _qrScannerScreenKey = GlobalKey<QRScannerScreenState>();
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      QRScannerScreen(key: _qrScannerScreenKey),
      const FileScreen(),
      const SettingsScreen(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedIndex == 0) {
        _log.fine("MainScreen initState: Initial screen is Camera, starting scanner.");
        _qrScannerScreenKey.currentState?.startCamera();
      }
    });
  }

  void _onItemTapped(int index) {
    _previousIndex = _selectedIndex;
    if (_previousIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    _log.fine("MainScreen: Switched tab from $_previousIndex to $_selectedIndex");

    if (_previousIndex == 0 && index != 0) {
      _log.fine("MainScreen: Switched away from Camera, stopping scanner.");
      _qrScannerScreenKey.currentState?.stopCamera();
    }
    else if (_previousIndex != 0 && index == 0) {
      _log.fine("MainScreen: Switched to Camera, starting scanner.");
      _qrScannerScreenKey.currentState?.startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code),
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: l10n.scannerTabLabel,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.image),
            icon: Icon(Icons.image_outlined),
            label: l10n.fileTabLabel,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: l10n.settingsTabLabel,
          ),
        ],
      ),
    );
  }
}