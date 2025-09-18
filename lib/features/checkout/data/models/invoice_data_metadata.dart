import 'package:json_annotation/json_annotation.dart';
part 'invoice_data_metadata.g.dart';

@JsonSerializable()
class InvoiceDataMetadata {
  final Map<String, dynamic> json;

  InvoiceDataMetadata({required this.json});

  factory InvoiceDataMetadata.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataMetadataToJson(this);
}
