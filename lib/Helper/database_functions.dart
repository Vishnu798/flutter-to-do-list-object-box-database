import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/demo_object_box_model.dart';

final userBox = objectbox.store.box<ObjectBoxDemo>();
class DatabaseFun{
  addData(ObjectBoxDemo data){
   return  userBox.put(data);
  }

  getData(){
    return userBox.getAll();
  }

  updateData(){
    
  }
  getSingleData(int id){
    return userBox.get(id);
  }
  
}