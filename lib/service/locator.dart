import 'package:get_it/get_it.dart';
import 'package:souqy/service/Auth.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/storage_repo.dart';
import 'package:souqy/view_controller/user_controller.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<Auth>(Auth());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<FirestoreDatabase>(FirestoreDatabase());
  locator.registerSingleton<UserController>(UserController());
}
