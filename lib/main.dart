import 'package:flutter/material.dart';

import 'memesite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memophobia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Memophobia!',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              'Here you may fetch photo ideas for your meme',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: GestureDetector(
                onTap: (){Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const MemePage()));},
                child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue[100]),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Get your meme idea",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
