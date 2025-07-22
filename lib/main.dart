import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/dao/todoDAO.dart';

import 'database.dart';
import 'entity/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        //'/profile': (context) => ProfilePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _itemController = TextEditingController(text: '');

  final TextEditingController _quantityController = TextEditingController(
    text: '',
  );

  AppDatabase? database = null;

  Future<void> initDB() async {
    if (database == null) {
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    }
  }

  List<Todo> _listItem = [];

  int count = 100;

  @override
  void initState() {
    super.initState();
    initTodoList();
  }

  Future<void> initTodoList() async {
    await initDB();
    var items = await database?.todoDAO.findAllTodo();
    print("debug=====");
    print(items);
    setState(() {
      _listItem = items!;
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _handleAddingItem() async {
    await initDB();
    var item = Todo(
        null,
        _itemController.text,
        int.parse(_quantityController.text)
    );
    await database?.todoDAO.insertPerson(item);
    setState(() {
      _listItem.add(
        item,
      );
    });
    _itemController.clear();
    _quantityController.clear();
  }

  Future<void> _handleRemoveItem(int id) async {
    var item = _listItem.firstWhere((item) => id == item.id);
    print("item ${item.id} ${item.name}");
    await database?.todoDAO.deletePerson(item);
    setState(() {
      initTodoList();
    });
  }

  List<Widget> generateList() {
    return _listItem.asMap().entries.map((entry) {
      int index = entry.key;
      var value = entry.value;
      return GestureDetector(
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _handleRemoveItem(value.id ?? 0),
                      child: const Text('Yes'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('No'),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
            ),
          );
          // You can show a dialog, delete an item, etc.
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              '${index + 1} ${value.name} quantity: ${value.quantity}',
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _itemController,
                decoration: const InputDecoration(
                  labelText: 'type the item here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'type the quantity here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleAddingItem,
              child: const Text('Click here'),
            ),
            Expanded(child: ListView(children: generateList())),
          ],
        ),
      ),
    );
  }
}
