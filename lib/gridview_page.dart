import 'package:flutter/material.dart';

class GridviewPage extends StatelessWidget {
  const GridviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 6 ta department er icon ar naam
    var myItems = [
      {"icon": Icons.monitor_heart_outlined, "title": "Cardiology"},
      {"icon": Icons.psychology_outlined, "title": "Neurology"},
      {"icon": Icons.visibility_outlined, "title": "Eye"},
      {"icon": Icons.sentiment_satisfied_alt, "title": "Dental"},
      {"icon": Icons.child_friendly_outlined, "title": "Pediatrics"},
      {"icon": Icons.healing, "title": "Orthopedics"},
    ];

    return Scaffold(
      // Upor er wine bar, bame back arrow auto ashe
      appBar: AppBar(title: Text("Departments")),
      // 2 column er grid, protita department ekta tile
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: myItems.length,
        itemBuilder: (context, index) {
          // Ekta department er cream tile
          return Card(
            color: Color.fromARGB(255, 255, 246, 247),
            elevation: 3,
            shadowColor: Color.fromARGB(255, 212, 108, 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Upor er gulabi gol icon
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 212, 108, 140),
                  foregroundColor: Colors.white,
                  child: Icon(myItems[index]['icon'] as IconData),
                ),
                SizedBox(height: 8),
                // Niche department er naam
                Text(myItems[index]['title'] as String),
              ],
            ),
          );
        },
      ),
    );
  }
}
