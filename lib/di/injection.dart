import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',

  // Security Feature
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies(String environment) =>
    getIt.init(environment: environment);
