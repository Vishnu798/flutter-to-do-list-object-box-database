
import '../model/demo_object_box_model.dart';
import '../objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
 // late final Box<ObjectBoxDemo> myObject;
  
  ObjectBox._create(this.store);
    // Add any additional setup code, e.g. build queries.
   //   myObject = Box<ObjectBoxDemo>(store);
  
  
  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {

    final store = await openStore();
    return ObjectBox._create(store);
  }

}