import 'package:flutter/material.dart';
import 'dart:async';
import 'nextpage.dart';

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
  bool _isRunning = false;

  @override
  // initState: この画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();
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
                toggleTimer();
            },

              // 「_isRunning」がtrueの場合「ストップ」、falseの場合「スタート」
              child: Text(_isRunning ? 'ストップ' : 'スタート',
                style : TextStyle(
                  color: _isRunning ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                resetTimer();
              },

              // 「_isRunning」がtrueの場合「ストップ」、falseの場合「スタート」
              child: Text('リセット',
                style : TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer(){
    if (_isRunning) {
      // 「?」をつけると「nullかも？」って意味。一方「!」をつけると「nullではない」と決めつける。
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _second++;
        });

        if (_second == 10){
          resetTimer();
          _isRunning = false;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage()),
          );
        }

      });
    }
    // 「_isRunning」を切り替える。setStateで囲むことにより「State」に入ってる変数の変更が通知され、リビルド（更新）される。
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _second = 0;
      _isRunning = false;
    });

  }
}
