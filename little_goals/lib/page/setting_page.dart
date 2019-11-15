import 'package:flutter/material.dart';

///第三个tab
///设置界面
class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Stack(
        children: <Widget>[
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 300.0)),
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
            onPointerDown: (event) => print('=====down1'),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200.0, 200.0)),
//              child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
              child: Center(child: Text("左上角200*100范围内非文本区域点击")),
            ),
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) => print('=====down2'),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200.0, 100.0)),
//              child: DecoratedBox(decoration: BoxDecoration(color: Colors.blueAccent)),
            ),
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) => print('=====down3'),
          ),
        ],
      ),
      color: Colors.amber[300],
    );
  }
}
