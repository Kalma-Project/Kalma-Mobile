import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Tes Kolom 1'),
                  ],
                ),
                Row(
                  children: [
                    Text('Tes Kolom 2')
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
