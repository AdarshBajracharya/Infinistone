import 'package:infinistone/features/shop/data/model/item_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_item_dto.g.dart';

@JsonSerializable()
class GetAllItemDTO {
  final bool success;
  final int count;
  final List<ItemApiModel> data;

  GetAllItemDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllItemDTOToJson(this);

  factory GetAllItemDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllItemDTOFromJson(json);
}