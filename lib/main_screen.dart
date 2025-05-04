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
      if (mounted) {
        final qrScannerState = _qrScannerScreenKey.currentState;
        if (qrScannerState == null) {
          _log.warning("initState: QRScannerScreenState is null after build!");
          return;
        }

        if (_selectedIndex == 0) {
          _log.fine("MainScreen initState: Initial screen is Camera, starting scanner AND enabling wakelock.");
          qrScannerState.startCamera();
          qrScannerState.enableKeepAwake();
        } else {
          _log.fine("MainScreen initState: Initial screen is NOT Camera. Ensuring wakelock is off.");
          qrScannerState.disableKeepAwake();
        }
      }
    });
  }

  void _onItemTapped(int index) {
    _previousIndex = _selectedIndex;
    if (_previousIndex == index) return;

    final qrScannerState = _qrScannerScreenKey.currentState;

    if (qrScannerState == null) {
      _log.warning("onItemTapped: QRScannerScreenState is null! Cannot control scanner/wakelock.");
      setState(() { _selectedIndex = index; });
      return;
    }

    _log.fine("MainScreen: Switched tab from $_previousIndex to $_selectedIndex");

    if (_previousIndex == 0 && index != 0) {
      _log.fine("MainScreen: Switched away from Camera Tab. Stopping scanner AND disabling wakelock.");
      qrScannerState.stopCamera();
      qrScannerState.disableKeepAwake();
    }
    else if (_previousIndex != 0 && index == 0) {
      _log.fine("MainScreen: Switched to Camera Tab. Starting scanner AND enabling wakelock.");
      qrScannerState.startCamera();
      qrScannerState.enableKeepAwake();
    }

    setState(() {
      _selectedIndex = index;
    });
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