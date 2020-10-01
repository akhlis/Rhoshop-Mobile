import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/models/app_locale.dart';
import 'package:rhoshop/screens/all.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/app_theme.dart';
import 'package:rhoshop/utils/routes.dart' as Routes;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  var localeCode = prefs.getString('locale');
  if (localeCode == null) {
    localeCode = Platform.localeName.split('_').first;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLocale>(
          create: (context) => AppLocale(localeCode),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
      ],
      child: RhoshopApp(),
    ),
  );
}

class RhoshopApp extends StatefulWidget {
  @override
  _RhoshopAppState createState() => _RhoshopAppState();
}

class _RhoshopAppState extends State<RhoshopApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    );

    Provider.of<Cart>(context, listen: false).load();

    return Consumer<AppLocale>(
      builder: (context, appLocale, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalization.of(context).appTitle,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: WithoutGlowScrollBehavior(),
            child: child,
          );
        },
        localizationsDelegates: [
          const AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: AppLocalizationDelegate.supportedLocaleCodes.map(
          (code) => Locale(code, ''),
        ),
        locale: appLocale.locale,
        initialRoute: Routes.intro,
        routes: {
          Routes.intro: (context) => IntroScreen(),
          Routes.signIn: (context) => SignInScreen(),
          Routes.signUp: (context) => SignUpScreen(),
          Routes.home: (context) => HomeScreen(),
          Routes.category: (context) =>
              CategoryScreen(ModalRoute.of(context).settings.arguments),
          Routes.notifications: (context) => NotificationsScreen(),
          Routes.product: (context) =>
              ProductScreen(ModalRoute.of(context).settings.arguments),
          Routes.cart: (context) => CartScreen(),
          Routes.orderConfirmation: (context) => OrderConfirmationScreen(),
          Routes.settings: (context) => SettingsScreen(),
          Routes.myOrders: (context) => MyOrdersScreen(),
          Routes.profile: (context) => ProfileScreen(),
        },
        theme: ThemeData(
          primaryColor: AppColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: AppColors.primaryText,
              fontSize: 46,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
            headline2: TextStyle(
              color: AppColors.primaryText,
              fontSize: 28,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
            headline3: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
            headline4: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
            subtitle2: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
            bodyText1: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
            bodyText2: TextStyle(
              color: AppColors.descriptionText,
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
            button: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
