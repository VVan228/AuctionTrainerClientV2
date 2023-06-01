import 'dart:convert';

import 'package:auction_trainer_client_v2/pages/login/impl/LoginPage.dart';
import 'package:auction_trainer_client_v2/pages/main/impl/MainPage.dart';
import 'package:auction_trainer_client_v2/security/api/AuthService.dart';
import 'package:auction_trainer_client_v2/security/api/MessagingService.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/requests/LoginRequest.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'inject_config/DependenciesConfiguration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: FlexThemeData.light(
          useMaterial3: true,
          scheme: FlexScheme.redWine,
          blendLevel: 2,
          appBarOpacity: 0.98,
          subThemesData: const FlexSubThemesData(
            inputDecoratorRadius: 8,
            inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
            inputDecoratorSchemeColor: SchemeColor.primary,
            inputDecoratorBackgroundAlpha: 0x18,
            inputDecoratorUnfocusedHasBorder: false,
            appBarScrolledUnderElevation: 6,
            popupMenuOpacity: 0.96,
            bottomNavigationBarOpacity: 0.96,
            navigationBarOpacity: 0.96,
            navigationRailOpacity: 0.96,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // Custom fonts to demonstrate you pass a default GoogleFonts TextTheme
          // to both textTheme and primaryTextTheme in M2/M3 mode as well as in
          // light/dark theme and have them get correct default color and
          // contrast color in all cases. Vanilla ThemeData does not do this.
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: GoogleFonts.notoSansTextTheme(),
          primaryTextTheme: GoogleFonts.notoSansTextTheme(),
        ),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(
          useMaterial3: true,
          scheme: FlexScheme.redWine,
          blendLevel: 2,
          appBarOpacity: 0.98,
          subThemesData: const FlexSubThemesData(
            inputDecoratorRadius: 8,
            inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
            inputDecoratorSchemeColor: SchemeColor.primary,
            inputDecoratorBackgroundAlpha: 0x18,
            inputDecoratorUnfocusedHasBorder: false,
            appBarScrolledUnderElevation: 6,
            popupMenuOpacity: 0.96,
            bottomNavigationBarOpacity: 0.96,
            navigationBarOpacity: 0.96,
            navigationRailOpacity: 0.96,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          // Custom fonts to demonstrate you pass a default GoogleFonts TextTheme
          // to both textTheme and primaryTextTheme in M2/M3 mode as well as in
          // light/dark theme and have them get correct default color and
          // contrast color in all cases. Vanilla ThemeData does not do this.
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: GoogleFonts.notoSansTextTheme(),
          primaryTextTheme: GoogleFonts.notoSansTextTheme(),
        ),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.system,

        home: const StateCheck());
  }
}

class StateCheck extends StatelessWidget {
  const StateCheck({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var isLogged = getIt<TokenService>().isLogged();

    return FutureBuilder<bool>(
      future: isLogged,
      builder: (context, snapshot) {
        bool logged = snapshot.data ?? false;
        if(logged) {
          return MainPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
