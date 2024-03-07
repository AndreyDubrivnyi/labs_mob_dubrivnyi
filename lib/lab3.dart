import 'dart:io';
import 'dart:math';
import 'package:labs_mob_dubrivnyi/provider/ResultModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';


class Lab3 extends StatelessWidget {
  const Lab3({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab3(title: 'Lab 3 Dubrivnyi Andriy'),
    );
  }
}

class MyLab3 extends StatefulWidget {
  const MyLab3({super.key, required this.title});

  final String title;

  @override
  State<MyLab3> createState() => _MyLab3PageState();
}

class _MyLab3PageState extends State<MyLab3> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();
  String _fileContent = '';
  double calculateFunction(double x) {
    return cos(x);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tabulated_values.txt');
  }
  Future<File> writeValues(double start, double end, double step) async {
    final file = await _localFile;
    StringBuffer sb = StringBuffer();
    for (double x = start; x <= end; x += step) {
      double value = calculateFunction(x);
      sb.writeln('x: $x, f(x): $value');
    }
    return file.writeAsString(sb.toString());
  }

  Future<void> readValues() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      setState(() {
        _fileContent = contents;
      });
    } catch (e) {
      setState(() {
        _fileContent = 'Error: $e';
      });
    }
  }

  void performTabulation() async {
    double start = Provider.of<ResultModel>(context, listen: false).result;
    double end = double.tryParse(_endController.text) ?? 0;
    double step = double.tryParse(_stepController.text) ?? 0;

    await writeValues(start, end, step);
    await readValues();
  }
  @override
  Widget build(BuildContext context) {
    var result = Provider.of<ResultModel>(context).result;
    var startResult = "";
    if(result == 0.0){
      startResult = "You need to go to lab 2 then do the task";
    } else {
      startResult = result.toString();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Start of range"
            ),
            Text(
              startResult,
            ),
            TextField(
              controller: _endController,
              decoration: InputDecoration(labelText: 'End of Range'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _stepController,
              decoration: InputDecoration(labelText: 'Step'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            ElevatedButton(
              onPressed: performTabulation,
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
                  )
                ),
            ),
            SizedBox(height: 20),
            Text('Tabulated Values:'),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_fileContent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}