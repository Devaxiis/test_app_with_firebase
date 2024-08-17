import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/utils/constants/app_colors.dart';

class NextQuestionWG extends StatelessWidget {
  const NextQuestionWG({super.key, required this.onTab});

  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.neutralCL,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: const Text("Next Question",textAlign: TextAlign.center,),
      ),
    );
  }
}