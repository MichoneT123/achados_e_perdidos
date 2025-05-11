import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/AdminScrensWeb/PainelAdmin.dart';
import 'package:perdidos_e_achados/screens/ItemListScreen.dart';
import 'package:perdidos_e_achados/AdminScrensWeb/adminScreenLoginWeb.dart';
import 'package:perdidos_e_achados/screens/formItemScreen.dart';
import 'package:perdidos_e_achados/screens/feed_screen.dart';
import 'package:perdidos_e_achados/screens/login_screen.dart';
import 'package:perdidos_e_achados/screens/main_screen.dart';
import 'package:perdidos_e_achados/screens/profile_screen.dart';
import 'package:perdidos_e_achados/screens/registration_screen.dart';
import 'package:perdidos_e_achados/screens/responsiveLeyout.dart';
import 'package:perdidos_e_achados/screens/search_item_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost and Found App',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.blue)),
      initialRoute: '/',
      routes: {
        '/': (context) => const ResponsiveLayoutLoginScreen(
            mobileScaffold: LoginScreen(),
            desktopScaffold: AdminScreenLoginWeb()),
        '/registration': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
        '/add_item': (context) => const FormItemScreen(),
        '/search_item': (context) => SearchItemScreen(),
        '/feed': (context) => FeedScreen(),
        '/profile': (context) => ProfileScreen(),
        '/my-items': (context) => ItemListScreen(),
        '/admin': (context) => paineladminScreen()
      },
    );
  }
}
