import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: dir.path);
    return ObjectBox._create(store);
  }
}
