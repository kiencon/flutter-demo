import 'package:flutter/material.dart';
import 'package:hello_world/data_repository.dart';
import 'package:hello_world/profile.dart';

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
        //'/': (context) => const MyApp(),
        '/profile': (context) => ProfilePage(),
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
  String _imagePath = 'assets/images/idea.png';

  final TextEditingController _usernameController = TextEditingController(
    text: '',
  );

  final TextEditingController _passwordController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadCredentials() async {
    String username = await DataRepository.getData('username');
    String password = await DataRepository.getData('password');

    if (!mounted) return;

    setState(() {
      _usernameController.text = username;
      _passwordController.text = password;
    });
    if (_usernameController.text != '' || _passwordController.text != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Username and password load from EncryptedSharedPreferences',
          ),
        ),
      );
    }
  }

  void _handleLogin() {
    setState(() {
      if (_passwordController.text == 'QWERTY123') {
        _imagePath = 'assets/images/idea.png';
        DataRepository.loginName = _usernameController.text;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Notification'),
              content: Text('Would like to save your username and password?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await DataRepository.saveData(
                      'username',
                      _usernameController.text,
                    );
                    await DataRepository.saveData(
                      'password',
                      _passwordController.text,
                    );

                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await DataRepository.removeData('username');
                    await DataRepository.removeData('password');

                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Text('No'),
                ),
              ],
            );
          },
        );
      } else if (_passwordController.text == '') {
        _imagePath = 'assets/images/question.png';
      } else {
        _imagePath = 'assets/images/stop.png';
      }
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(onPressed: _handleLogin, child: const Text('Login')),
            Image.asset(_imagePath, width: 300, height: 300, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
