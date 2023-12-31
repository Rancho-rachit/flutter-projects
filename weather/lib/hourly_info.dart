import 'package:flutter/material.dart';

class Cardio extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;
  const Cardio(
      {super.key, required this.time, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(value)
          ]),
        ),
      ),
    );
  }
}
