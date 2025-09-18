import 'package:flower_app/features/checkout/data/models/order_items_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
 part 'order_DTO.g.dart';
@JsonSerializable()
class OrderDTO {
  String? user;
  List<OrderItemsDTO>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? sId;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? iV;

  OrderDTO(
      {this.user,
      this.orderItems,
      this.totalPrice,
      this.paymentType,
      this.isPaid,
      this.isDelivered,
      this.state,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.orderNumber,
      this.iV});

  factory OrderDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDTOFromJson(json);

  Map<String, dynamic> toJson() =>_$OrderDTOToJson(this);
}
