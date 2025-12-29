import 'package:bizzie/bootstrap/bootstrap.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/config/firebase/firebase_options_dev.dart';

void main() async {
  await bootstrap(Environment.dev, DefaultFirebaseOptionsDev.currentPlatform);
}
