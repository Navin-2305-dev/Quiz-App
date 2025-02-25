import 'package:flutter/material.dart';
import 'package:trivia/pages/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficulty = 0;
  final List<String> _difficultyLevel = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appTitle(),
                _Slider(),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          "Quiz App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyLevel[_currentDifficulty.toInt()],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _Slider() {
    return Slider(
      label: "Difficulty",
      min: 0,
      max: 2,
      divisions: 2,
      value: _currentDifficulty,
      onChanged: (value) {
        setState(() {
          _currentDifficulty = value;
          print(_currentDifficulty);
        });
      },
      secondaryActiveColor: Colors.purple,
      activeColor: Colors.blue,
    );
  }

  Widget _startButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return GamePage(
            difficultyLevel:
                _difficultyLevel[_currentDifficulty.toInt()].toLowerCase(),
          );
        }));
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.08,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
