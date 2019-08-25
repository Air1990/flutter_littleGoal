import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';


class GoalsDetailPage extends StatefulWidget {
  final LittleGoal myGoal;

  GoalsDetailPage({@required this.myGoal});

  @override
  State<StatefulWidget> createState() {
    return _GoalDetailPageState();
  }
}

class _GoalDetailPageState extends State<GoalsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Goal\' Detail'),
      ),
      body: Container(),
    );
  }
}
