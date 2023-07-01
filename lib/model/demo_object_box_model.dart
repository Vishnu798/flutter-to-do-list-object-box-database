import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectBoxDemo{
   @Id()
  int? id=0;
  String? name;
  String? age;
  ObjectBoxDemo({this.id,this.name,this.age});
}