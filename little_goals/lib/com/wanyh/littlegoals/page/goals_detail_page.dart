import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';

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
          title: Text(widget.myGoal.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  child: Text('删除'),
                  onPressed: () {
                    Navigator.pop(context, -1);
                  },
                ),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text('更新'),
                  onPressed: () {
                    Map<String, dynamic> args = {
                      'myGoal': widget.myGoal,
                      'from': 1
                    };
                    Navigator.pushNamed(context, CUSTOM_GOAL_PAGE,
                            arguments: args)
                        .then((onValue) {
                      if (onValue != null) {
                        Navigator.pop(context, onValue);
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }
}
