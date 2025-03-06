import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No bookings found yet!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          // Sort bookings by date (most recent first)
          final sBookings = state.bookings.toList()
            ..sort((a, b) => b.bookingDate.compareTo(a.bookingDate));
          print('sortedBookings: $sBookings');
          // sbookings where userId == currentUserId
          final sortedBookings = sBookings;
          // Display bookings in a beautiful card layout
          return ListView.builder(
            itemCount: sortedBookings.length,
            itemBuilder: (context, index) {
              BookingEntity booking = sortedBookings[index];
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
                    'Item: ${booking.productId}', // Replace with item name if available
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date: ${booking.bookingDate}',
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
