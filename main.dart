import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Este widget es la raíz de la aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final name = TextEditingController();
  String nameFormPref = "username";
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //Caragr automaticamente
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
            ),
            const Divider(),
            Text(nameFormPref),
            TextField(
              controller: name,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
            ),
            ElevatedButton(
                child: const Text("Guardar"),
                onPressed: () {
                  savedName();
                }),
            ElevatedButton(
                child: const Text("Cargar"),
                onPressed: () {
                  getName();
                }),
          ],
        ),
      ),
      // Esta coma final hace que el formateo automático sea más agradable para los métodos de compilación.
    );
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameFormPref = prefs.getString("username") ?? "Vacio";
    });
  }

  void savedName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", name.text);
    name.clear();
  }
}
