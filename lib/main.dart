import 'package:flutter/material.dart';

import 'car_detail_screen.dart';

void main() => runApp(const CarInventoryApp());

class CarInventoryApp extends StatelessWidget {
  const CarInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Inventory',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const CarInventoryScreen(),
    );
  }
}

class CarInventoryScreen extends StatelessWidget {
  const CarInventoryScreen({super.key});

  static const _cars = <_Car>[
    _Car(
      make: 'Toyota',
      model: 'Camry',
      price: 28900,
      serviceNote: 'Service due in 2 months.',
    ),
    _Car(make: 'Honda', model: 'Civic', price: 26400),
    _Car(
      make: 'Tesla',
      model: 'Model 3',
      price: 38990,
      serviceNote: 'Recently serviced.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Inventory')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Make')),
            DataColumn(label: Text('Model')),
            DataColumn(label: Text('Price')),
          ],
          rows: _cars
              .map(
                (car) => DataRow(
                  onSelectChanged: (selected) {
                    if (selected != true) return;
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => CarDetailScreen(
                          make: car.make,
                          model: car.model,
                          price: car.price,
                          serviceNote: car.serviceNote,
                        ),
                      ),
                    );
                  },
                  cells: [
                    DataCell(Text(car.make)),
                    DataCell(Text(car.model)),
                    DataCell(Text('\$${car.price.toStringAsFixed(0)}')),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _Car {
  const _Car({
    required this.make,
    required this.model,
    required this.price,
    this.serviceNote,
  });

  final String make;
  final String model;
  final double price;
  final String? serviceNote;
}
