import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProviderPage extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestion = 10;
  final String difficultyLevel;

  List? question;
  int _currentQuestionCount = 0;
  int _correctCount = 0;

  BuildContext context;
  ProviderPage({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestion();
  }

  Future<void> _getQuestion() async {
    var response = await _dio.get(
      "",
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      },
    );
    var data = jsonDecode(
      response.toString(),
    );
    question = data['results'];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return question![_currentQuestionCount]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        question![_currentQuestionCount]["correct_answer"] == answer;
      _correctCount += isCorrect? 1 : 0;
    _currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestion) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            "Game has ended",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          content: Text("Score: $_correctCount/$_maxQuestion", style: TextStyle(fontSize: 25),),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
