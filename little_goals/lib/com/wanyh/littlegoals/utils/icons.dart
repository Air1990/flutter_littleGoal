import 'package:flutter/material.dart';

class MyIcons {
  double width = 20;
  double height = 20;

  MyIcons(this.width, this.height);

  Image goalsNor() {
    return Image(
      width: width,
      height: height,
      image: AssetImage('images/goals_nor.png'),
    );
  }

  Image goalsOn() {
    return Image(
      width: width,
      height: height,
      image: AssetImage('images/goals_on.png'),
    );
  }

  Image settingNor() {
    return Image(
      width: width,
      height: height,
      image: AssetImage('images/settings_nor.png'),
    );
  }

  Image settingOn() {
    return Image(
      width: width,
      height: height,
      image: AssetImage('images/settings_on.png'),
    );
  }
}
