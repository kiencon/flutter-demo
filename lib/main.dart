import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

class Item {
  static int count = 0;
  //properties
  final String name;
  final int quantity;
  int id = 0;

  Item(this.name, this.quantity) {
    id = Item.count++;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _itemController = TextEditingController(text: '');

  final TextEditingController _quantityController = TextEditingController(
    text: '',
  );

  final List<Item> _listItem = [];

  int count = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  _handleAddingItem() {
    setState(() {
      _listItem.add(
        Item(_itemController.text, int.parse(_quantityController.text)),
      );
    });
    _itemController.clear();
    _quantityController.clear();
  }

  _handleRemoveItem(int id) {
    setState(() {
      _listItem.removeWhere((item) => id == item.id);
    });
  }

  List<Widget> generateList() {
    return _listItem.asMap().entries.map((entry) {
      int index = entry.key;
      Item value = entry.value;
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
                      onPressed: () => _handleRemoveItem(value.id),
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
