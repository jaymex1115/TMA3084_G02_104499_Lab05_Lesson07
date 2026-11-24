import 'package:flutter/material.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({
    super.key,
    required this.make,
    required this.model,
    required this.price,
    this.serviceNote,
  });

  final String make;
  final String model;
  final double price;
  final String? serviceNote;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool _isReserved = false;

  @override
  Widget build(BuildContext context) {
    final note = widget.serviceNote?.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Car details')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.make} ${widget.model}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Text('Make: ${widget.make}'),
                    const SizedBox(height: 8),
                    Text('Model: ${widget.model}'),
                    const SizedBox(height: 8),
                    Text('Price: ${_formatPrice(widget.price)}'),
                    if (note != null && note.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Service note',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(note),
                    ],
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () =>
                          setState(() => _isReserved = !_isReserved),
                      icon: Icon(
                        _isReserved ? Icons.check_circle : Icons.bookmark,
                      ),
                      label: Text(
                        _isReserved ? 'Reserved' : 'Mark as Reserved',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) =>
      '\$${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)}';
}
