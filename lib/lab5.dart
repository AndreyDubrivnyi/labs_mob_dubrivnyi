import 'dart:async';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:math' as math;
class Lab5 extends StatelessWidget {
  const Lab5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLab5(title: 'Lab 5 Dubrivnyi Andriy'),
    );
  }
}

class MyLab5 extends StatefulWidget {
  const MyLab5({super.key, required this.title});

  final String title;

  @override
  State<MyLab5> createState() => _MyLab5PageState();
}

class _MyLab5PageState extends State<MyLab5> {
  List<File> images = [];
  int currentIndex = 0;
  double rotationAngle = 0.0;
  Timer? _timer;
  bool isAutoPlay = false;

  void startAutoPlay() {
    const period = Duration(seconds: 1); // Задайте бажаний час для автоперегляду
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
    isAutoPlay = true;
  }

  void stopAutoPlay() {
    _timer?.cancel();
    isAutoPlay = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(isAutoPlay ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (isAutoPlay) {
                stopAutoPlay();
              } else {
                startAutoPlay();
              }
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              children: [
                const Text('Розробник: Дубрівний Андрій'),
                Image.asset('assets/images/lab2me.JPG'), // Забезпечте шлях до вашого зображення
              ],
            ),
          ),
        ],
      ),
      body: images.isEmpty
          ? Center(child: Text('Оберіть папку з картинками'))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InteractiveViewer(
                panEnabled: true, // Дозволяє панорамування
                boundaryMargin: EdgeInsets.all(80),
                minScale: 0.1,
                maxScale: 4.0,
                child: Transform.rotate(
                  angle: rotationAngle,
                  child: Image.file(images[currentIndex]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.rotate_left),
                  onPressed: () => setState(() {
                    rotationAngle -= math.pi / 2; // Обертаємо на 90 градусів вліво
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: images.length > 1 ? showPreviousImage : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: images.length > 1 ? showNextImage : null,
                ),
                IconButton(
                  icon: Icon(Icons.rotate_right),
                  onPressed: () => setState(() {
                    rotationAngle += math.pi / 2; // Обертаємо на 90 градусів вправо
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.image,
            dialogTitle: 'Оберіть зображення для перегляду',
          );

          if (result != null) {
            setState(() {
              images = result.paths.map((path) => File(path!)).toList();
              currentIndex = 0;
              rotationAngle = 0; // Скидуємо кут обертання при виборі нових зображень
            });
          }
        },
        child: const Icon(Icons.folder_open),
      ),
    );
  }

  void showPreviousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void showNextImage() {
    if (currentIndex < images.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }
}
