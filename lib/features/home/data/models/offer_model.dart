import 'package:json_annotation/json_annotation.dart';
import 'package:tsc_app/features/home/domain/entities/offer.dart';
part 'offer_model.g.dart';

@JsonSerializable(createToJson: false)
class OfferModel {
  final int id;
  final String imageUrl;
  OfferModel({required this.id, required this.imageUrl});

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);
}

extension OfferModelExt on OfferModel {
  Offer toDomain() {
    return Offer(
      id: id,
      imageUrl: imageUrl,
    );
  }
}
