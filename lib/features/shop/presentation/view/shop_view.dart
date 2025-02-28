import 'dart:convert'; // For base64 decoding

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/presentation/view_model/shop_bloc.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 1000; 

  // Function to check if the base64 string is valid
  bool isValidBase64(String base64String) {
    try {
      base64Decode(base64String);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Filter - Price Range Slider
            Row(
              children: [
                Text(
                    'Price: \$${_minPrice.toStringAsFixed(2)} - \$${_maxPrice.toStringAsFixed(2)}'),
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 1000,
                    divisions: 100,
                    labels: RangeLabels(
                      _minPrice.toStringAsFixed(2),
                      _maxPrice.toStringAsFixed(2),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Filtered List of Items
            Expanded(
              child: BlocBuilder<ShopBloc, ShopState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(child: Text("Error: ${state.error}"));
                  }

                  if (state.items.isEmpty) {
                    return const Center(child: Text("No items available"));
                  }

                  // Filter items based on search query and price range
                  List<ItemEntity> filteredItems = state.items.where((item) {
                    final itemNameMatch = item.itemName
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                    final itemPriceMatch = item.itemPrice >= _minPrice &&
                        item.itemPrice <= _maxPrice;
                    return itemNameMatch && itemPriceMatch;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      ItemEntity item = filteredItems[index];

                      // Check and remove the base64 prefix if present
                      String base64Image = item.itemImage ?? '';
                      if (base64Image.contains('data:image')) {
                        base64Image =
                            base64Image.split(',').last; // Remove the prefix
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: isValidBase64(base64Image)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      base64Decode(
                                          base64Image), // Decode base64 and display the image
                                      fit: BoxFit
                                          .cover, // Adjust the image's fit
                                      width: 50,
                                      height: 50,
                                    ),
                                  )
                                : const Icon(Icons.image_not_supported,
                                    size: 50,
                                    color: Colors
                                        .grey), // Placeholder if no valid image
                            title: Text(
                              item.itemName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              "Price: \$${item.itemPrice.toString()}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context
                                    .read<ShopBloc>()
                                    .add(DeleteItem(item.itemId ?? ''));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Item Page (you need to create this page)
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
