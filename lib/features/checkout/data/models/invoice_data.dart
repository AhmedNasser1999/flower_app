import 'package:json_annotation/json_annotation.dart';
import 'invoice_data_metadata.dart';

part 'invoice_data.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceData {
  @JsonKey(name: "account_tax_ids")
  final dynamic accountTaxIds;

  @JsonKey(name: "custom_fields")
  final dynamic customFields;

  final dynamic description;
  final dynamic footer;
  final dynamic issuer;
  final InvoiceDataMetadata? metadata;

  @JsonKey(name: "rendering_options")
  final dynamic renderingOptions;

  InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}
