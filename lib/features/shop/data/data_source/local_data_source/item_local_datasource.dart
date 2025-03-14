// import 'package:infinistone/core/network/hive_service.dart';
// import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
// import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
// import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_data_source.dart';
// import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_hive_model.dart';
// import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

// class BatchLocalDataSource implements IItemDataSource {
//   final HiveService hiveService;

//   BatchLocalDataSource({required this.hiveService});

//   @override
//   Future<void> createBatch(ItemEntity batch) async {
//     try {
//       // Convert BatchEntity to BatchHiveModel
//       final batchHiveModel = ItemHiveModel.fromEntity(batch);
//       await hiveService.addBatch(batchHiveModel);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<void> deleteBatch(String id, String? token) async {
//     try {
//       await hiveService.deleteBatch(id);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<List<BatchEntity>> getBatches() {
//     try {
//       return hiveService.getAllBatches().then(
//         (value) {
//           return value.map((e) => e.toEntity()).toList();
//         },
//       );
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
