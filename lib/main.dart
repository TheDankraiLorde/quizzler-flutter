import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = <Icon>[];
  List<Question> qx = <Question>[
    Question(
      q: "You can lead a cow down stairs but not up stairs.",
      a: false,
    ),
    Question(
      q: "Approximately one quarter of human bones are in the feet.",
      a: true,
    ),
    Question(
      q: "A slug\'s blood is green.",
      a: true,
    ),
  ];
  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  qx[questionNumber % qx.length].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  bool corrAns = qx[questionNumber % qx.length].quesAns;
                  addIcon(iconVal: (corrAns == true));
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    bool corrAns = qx[questionNumber % qx.length].quesAns;
                    addIcon(iconVal: corrAns == false);
                  });
                },
              ),
            ),
          ),
          Row(children: scoreKeeper)
        ],
      ),
    );
  }

  void addIcon({bool iconVal}) {
    setState(() {
      if (questionNumber < qx.length - 1) {
        scoreKeeper.add(Icon(
          (iconVal ? (Icons.check) : (Icons.close)),
          color: (iconVal ? Colors.green : Colors.red),
        ));
        questionNumber++;
      } else {
        Alert(
          context: context,
          title: "Questions Exhausted!",
          desc: "The questions will start from the beginning again.",
          buttons: [
            DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ).show();
        questionNumber = 0;
        scoreKeeper.clear();
      }
    });
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
