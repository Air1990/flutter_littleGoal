import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/record_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/page/setting_page.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/icons.dart';

import 'package:little_goals/com/wanyh/littlegoals/widget/goal_gridview.dart';
import 'package:little_goals/com/wanyh/littlegoals/widget/goal_listview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

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

  Widget _getBody() {
    switch (tabIndex) {
      case 0:
        return GoalGridView(myGoals, () {
          setState(() {});
        });
        break;
      case 1:
        return GoalListView(myGoals, () {
          setState(() {});
        });
        break;
      case 2:
        return SettingPage();
        break;
    }
    return null;
  }

  String _getTitle() {
    switch (tabIndex) {
      case 0:
        return 'GoalsList';
        break;
      case 1:
        return 'GoalsDetail';
        break;
      case 2:
        return 'Settings';
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!init) {
      _loadGoals();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        centerTitle: true,
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: MyIcons(35, 35).goalsNor(),
            activeIcon: MyIcons(35, 35).goalsOn(),
            title: Text("GoalsList"),
          ),
          BottomNavigationBarItem(
            icon: MyIcons(35, 35).detailNor(),
            activeIcon: MyIcons(35, 35).detailOn(),
            title: Text("GoalsDetail"),
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
