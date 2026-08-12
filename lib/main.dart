import 'package:flutter/material.dart';
import 'package:smart_app/config/router/app_router.dart';
import 'package:smart_app/config/theme/app_theme.dart';
import 'package:smart_app/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mis Peliculas',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
//flutter pub upgrade