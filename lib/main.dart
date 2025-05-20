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
  String _username = '';
  String _password = '';
  String _imagePath = 'assets/images/idea.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: const InputDecoration(
              labelText: 'Login',
              border: OutlineInputBorder(),
            ),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_password == 'QWERTY123') {
                    _imagePath = 'assets/images/idea.png';
                  } else if (_password == '') {
                    _imagePath = 'assets/images/question.png';
                  } else {
                    _imagePath = 'assets/images/stop.png';
                  }
                });
              },
              child: const Text('Login'),
            ),
            Image.asset(
              _imagePath,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
