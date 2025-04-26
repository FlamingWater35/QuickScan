import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'main_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // Might not be needed, added for theme mode saving
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // Configure level as needed
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('StackTrace: ${record.stackTrace}');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _log = Logger('MyApp');

  @override
  Widget build(BuildContext context) {
    MyApp._log.info("Building MyApp widget");
    final themeMode = ThemeMode.system;
    const seedColor = Colors.blueAccent;

    // Predictive back transitions for Android
    // const pageTransitionsTheme = PageTransitionsTheme(
    //   builders: <TargetPlatform, PageTransitionsBuilder>{
    //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    //   },
    // );

    SnackBarThemeData buildSnackBarTheme(ColorScheme colorScheme) {
      return SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: colorScheme.onInverseSurface,
          fontSize: 14,
        ),
        actionTextColor: colorScheme.inversePrimary,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        elevation: 4.0,
      );
    }

    return MaterialApp(
      title: 'Simple Scanner',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        snackBarTheme: buildSnackBarTheme(ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        )),
        // pageTransitionsTheme: pageTransitionsTheme,
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        snackBarTheme: buildSnackBarTheme(ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        )),
        // pageTransitionsTheme: pageTransitionsTheme,
      ),
      
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
