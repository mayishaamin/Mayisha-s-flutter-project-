import 'package:flutter/material.dart';
import 'package:medicore_app/Converter_page.dart';
import 'package:medicore_app/GridView_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _supabase = Supabase.instance.client;

  // 4 ta tile er ekta box (icon + naam), 4 bar eta-i use hobe
  Widget tile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Color.fromARGB(255, 255, 246, 247),
      elevation: 3,
      shadowColor: Color.fromARGB(255, 212, 108, 140),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 212, 108, 140),
              foregroundColor: Colors.white,
              child: Icon(icon),
            ),
            SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Upor er wine bar: bame MediCore, dane search ar logout
      appBar: AppBar(
        title: Text("MediCore"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              _supabase.auth
                  .signOut(); // logout korle AuthGate Login e niye jabe
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // Niche dan kone holud call button (emergency number dekhay)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Emergency: 999 | Hotline: 16263")),
          );
        },
        backgroundColor: Color.fromARGB(255, 255, 201, 95),
        foregroundColor: Color.fromARGB(255, 155, 49, 96),
        shape: CircleBorder(),
        tooltip: "Emergency",
        child: Icon(Icons.call),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Upor er boro lekha
            Text(
              "Smart Hospital Management System",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 255, 246, 247),
              ),
            ),
            SizedBox(height: 10),

            // 4 ta tile er grid (2 column)
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                // Doctors: page nai, tai khali
                tile(Icons.medical_services_outlined, "Doctors", () {}),
                // Departments: Departments page e jabe
                tile(Icons.apartment, "Departments", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GridviewPage()),
                  );
                }),
                // Payment: Bill Converter page e jabe
                tile(Icons.credit_card, "Payment", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConverterPage()),
                  );
                }),
                // My Records: page nai, tai khali
                tile(Icons.description_outlined, "My Records", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}