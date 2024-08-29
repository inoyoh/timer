import 'dart:async';

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
      home: const MyHomePage(title: 'タイマー'),
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
  int _second = 0;
  // ?を入れると変数のデフォルトにnullが入る
  Timer? _timer;

  @override
  // initState: この画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();

    // 1秒ごとにカウントアップ
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _second++;
      });
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
          children: [
            Text(
              '$_second',
              style: TextStyle(fontSize: 100),
            ),
            ElevatedButton(
              onPressed: (){
                stop();
            },
              child: const Text('ストップ'),
            )
          ],
        ),
      ),
    );
  }

  void stop(){
    // 「?」をつけると「nullかも？」って意味。一方「!」をつけると「nullではない」と決めつける。
    _timer?.cancel();
  }

}
