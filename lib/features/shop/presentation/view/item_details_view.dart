import 'dart:convert'; // Import for base64 decoding
import 'dart:typed_data'; // Import for Uint8List

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import for BlocProvider
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/presentation/view_model/shop_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for ShopBloc

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
      final prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getString('userId');

      DateTime selectedDate = DateTime.parse(_dateController.text);

      context.read<ShopBloc>().add(AddBooking(
            customerId!,
            widget.product.itemId!,
            selectedDate,
          ));

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
      print('Error booking appointment: $error');
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
    Uint8List? imageBytes;
    if (widget.product.itemImage != null &&
        widget.product.itemImage!.isNotEmpty) {
      try {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.product.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Product Price
              Text(
                "Price: Rs.${widget.product.itemPrice}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // Date Input
              TextField(
                controller: _dateController,
                style: const TextStyle(
                    color: Colors.white), // Set text color to white
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  labelStyle:
                      TextStyle(color: Colors.white), // White label text
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.white, // White icon
                  ),
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
                    backgroundColor: Colors.white, // Black background
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
                      color: Colors.black, // White text
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
