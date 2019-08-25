import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/record_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';

class GoalGridView extends Container {
  GoalGridView(this.myGoals, this.callback);

  final List<LittleGoal> myGoals;
  final Function callback;
  final int rowCount = 3;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowCount, childAspectRatio: 1.0),
      itemCount: myGoals.length,
      itemBuilder: (context, index) {
        double rightMargin = index % rowCount == rowCount - 1 ? 8.0 : 0;
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: myGoals[index].isSigned
                  ? Colors.amber[500]
                  : Colors.amber[100],
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(8.0, 8.0, rightMargin, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      myGoals[index].seriesSign.toString(),
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                  ],
                ),
                Image(
                  image: AssetImage(myGoals[index].imageUrl),
                  width: 60,
                ),
                Text(
                  myGoals[index].name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          onTap: () {
            GoalRecord record = GoalRecord();
            record.goalId = myGoals[index].id;
            record.date = DateTime.now().millisecondsSinceEpoch;
            RecordsProvider provider = RecordsProvider();
            provider.open(GOALS_DB_NAME).then((onValue) {
              if (!myGoals[index].isSigned) {
                provider.insert(record).then((onValue) {
                  provider.close();
                  myGoals[index].isSigned = !myGoals[index].isSigned;
                  myGoals[index].totalSign++;
                  myGoals[index].seriesSign++;
                  callback();
                });
              } else {
                provider.deleteByGoalId(record.goalId).then((onValue) {
                  provider.close();
                  myGoals[index].isSigned = !myGoals[index].isSigned;
                  myGoals[index].totalSign--;
                  myGoals[index].seriesSign--;
                  callback();
                });
              }
            });
          },
        );
      },
    );
  }
}
