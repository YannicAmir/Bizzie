import 'package:bizzie/bootstrap/bootstrap.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/config/firebase/firebase_options_prod.dart';

void main() async {
  await bootstrap(Environment.prod, DefaultFirebaseOptionsProd.currentPlatform);
}
