import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Cards/task_card.dart';
import 'package:to_do_list/Helper/database_functions.dart';
import 'package:to_do_list/model/demo_object_box_model.dart';

import 'Helper/database_helper.dart';

late ObjectBox objectbox;
Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameEdit = TextEditingController();
  String name = "";
  String age = "";

  RxBool isDataAVailable = false.obs;
  RxList<ObjectBoxDemo> taskList = RxList();
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    taskList.value = await DatabaseFun().getData();
    if (taskList.isNotEmpty) {
      isDataAVailable.value = true;
    }
    // else{
    //   isDataAVailable.value = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: isDataAVailable.value
            ? Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                          itemCount: taskList.value.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              data: taskList.value[index].name.toString(),
                              taskNo: index+1,
                              age: taskList[index].age.toString(),
                              myList: taskList,
                              taskId: taskList[index].id!,
                            );
                          }),
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                "You Don't have any Tasks yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
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
                            controller: _nameEdit,
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
                            var savedData =
                                ObjectBoxDemo(name: name, age: age);
                            await DatabaseFun().addData(savedData);
                            Navigator.pop(context);
                            // isDataAVailable.value=false;
                            // isDataAVailable.value=true;
                            // setState(() {

                            // });
                            taskList.value = await DatabaseFun().getData();
                          },
                          child: Text("Add Task"))
                    ]),
                  ),
                );
              });
  }
}
