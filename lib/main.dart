import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const WaterReminderApp());
}

class WaterReminderApp extends StatelessWidget {
  const WaterReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterHomePage(),
    );
  }
}

class WaterHomePage extends StatefulWidget {
  const WaterHomePage({super.key});

  @override
  State<WaterHomePage> createState() => _WaterHomePageState();
}

class _WaterHomePageState extends State<WaterHomePage> {
  int cups = 0;
  int minutes = 60;
  Timer? timer;
  String message = "إشرب ميّة على مدار اليوم 💧";

  @override
  void initState() {
    super.initState();
    startReminder();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startReminder() {
    timer?.cancel();
    timer = Timer.periodic(Duration(minutes: minutes), (t) {
      setState(() {
        message = "حان وقت شرب الميّة! 💧";
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("خدلك كباية ميّة 💧"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void addCup() {
    setState(() {
      cups++;
      message = "برافو! شربت كباية 🥤";
    });
  }

  void changeMinutes(int m) {
    setState(() {
      minutes = m;
      message = "هيفكرك كل $minutes دقيقة.";
    });
    startReminder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Water Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              "$cups كوب اليوم",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: addCup,
              icon: const Icon(Icons.local_drink),
              label: const Text("أضف كوب"),
            ),
            const SizedBox(height: 24),
            const Text("اختر فترة التذكير:"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text("30 دقيقة"),
                  selected: minutes == 30,
                  onSelected: (_) => changeMinutes(30),
                ),
                ChoiceChip(
                  label: const Text("60 دقيقة"),
                  selected: minutes == 60,
                  onSelected: (_) => changeMinutes(60),
                ),
                ChoiceChip(
                  label: const Text("90 دقيقة"),
                  selected: minutes == 90,
                  onSelected: (_) => changeMinutes(90),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
