import 'package:flutter/material.dart';
import 'package:little_goals/db/goals_helper.dart';
import 'package:little_goals/utils/colors.dart';
import 'package:little_goals/utils/const.dart';

class AddGoalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddGoalsPageState();
  }
}

class AddGoalsPageState extends State<AddGoalsPage> {
  _enterCustomPage(LittleGoal goal) {
    Map<String, dynamic> args = {'myGoal': goal, 'from': 0};
    Navigator.of(context)
        .pushNamed(CUSTOM_GOAL_PAGE, arguments: args)
        .then((onValue) {
      if (onValue != null) {
        Navigator.of(context).pop(onValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LittleGoal littleGoal1 = LittleGoal();
    littleGoal1.imageUrl = 'images/sleep.png';
    littleGoal1.name = '早睡';
    LittleGoal littleGoal2 = LittleGoal();
    littleGoal2.imageUrl = 'images/reading.png';
    littleGoal2.name = '学习';
    LittleGoal littleGoal3 = LittleGoal();
    littleGoal3.imageUrl = 'images/sports.png';
    littleGoal3.name = '运动';
    LittleGoal littleGoal4 = LittleGoal();
    littleGoal4.imageUrl = 'images/custom_goal.png';
    littleGoal4.name = '自定义';
    List<LittleGoal> goals = [
      littleGoal1,
      littleGoal2,
      littleGoal3,
      littleGoal4
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Little Goals'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.0),
        itemCount: goals.length,
        itemBuilder: (context, index) {
          double rightMargin = index % 3 == 2 ? 8.0 : 0;
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.backNor,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(8.0, 8.0, rightMargin, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(goals[index].imageUrl),
                    width: 60,
                  ),
                  Text(goals[index].name)
                ],
              ),
            ),
            onTap: () => _enterCustomPage(goals[index]),
          );
        },
      ),
    );
  }
}
