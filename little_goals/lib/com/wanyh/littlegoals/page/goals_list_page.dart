import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/record_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/icons.dart';

import 'goal_gridview.dart';
import 'goal_listview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LittleGoal> myGoals = List();
  int tabIndex = 0;
  bool init = false;

  _loadGoals() async {
    GoalsProvider provider = GoalsProvider();
    provider.open(GOALS_DB_NAME).then((onValue) {
      provider.getAllGoals().then((onValue) {
        myGoals = onValue;
        provider.close();
        _checkSign();
        setState(() {
          init = true;
        });
      });
    });
  }

  _checkSign() async {
    RecordsProvider provider = RecordsProvider();
    await provider.open(GOALS_DB_NAME).then((onValue) {
      DateTime targetDateTime = DateTime.now();
      String targetDateStr =
          '${targetDateTime.year}${targetDateTime.month}${targetDateTime.day}';
      DateTime dateTime;
      String dateStr;
      for (LittleGoal goal in myGoals) {
        provider.getRecords(goal.id).then((onValue) {
          for (GoalRecord record in onValue) {
            dateTime = DateTime.fromMillisecondsSinceEpoch(record.date);
            dateStr = '${dateTime.year}${dateTime.month}${dateTime.day}';
            if (dateStr == targetDateStr) {
              goal.isSigned = true;
              setState(() {});
              break;
            }
          }
        });
      }
    });
  }

  _addGoals() {
    //进入添加小目标界面
    Navigator.of(context).pushNamed(ADD_GOALS_PAGE).then((onValue) {
      if (onValue is LittleGoal) {
        setState(() {
          myGoals.add(onValue);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!init) {
      _loadGoals();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: tabIndex == 0
          ? GoalGridView(myGoals, () {
              setState(() {});
            })
          : GoalListView(myGoals, () {
              setState(() {});
            }),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: MyIcons(35, 35).goalsNor(),
            activeIcon: MyIcons(35, 35).goalsOn(),
            title: Text("LittleGoals"),
          ),
          BottomNavigationBarItem(
            icon: MyIcons(35, 35).settingNor(),
            activeIcon: MyIcons(35, 35).settingOn(),
            title: Text("Settings"),
          )
        ],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: tabIndex,
        fixedColor: Colors.blue,
        onTap: _onSelectTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoals,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _onSelectTap(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}
