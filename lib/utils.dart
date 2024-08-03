import 'package:get_it/get_it.dart';
import 'package:my_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat/services/auth_service.dart';
import 'package:my_chat/services/alart_service.dart';
import 'package:my_chat/services/media_service.dart';
import 'package:my_chat/services/storage_service.dart';
import 'package:my_chat/services/data_basa_servoce.dart';
import 'package:my_chat/services/navigation_service.dart';

Future stupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future RegisterServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AlartService>(
    AlartService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
   getIt.registerSingleton<StorageService>(
    StorageService(),
  );
   getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}
