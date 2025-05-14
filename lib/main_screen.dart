import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '/l10n/app_localizations.dart';

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
          _log.fine("MainScreen initState: Initial screen is Camera, attempting to start scanner.");
          qrScannerState.startCamera();
        } else {
          _log.fine("MainScreen initState: Initial screen is NOT Camera. Scanner should be stopped by default.");
        }
      }
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    final qrScannerState = _qrScannerScreenKey.currentState;
    final previousIndex = _selectedIndex;

    setState(() {
      _selectedIndex = index;
    });
    
    if (qrScannerState == null) {
      _log.warning("onItemTapped: QRScannerScreenState is null! Cannot control scanner.");
      return;
    }

    _log.fine("MainScreen: Switched tab from $previousIndex to $index");

    if (previousIndex == 0 && index != 0) {
      _log.fine("MainScreen: Switched away from Camera Tab. Stopping scanner.");
      qrScannerState.stopCamera();
    }
    else if (previousIndex != 0 && index == 0) {
      _log.fine("MainScreen: Switched to Camera Tab. Starting scanner.");
      qrScannerState.startCamera();
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
            selectedIcon: const Icon(Icons.qr_code),
            icon: const Icon(Icons.qr_code_scanner_outlined),
            label: l10n.scannerTabLabel,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.image),
            icon: const Icon(Icons.image_outlined),
            label: l10n.fileTabLabel,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.settings),
            icon: const Icon(Icons.settings_outlined),
            label: l10n.settingsTabLabel,
          ),
        ],
      ),
    );
  }
}