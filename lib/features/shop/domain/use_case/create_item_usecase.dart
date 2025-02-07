// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';


// class CreateItemParams extends Equatable {
//   final String itemName;
//   final String itemType;
//   final String? itemImage;

//   const CreateItemParams({required this.itemName});

//   // Empty constructor
//   const CreateBatchParams.empty() : batchName = '_empty.string';

//   @override
//   List<Object?> get props => [batchName];
// }

// class CreateBatchUseCase implements UsecaseWithParams<void, CreateBatchParams> {
//   final IBatchRepository batchRepository;

//   CreateBatchUseCase({required this.batchRepository});

//   @override
//   Future<Either<Failure, void>> call(CreateBatchParams params) async {
//     return await batchRepository.createBatch(
//       BatchEntity(
//         batchName: params.batchName,
//       ),
//     );
//   }
// }
