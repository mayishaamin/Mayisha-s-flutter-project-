import 'package:flutter/material.dart';
import 'package:medicore_app/auth/auth_gate.dart';
import 'package:medicore_app/supabase_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData().textTheme.apply(
          bodyColor: Color.fromARGB(255, 155, 49, 96),
          displayColor: Color.fromARGB(255, 155, 49, 96),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 251, 179, 187),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 155, 49, 96),
          foregroundColor: Color.fromARGB(255, 251, 179, 187),
          titleTextStyle: TextStyle(
            fontFamily: 'serif',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 251, 179, 187),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Color.fromARGB(255, 212, 108, 140),
          suffixIconColor: Color.fromARGB(255, 212, 108, 140),
          labelStyle: TextStyle(color: Color.fromARGB(255, 212, 108, 140)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color.fromARGB(255, 212, 108, 140)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 155, 49, 96),
              width: 2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 201, 95),
            foregroundColor: Color.fromARGB(255, 155, 49, 96),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: AuthGate(),
    );
  }
}