import 'dart:convert'; // Import for base64 decoding
import 'dart:typed_data'; // Import for Uint8List

import 'package:flutter/material.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';

class ProductDetailView extends StatefulWidget {
  final ItemEntity product;

  const ProductDetailView({super.key, required this.product});

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final TextEditingController _dateController = TextEditingController();
  bool _isAppointmentBooked = false;

  Future<void> _bookAppointment() async {
    if (_dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isAppointmentBooked = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment booked successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to book the appointment. Try again!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decode the base64 image
    Uint8List? imageBytes;
    if (widget.product.itemImage != null &&
        widget.product.itemImage!.isNotEmpty) {
      try {
        // Remove the prefix if it exists
        String base64String = widget.product.itemImage!;
        if (base64String.contains(',')) {
          base64String = base64String.split(',').last;
        }
        imageBytes = base64Decode(base64String);
      } catch (e) {
        print('Error decoding base64 image: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text
          ),
        ),
        backgroundColor: Colors.black, // Black background
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white), // White back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          imageBytes,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        size: 250,
                        color: Colors.grey,
                      ),
              ),
              const SizedBox(height: 20),

              // Product Name
              Text(
                widget.product.itemName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Product Price
              Text(
                "Price: Rs.${widget.product.itemPrice}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Date Input
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true, // Prevent manual editing
                onTap: () async {
                  // Show date picker
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Book Appointment Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Black background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Book Appointment",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
