import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:infinistone/features/home/presentation/bloc/bookings_bloc.dart';
import 'package:infinistone/features/home/presentation/view_model/bookings_bloc.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background with gradient
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Bookings',
            style: TextStyle(color: Colors.white)), // White text in AppBar
        backgroundColor: Colors.black, // Black background for AppBar
        elevation: 0,
      ),
      body: BlocBuilder<BookingsBloc, BookingState>(
        builder: (context, state) {
          // Loading state
          if (state.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          else if (state.error != null) {
            return Center(
                child: Text('Error: ${state.error}',
                    style: const TextStyle(color: Colors.white, fontSize: 18)));
          }

          // Empty bookings state with a beautiful message
          else if (state.bookings.isEmpty ?? true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.bookmark_border,
                      size: 100, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'No bookings found yet!\nTry adding some.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Green button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    child: const Text(
                      'Add New Booking',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }

          // Display bookings in a beautiful card layout
          return ListView.builder(
            itemCount: state.bookings.length ?? 0,
            itemBuilder: (context, index) {
              BookingEntity booking = state.bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  title: Text(
                    'Customer ID: ${booking.customerId}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Product ID: ${booking.productId}\nDate: ${booking.bookingDate}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<BookingsBloc>()
                          .add(DeleteBooking(booking.bookingId ?? ''));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
