import "dart:io";

import "package:path/path.dart" show join;
import "package:path_provider/path_provider.dart"
    show getApplicationDocumentsDirectory;
import "package:app/objectbox.g.dart";

class AppObjectBox {
  /// The Store of this app.
  late final Store store;

  AppObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<AppObjectBox> create() async {
    final Directory docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final Store store =
        await openStore(directory: join(docsDir.path, "obx-golearningbd"));
    return AppObjectBox._create(store);
  }
}

late AppObjectBox appObjectBox;
