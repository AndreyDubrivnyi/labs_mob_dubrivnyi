import 'dart:math';

import 'package:flutter/material.dart';

class Lab2 extends StatelessWidget {
  const Lab2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab2(title: 'Lab 2 Dubrivnyi Andriy'),
    );
  }
}

class MyLab2 extends StatefulWidget {
  const MyLab2({super.key, required this.title});

  final String title;

  @override
  State<MyLab2> createState() => _MyLab2PageState();
}

class _MyLab2PageState extends State<MyLab2> {
  bool _infoVisible = false;
  bool _answerVisible = false;
  bool _isButtonVisible = true;
  String _answer = "";

  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _aController = TextEditingController();

  void outputResponse() {
    getAnswer();
      setState(() {
        _answerVisible = true;
      });

  }
  void getInfo(){
    setState(() {
      _infoVisible = true;
      _isButtonVisible = false;
    });
  }
  bool getAnswer(){
    // Считывание и парсинг данных из контроллеров
    try {
      double x = double.parse(_xController.text);
      double y = double.parse(_yController.text);
      double a = double.parse(_aController.text);
      double result = calculateD(x, y, a);
      setState(() {
        _answer = "Answer is: $result";
      });
      return true;
    } catch (e) {
      _answer = "Incorrectly entered values";
      return false;
    }
  }
  double calculateD(double x, double y, double a) {
    double numerator = cos(pow(x, 3) + 6) - sin(y - a);
    double denominator = log(pow(x, 4)) - 2 * sin(pow(x, 5));
    if (denominator == 0) {
      throw Exception('Denominator cannot be zero');
    }
    return numerator / denominator;
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
            const Text(
              "Task option 7",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset('assets/images/lab2image.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _xController,
                decoration: const InputDecoration(
                  labelText: 'Enter x',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _yController,
                decoration: const InputDecoration(
                  labelText: 'Enter y',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _aController,
                decoration: const InputDecoration(
                  labelText: 'Enter a',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: _answerVisible,
              child: Text(
                _answer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  outputResponse();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(100, 30)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Click for answer",
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
                "My name is Andriy Dubrivnyi, I am a student at the Faculty of Computer Science, my group KН 20001Б",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _infoVisible,
              child: SizedBox(
                width: 250.0,
                height: 250.0,
                child: Image.asset('assets/images/lab2me.JPG'),
              ),
            ),
            Visibility(
              visible: _isButtonVisible,
              child: ElevatedButton(
                onPressed: getInfo,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(100, 30)),
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
  @override
  void dispose() {
    // Очистка контроллеров при уничтожении виджета
    _xController.dispose();
    _yController.dispose();
    _aController.dispose();
    super.dispose();
  }
}
