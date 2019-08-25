import 'package:flutter/material.dart';
import 'package:little_goals/com/wanyh/littlegoals/db/goals_helper.dart';
import 'package:little_goals/com/wanyh/littlegoals/utils/const.dart';

class CustomPage extends StatefulWidget {
  final LittleGoal myGoal;

  CustomPage({@required this.myGoal});

  @override
  State<StatefulWidget> createState() {
    return CustomPageState();
  }
}

class CustomPageState extends State<CustomPage> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _sloganEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameEditingController.text = widget.myGoal.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Goal'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Image(
              image: AssetImage('images/finish.png'),
              height: 20,
            ),
            onPressed: () {
              LittleGoal goal = LittleGoal();
              goal.name = _nameEditingController.text;
              goal.imageUrl = widget.myGoal.imageUrl;
              goal.slogan = _sloganEditingController.text.length == 0
                  ? '写一句激励自己的话吧!'
                  : _sloganEditingController.text;
              goal.date = DateTime.now().millisecondsSinceEpoch;
              GoalsProvider dbProvider = GoalsProvider();
              dbProvider.open(GOALS_DB_NAME).then((onValue) {
                dbProvider.insert(goal).then((onValue) {
                  dbProvider.close();
                  Navigator.of(context).pop(goal);
                });
              });
            },
          )
        ],
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: Image(
            image: AssetImage(widget.myGoal.imageUrl),
            width: 60,
            height: 60,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.amber[100],
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            cursorColor: Colors.amber[500],
            maxLines: 1,
            controller: _nameEditingController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.amber[100],
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            cursorColor: Colors.amber[500],
            maxLines: 1,
            controller: _sloganEditingController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: '写一句激励自己的话吧！'),
          ),
        ),
      ]),
    );
  }
}
