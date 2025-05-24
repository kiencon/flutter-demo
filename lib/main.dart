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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyHomePage(title: 'Lab 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<(String title, String img)> getMeatInformation() {
  return [
    ('BEEF', 'images/beef.jpg'),
    ('CHICKEN', 'images/chicken.jpg'),
    ('PORK', 'images/pork.jpg'),
    ('SEAFOOD', 'images/seafood.jpg'),
  ];
}

List<(String, String)> getCourseInformation() {
  return [
    ('Main Dishes', 'images/main-dishes.jpg'),
    ('Salad Recipes', 'images/salad.jpg'),
    ('Side Dishes', 'images/side-dishes.jpg'),
    ('Crockpot', 'images/crockpot.jpg'),
  ];
}

List<(String, String)> getDessertInformation() {
  return [
    ('Ice Cream', 'images/icecream.jpg'),
    ('Brownies', 'images/brownies.jpg'),
    ('Pies', 'images/pie.jpg'),
    ('Cookies', 'images/cookie.jpg'),
  ];
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> generateMeat() {
    var heading = 'BY MEAT';
    List<(String, String)> meatInformation = getMeatInformation();
    List<Stack> stacks =
        meatInformation
            .map(
              (data) => Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(data.$2),
                    radius: 40,
                  ),
                  Text(
                    data.$1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
            .toList();

    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          heading,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: stacks),
    ];
  }

  List<Widget> generateFood(
    String heading,
    List<(String, String)> informations,
  ) {
    List<Column> foodDetails =
        informations
            .map(
              (data) => Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(data.$2),
                    radius: 40,
                  ),
                  Text(data.$1),
                ],
              ),
            )
            .toList();
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          heading,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: foodDetails,
      ),
    ];
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
            Text(
              'BROWSE CATEGORIES',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(children: generateMeat()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: generateFood('BY COURSE', getCourseInformation()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: generateFood('BY DESSERT', getDessertInformation()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
