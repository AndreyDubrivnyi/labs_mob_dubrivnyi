import 'package:flutter/material.dart';

class Lab6 extends StatelessWidget {
  const Lab6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab6(title: 'Independent work Dubrivnyi Andriy'),
    );
  }
}

class MyLab6 extends StatefulWidget {
  const MyLab6({super.key, required this.title});

  final String title;

  @override
  State<MyLab6> createState() => _MyLab1PageState();
}

class _MyLab1PageState extends State<MyLab6> {
  bool _infoVisible = false;
  bool _isButtonVisible = true;

  void giveInfo() {
    setState(() {
      _infoVisible = true;
      _isButtonVisible = false;
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
                  fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _isButtonVisible,
              child: ElevatedButton(
                onPressed: giveInfo,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 70)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Click for info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}