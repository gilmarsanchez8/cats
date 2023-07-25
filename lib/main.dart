import 'package:demo_cats/home.page.dart';
import 'package:demo_cats/providers/catProvider.provider.dart';
import 'package:demo_cats/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatProvider()),
      ],
      child: _materialApp(context),
    );
  }

  _materialApp(context){
    return MaterialApp(
      title: 'Cats',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRoutes.navigatorKey,
      routes: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}