import 'package:flutter/material.dart';
import 'package:little_goals/db/goals_helper.dart';
import 'package:little_goals/utils/const.dart';

class GoalListView extends ListView {
  GoalListView(this.myGoals, this.callback);

  final List<LittleGoal> myGoals;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: myGoals.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: myGoals[index].isSigned
                    ? Colors.amber[500]
                    : Colors.amber[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 80,
                          child: Image(
                            image: AssetImage(myGoals[index].imageUrl),
                            width: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                myGoals[index].name,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18,
                                ),
                              ),
                              Text('已打卡${myGoals[index].totalSign}天'),
                              Text(myGoals[index].slogan)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(myGoals[index].seriesSign.toString(),
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 30,
                                  )),
                              Text(
                                '连续打卡',
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, GOALS_DETAIL_PAGE,
                      arguments: myGoals[index])
                  .then((onValue) {
                if (onValue is num && onValue == -1) {
                  //-1:删除
                  myGoals.removeAt(index);
                }
                callback();
              });
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 8,
        );
      },
    );
  }
}
