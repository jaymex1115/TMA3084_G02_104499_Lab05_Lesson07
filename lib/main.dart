import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

class TabModel extends ChangeNotifier {
  int selectedIndex = 0;

  void selectTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TabModel(), child: const LabAApp()),
  );
}

class LabAApp extends StatelessWidget {
  const LabAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab A - BottomNavigationBar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<TabModel>().selectedIndex;

    return Scaffold(
      appBar: AppBar(title: const Text('Lab A: Bottom Navigation')),
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) => context.read<TabModel>().selectTab(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
      ),
    );
  }
}
