// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ShopView extends StatelessWidget {
//   ShopView({super.key});

//   final itemNameController = TextEditingController();
//   final itemTypeController = TextEditingController();

//   final _shopViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _shopViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: itemNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Item Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter item name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: itemNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Item Type',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter item type';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_shopViewFormKey.currentState!.validate()) {
//                     context.read<BatchBloc>().add(
//                           AddBatch(batchNameController.text),
//                         );
//                   }
//                 },
//                 child: const Text('Add Item'),
//               ),
//               const SizedBox(height: 10),
//               BlocBuilder<BatchBloc, BatchState>(builder: (context, state) {
//                 if (state.batches.isEmpty) {
//                   return const Center(child: Text('No Batches Added Yet'));
//                 } else if (state.isLoading) {
//                   return const CircularProgressIndicator();
//                 } else if (state.error != null) {
//                   return showMySnackBar(
//                     context: context,
//                     message: state.error!,
//                     color: Colors.red,
//                   );
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: state.batches.length,
//                       itemBuilder: (BuildContext context, index) {
//                         return ListTile(
//                           title: Text(state.batches[index].batchName),
//                           subtitle: Text(state.batches[index].batchId!),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context2) {
//                                   return AlertDialog(
//                                     title: const Text('Delete Batch'),
//                                     content: Text(
//                                         'Are you sure you want to delete ${state.batches[index].batchName} batch?'),
//                                     actions: [
//                                       TextButton(
//                                         child: const Text('Cancel'),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                       ),
//                                       TextButton(
//                                         child: const Text('Delete'),
//                                         onPressed: () {
//                                           context.read<BatchBloc>().add(
//                                                 DeleteBatch(
//                                                   state.batches[index].batchId!,
//                                                 ),
//                                               );

//                                           Navigator.of(context).pop();
//                                         },
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
