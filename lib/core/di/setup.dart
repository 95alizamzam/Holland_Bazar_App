import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
