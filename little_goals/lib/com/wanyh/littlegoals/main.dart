import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/page/goals_detail_page.dart';
import 'package:little_goals/com/wanyh/littlegoals/page/goals_list_page.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';

import 'page/add_goals_page.dart';
import 'page/custom_goal_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Goals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        ADD_GOALS_PAGE: (context) => AddGoalsPage(),
        CUSTOM_GOAL_PAGE: (context) =>
            CustomPage(myArgs: ModalRoute.of(context).settings.arguments),
        GOALS_DETAIL_PAGE: (context) => GoalsDetailPage(
            myGoal: ModalRoute.of(context).settings.arguments),
      },
      home: MyHomePage(),
    );
  }
}
