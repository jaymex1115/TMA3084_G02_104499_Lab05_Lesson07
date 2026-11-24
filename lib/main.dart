import 'package:flutter/material.dart';

void main() {
  runApp(const LabBApp());
}

class LabBApp extends StatelessWidget {
  const LabBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab B - Sortable DataTable',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const CarDataTableScreen(),
    );
  }
}

class Car {
  final String make;
  final String model;
  final int price;

  Car({required this.make, required this.model, required this.price});
}

class CarDataTableScreen extends StatefulWidget {
  const CarDataTableScreen({super.key});

  @override
  State<CarDataTableScreen> createState() => _CarDataTableScreenState();
}

class _CarDataTableScreenState extends State<CarDataTableScreen> {
  int? _sortColumnIndex;
  bool _isAscending = true;

  final List<Car> _cars = [
    Car(make: 'Perodua', model: 'Axia', price: 38600),
    Car(make: 'Proton', model: 'Saga', price: 34800),
    Car(make: 'Honda', model: 'City', price: 84900),
    Car(make: 'Toyota', model: 'Vios', price: 89600),
    Car(make: 'Mazda', model: 'CX-5', price: 144469),
  ];

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      if (columnIndex == 0) {
        _cars.sort(
          (a, b) =>
              ascending ? a.make.compareTo(b.make) : b.make.compareTo(a.make),
        );
      } else if (columnIndex == 1) {
        _cars.sort(
          (a, b) => ascending
              ? a.model.compareTo(b.model)
              : b.model.compareTo(a.model),
        );
      } else if (columnIndex == 2) {
        _cars.sort(
          (a, b) => ascending
              ? a.price.compareTo(b.price)
              : b.price.compareTo(a.price),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab B: Car Inventory DataTable')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _isAscending,
          columns: [
            DataColumn(
              label: const Text(
                'Car Make',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onSort: _onSort,
            ),
            DataColumn(
              label: const Text(
                'Model',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onSort: _onSort,
            ),
            DataColumn(
              label: const Text(
                'Price (RM)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              numeric: true,
              onSort: _onSort,
            ),
          ],
          rows: _cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model)),
                DataCell(Text(car.price.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
