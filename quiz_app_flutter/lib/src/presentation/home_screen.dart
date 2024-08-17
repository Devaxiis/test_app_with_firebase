import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/domain/db_connection.dart';
import 'package:quiz_app_flutter/src/domain/question_model.dart';
import 'package:quiz_app_flutter/src/utils/constants/app_colors.dart';
import 'package:quiz_app_flutter/src/utils/widgets/next_question_wg.dart';
import 'package:quiz_app_flutter/src/utils/widgets/option_card_wg.dart';
import 'package:quiz_app_flutter/src/utils/widgets/question_wg.dart';
import 'package:quiz_app_flutter/src/utils/widgets/result_box_wg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DBconnect();
  // List<Question> _options = [
  //   Question(
  //     id: "10",
  //     title: "What is 2 + 2 = ?",
  //     options: {
  //       "5": false,
  //       "4": true,
  //       "3": false,
  //       "6": false,
  //     },
  //   ),
  //   Question(
  //     id: "11",
  //     title: "What is 3 + 2 = ?",
  //     options: {
  //       "5": true,
  //       "4": false,
  //       "3": false,
  //       "6": false,
  //     },
  //   ),
  //   Question(
  //     id: "12",
  //     title: "What is 3 + 3 = ?",
  //     options: {
  //       "5": false,
  //       "4": false,
  //       "3": false,
  //       "6": true,
  //     },
  //   ),
  //   Question(
  //     id: "13",
  //     title: "What is 5 + 3 = ?",
  //     options: {
  //       "5": false,
  //       "4": false,
  //       "8": true,
  //       "6": false,
  //     },
  //   ),
  // ];
  late Future _options;

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  Future<List<Question>> getData() async {
    return db.fetchQuestion();
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          builder: (_) => ResultBoxWg(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              ));
    } else {
      if (isPressed == true) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please select any ansear.",
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      score = 0;
      index = 0;
      isAlreadySelected = false;
      isPressed = false;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _options = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _options as Future<List<Question>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: AppColors.backgroundCL,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundCL,
                shadowColor: Colors.transparent,
                title: const Text(
                  "Flutter quiz",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                          fontSize: 18, color: Color(0xffffffff)),
                    ),
                  )
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    QuestionWg(
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestion: extractedData.length),
                    const Divider(),
                    const SizedBox(height: 20),
                    for (int i = 0; i < extractedData[index].options.length; i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCardWg(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index].options.values.toList()[i] ==
                                      true
                                  ? AppColors.correctCL
                                  : AppColors.incorrectCL
                              : AppColors.neutralCL,
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10),
                child: NextQuestionWG(
                  onTab: ()=>nextQuestion(extractedData.length),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } 
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
      },
    );
  }
}
