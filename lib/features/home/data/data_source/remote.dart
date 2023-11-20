import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/firebase/cloud_firestore.dart';
import 'package:tsc_app/features/home/data/models/category_model.dart';
import 'package:tsc_app/features/home/data/models/offer_model.dart';
import 'package:tsc_app/features/home/data/models/product_model.dart';

abstract class RemoteHomeDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<OfferModel>> getOffers();
  Future<List<CategoryModel>> getCategories();
}

@LazySingleton(as: RemoteHomeDataSource)
class RemoteHomeDataSourceImpl extends RemoteHomeDataSource {
  final cloudFirestore = getIt<CloudFireStoreService>();
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await cloudFirestore.getProducts();
    final List<ProductModel> result =
        response.map((e) => ProductModel.fromJson(e.data())).toList();

    return result;
  }

  @override
  Future<List<OfferModel>> getOffers() async {
    final response = await cloudFirestore.getOffers();
    final List<OfferModel> result =
        response.map((e) => OfferModel.fromJson(e.data())).toList();
    return result;
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await cloudFirestore.getCategories();
    final List<CategoryModel> result =
        response.map((e) => CategoryModel.fromJson(e.data())).toList();
    return result;
  }
}
