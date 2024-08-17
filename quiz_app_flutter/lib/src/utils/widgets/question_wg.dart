import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/utils/constants/app_colors.dart';

class QuestionWg extends StatelessWidget {
  const QuestionWg({super.key, required this.question, required this.indexAction, required this.totalQuestion});

  final String question;
  final int indexAction;
  final int totalQuestion;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,

      child: Text("Question ${indexAction + 1}/$totalQuestion: \n$question",
      style: const TextStyle(
        fontSize: 24,
        color: AppColors.neutralCL,
      ),),
    );
  }
}
