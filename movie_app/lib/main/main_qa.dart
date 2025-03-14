import 'package:movie_app/core/config/flavors.dart';
import '../init.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.qa;
  await runner.init();
}
