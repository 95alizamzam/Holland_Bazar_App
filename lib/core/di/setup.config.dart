// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/auth/data/data_source/remote.dart' as _i3;
import '../../features/auth/data/repository/auth_repo_impl.dart' as _i5;
import '../../features/auth/domain/repository/base_auth_repo.dart' as _i4;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i10;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i14;
import '../../features/auth/presentation/blocs/login_bloc/login_bloc.dart'
    as _i26;
import '../../features/auth/presentation/blocs/verify_otp/verify_otp_bloc.dart'
    as _i30;
import '../../features/cart/data/data_source/remote.dart' as _i12;
import '../../features/cart/data/repository/cart_repo_impl.dart' as _i16;
import '../../features/cart/domain/repository/base_cart_repo.dart' as _i15;
import '../../features/cart/domain/usecases/add_item_to_cart.dart' as _i31;
import '../../features/cart/domain/usecases/change_item_quantity.dart' as _i19;
import '../../features/cart/domain/usecases/check_exsist_cart.dart' as _i20;
import '../../features/cart/domain/usecases/create_user_cart.dart' as _i21;
import '../../features/cart/domain/usecases/get_user_cart_items.dart' as _i25;
import '../../features/cart/domain/usecases/remove_item_from_cart.dart' as _i29;
import '../../features/cart/presentation/cart_bloc/bloc.dart' as _i32;
import '../../features/home/data/data_source/remote.dart' as _i13;
import '../../features/home/data/repository/home_repo_impl.dart' as _i18;
import '../../features/home/domain/repository/base_home_repo.dart' as _i17;
import '../../features/home/domain/usecases/get_categories.dart' as _i22;
import '../../features/home/domain/usecases/get_home_offers.dart' as _i23;
import '../../features/home/domain/usecases/get_home_product.dart' as _i24;
import '../../features/home/presentation/blocs/categories_bloc/bloc.dart'
    as _i33;
import '../../features/home/presentation/blocs/offers_bloc/bloc.dart' as _i27;
import '../../features/home/presentation/blocs/products_bloc/bloc.dart' as _i28;
import '../services/firebase/auth_services.dart' as _i8;
import '../services/firebase/cloud_firestore.dart' as _i6;
import '../services/firebase/storage_service.dart' as _i7;
import '../services/hive_config.dart' as _i9;
import '../services/navigation_services.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
        () => _i3.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i4.BaseAuthRepository>(
        () => _i5.AuthRepoImpl(remote: get<_i3.AuthRemoteDataSource>()));
    gh.lazySingleton<_i6.CloudFireStoreService>(
        () => _i6.CloudFireStoreService());
    gh.lazySingleton<_i7.FireBaseStorageService>(
        () => _i7.FireBaseStorageService());
    gh.lazySingleton<_i8.FirebaseAuthServices>(
        () => _i8.FirebaseAuthServices());
    gh.lazySingleton<_i9.HiveConfig>(() => _i9.HiveConfig());
    gh.lazySingleton<_i10.LoginUseCase>(
        () => _i10.LoginUseCase(repo: get<_i4.BaseAuthRepository>()));
    gh.lazySingleton<_i11.NavigationServices>(() => _i11.NavigationServices());
    gh.lazySingleton<_i12.RemoteCartDataSource>(
        () => _i12.RemoteCartDataSourceImpl());
    gh.lazySingleton<_i13.RemoteHomeDataSource>(
        () => _i13.RemoteHomeDataSourceImpl());
    gh.lazySingleton<_i14.VerifyOtpUseCase>(
        () => _i14.VerifyOtpUseCase(repo: get<_i4.BaseAuthRepository>()));
    gh.lazySingleton<_i15.BaseCartRepository>(
        () => _i16.CartRepoImpl(remote: get<_i12.RemoteCartDataSource>()));
    gh.lazySingleton<_i17.BaseHomeRepo>(
        () => _i18.HomeRepoImpl(remote: get<_i13.RemoteHomeDataSource>()));
    gh.lazySingleton<_i19.ChangeItemQuantityUseCase>(() =>
        _i19.ChangeItemQuantityUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.lazySingleton<_i20.CheckExsistCartUseCase>(() =>
        _i20.CheckExsistCartUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.lazySingleton<_i21.CreateUserCartUseCase>(
        () => _i21.CreateUserCartUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.lazySingleton<_i22.GetHomeCategoriesUseCase>(
        () => _i22.GetHomeCategoriesUseCase(repo: get<_i17.BaseHomeRepo>()));
    gh.lazySingleton<_i23.GetHomeOffersUseCase>(
        () => _i23.GetHomeOffersUseCase(repo: get<_i17.BaseHomeRepo>()));
    gh.lazySingleton<_i24.GetHomeProductsUseCase>(
        () => _i24.GetHomeProductsUseCase(repo: get<_i17.BaseHomeRepo>()));
    gh.lazySingleton<_i25.GetUserCartItemsUseCase>(() =>
        _i25.GetUserCartItemsUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.factory<_i26.LoginBloc>(
        () => _i26.LoginBloc(loginUseCase: get<_i10.LoginUseCase>()));
    gh.factory<_i27.OffersBloc>(() => _i27.OffersBloc(
        getHomeOffersUseCase: get<_i23.GetHomeOffersUseCase>()));
    gh.factory<_i28.ProductsBloc>(() => _i28.ProductsBloc(
        getHomeProductsUseCase: get<_i24.GetHomeProductsUseCase>()));
    gh.lazySingleton<_i29.RemoveItemFromCartUseCase>(() =>
        _i29.RemoveItemFromCartUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.factory<_i30.VerifyOtpBloc>(() =>
        _i30.VerifyOtpBloc(verifyOtpUseCase: get<_i14.VerifyOtpUseCase>()));
    gh.lazySingleton<_i31.AddItemToCartUseCase>(
        () => _i31.AddItemToCartUseCase(repo: get<_i15.BaseCartRepository>()));
    gh.factory<_i32.CartBloc>(() => _i32.CartBloc(
          checkExsistCartUseCase: get<_i20.CheckExsistCartUseCase>(),
          createUserCartUseCase: get<_i21.CreateUserCartUseCase>(),
          getUserCartItemsUseCase: get<_i25.GetUserCartItemsUseCase>(),
          addItemToCartUseCase: get<_i31.AddItemToCartUseCase>(),
          changeItemQuantityUseCase: get<_i19.ChangeItemQuantityUseCase>(),
          removeItemFromCartUseCase: get<_i29.RemoveItemFromCartUseCase>(),
        ));
    gh.factory<_i33.CategoriesBloc>(() => _i33.CategoriesBloc(
        getHomeCategoriesUseCase: get<_i22.GetHomeCategoriesUseCase>()));
    return this;
  }
}
