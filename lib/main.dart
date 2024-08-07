import 'package:flutter/material.dart';
import 'package:portfolio/Providers/NavBarProvider.dart';
import 'package:portfolio/screens/PortfolioScreens/Portfolio.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async{

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<NavBarProvider>( create: (context) => NavBarProvider()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      home:  Portfolio(),
    ),);
  }
}
