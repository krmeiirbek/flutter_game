import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_game/entities/entity.dart';
import 'package:flutter_game/utility/global_vars.dart';

class Player extends Entity {
  Player() : super("player") {
    x = 50;
    y = 150;
  }

  double _angle = 0;
  double _degree = 0;
  bool isMoveLeft = false;
  bool isMoveRight = false;
  final double _speed = 3;
  bool isAcceleration = false;

  get getAngle => _angle;

  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: visible
          ? Transform.rotate(
              angle: _angle,
              child: sprites[currentSprite],
            )
          : const SizedBox(),
    );
  }

  @override
  void move() {
    if(!isAcceleration) return;
    if (isMoveLeft) _degree -= 5;
    if (isMoveRight) _degree += 5;
    _angle = (_degree * pi) / 180;
    x += sin(_angle) * _speed;
    y -= cos(_angle) * _speed;
    if (x < 0) x = 0;
    if (x > GlobalVars.screenWidth - 50) x = GlobalVars.screenWidth - 50;
    if (y < 0) y = 0;
    if (y > GlobalVars.screenHeight - 50) y = GlobalVars.screenHeight - 50;
    isMoveLeft = false;
    isMoveRight = false;
  }

}
