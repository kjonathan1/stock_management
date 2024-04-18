import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_management/firebase_options.dart';
import 'package:stock_management/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple, 
          brightness: Provider.of<ThemeProvider>(context).themeMode,
        ),
      ),
      // darkTheme: ThemeData(brightness: Brightness.light),
      initialRoute: "/home",
      routes: {
        // '/login' : (context) => Widget(),

        '/home': (context) => const HomePage(),
        // MyRoutes.homeRoute: (context) => const HomePage(),
       
      },
    );
  }
}
