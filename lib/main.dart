import 'package:get_it/get_it.dart';
import 'package:my_chat/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_chat/services/auth_service.dart';
import 'package:my_chat/services/navigation_service.dart';

void main() async {
  await setup();
  runApp(
    MyApp(),
  );
}

Future setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await stupFirebase();
  await RegisterServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthService _authService;

  MyApp({super.key}) {
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          bodyLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          displayLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          displaySmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          headlineMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          headlineSmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          // titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          // titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          // bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          // labelSmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          // labelLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: _authService.user != null ? "/home" : "/login",
      routes: _navigationService.routes,
    );
  }
}
