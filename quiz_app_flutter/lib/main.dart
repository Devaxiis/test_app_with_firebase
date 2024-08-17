import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/app.dart';
import 'package:quiz_app_flutter/src/domain/db_connection.dart';
import 'package:quiz_app_flutter/src/domain/question_model.dart';

void main() {
  final db = DBconnect();
  // db.addQuestion(
  //     Question(id: "21", title: "What is this: 12 * 10", options: {
  //       "100":false,
  //       "112":false,
  //       "121":false,
  //       "120":true,
  //     }));
  db.fetchQuestion();
  runApp(const MyApp());
}
