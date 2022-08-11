import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Check Signal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Check Signal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //var donde se guarda el estado de la red
  String _signal = "";
  //int _counter = 0;
  //retornar futuro tipo de senal en este instante
  Future<ConnectivityResult> _getSignalType() {
    return (Connectivity().checkConnectivity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),Tipo de red al presionar boton
            Text(
              _signal,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var cr = await _getSignalType();
          setState(() {
            if (cr == ConnectivityResult.wifi) {
              _signal = "WiFi";
            } else if (cr == ConnectivityResult.mobile) {
              _signal = "Mobile";
            } else {
              _signal = "No Signal";
            }
          });
        },
        tooltip: 'Check',
        child: const Icon(Icons.wifi_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
