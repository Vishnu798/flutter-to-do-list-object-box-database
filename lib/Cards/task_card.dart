import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Helper/database_functions.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/demo_object_box_model.dart';

class TaskCard extends StatefulWidget {
  final String data;
  final int taskNo;
  final String age;
  final int taskId;
   RxList<ObjectBoxDemo> myList = RxList();
   TaskCard({super.key, required this.data, required this.taskNo, required this.age,required this.myList, required this.taskId});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String name="";
  String age="";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 3),
      child: Container(
       // color: Colors.red,
       decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade500,width: 2),borderRadius: BorderRadius.circular(30)),
        height: MediaQuery.of(context).size.height*0.20,
        width: double.infinity,
        child: Column (mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text("Task ${widget.taskNo}",strutStyle: StrutStyle(leading:2),style: TextStyle(fontSize: 17),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text("Name : ${widget.data}"),
              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:8.0),
             child: Row(
              children: [
                Text("Age : ${widget.age}"),
              ],
                     ),
           ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
              IconButton(onPressed: ()async{
                var update = await DatabaseFun().getSingleData(widget.taskId);
                  bottomSheet(context,update);
              }, icon: Icon(Icons.edit)),
            IconButton.filledTonal(onPressed: ()async{
                await DatabaseFun().deleteTask(widget.taskId);
                widget.myList.value = await DatabaseFun().getData();
                
            }, icon: Icon(Icons.delete_forever,),splashColor: Colors.yellow,)
            ],),
          )
          
        ],)
      ),
    );
  }
   Future<dynamic> bottomSheet(BuildContext context,ObjectBoxDemo updatedData) {

    return showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SingleChildScrollView(
                    // reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    //  dragStartBehavior: DragStartBehavior.down,
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          //  width: 100,
                          child: TextField(
                           // controller: _nameEdit,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple.shade400,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 134, 47, 150),
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),

                                //  label: Text("Name"),
                                labelText: "enter the name"),
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          //  width: 100,
                          child: TextField(
                           // controller: _nameEdit,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple.shade400,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 134, 47, 150),
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),

                                //  label: Text("Name"),
                                labelText: "enter the age"),
                            onChanged: (value) {
                              age = value;
                            },
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            String updatedAge = updatedData.age=age;
                            String updatedName = updatedData.name=name;
                            var savedData = updatedData;

                              
                            await DatabaseFun().addData(savedData);
                            Navigator.pop(context);
                            // isDataAVailable.value=false;
                            // isDataAVailable.value=true;
                            // setState(() {

                            // });
                            widget.myList.value = await DatabaseFun().getData();
                          },
                          child: Text("Add Task"))
                    ]),
                  ),
                );
              });
  }
}