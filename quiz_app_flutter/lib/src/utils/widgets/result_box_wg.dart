import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/utils/constants/app_colors.dart';

class ResultBoxWg extends StatelessWidget {
  const ResultBoxWg({super.key, required this.result, required this.questionLength, required this.onPressed});

  final int result;
  final int questionLength;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundCL,
      content: Padding(
          padding: const EdgeInsets.all(70),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Result",
                style: TextStyle(color: AppColors.neutralCL, fontSize: 20),
              ),
              const SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor:result == questionLength / 2
                ?Colors.yellow
                :result < questionLength /2
                ?AppColors.incorrectCL
                :AppColors.correctCL,
                radius: 50,
                child: Text("$result/$questionLength",style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.neutralCL
                ),),
              ),
              const SizedBox(height: 20),
              Text(result == questionLength / 2
              ? "Almost there"
              :result < questionLength/2
              ?"Try Again ?"
              :"Great!",
              style: const TextStyle(color: AppColors.neutralCL),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: onPressed,
                child: const Text("Start Over",style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  letterSpacing: 1.0
                ),),
              )
            ],
          )),
    );
  }
}
