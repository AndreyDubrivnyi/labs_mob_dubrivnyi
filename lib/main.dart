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
        useMaterial3: true,
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
  bool _infoVisible = false;

  void giveInfo() {
    setState(() {
      _infoVisible = true;
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
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Прізвище, ім'я та по батькові:\n Andriy Dubrivnyi \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Установка полужирного шрифта
                ),
              ), // Первая строка
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Назва спеціальності, на якій навчаєтесь:\nComputer Science \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Установка полужирного шрифта
                ),
              ), // Вторая строка
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Номер курсу і групи:\n 4 years, KH 20001Б \n ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  // Установка полужирного шрифта
                ),
              ),
            ),
            Visibility(
              visible: _infoVisible,
              child: const Text(
                "Чого хотіли би досягти в кінці цього \n навчального курсу:\nI want to improve my Flutter skills \n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Установка полужирного шрифта
                ),
              ),
            ),
            ElevatedButton(
              onPressed: giveInfo,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 70)),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Click for info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Установка полужирного шрифта
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
