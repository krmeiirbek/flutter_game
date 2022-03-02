import 'package:flutter/material.dart';
import 'package:flutter_game/entities/bullet.dart';
import 'package:flutter_game/entities/player.dart';
import 'package:flutter_game/scenes/app_scene.dart';
import 'package:flutter_game/utility/global_vars.dart';

class GameScene extends AppScene {
  final _player = Player();
  double _startGlobalPosition = 0;
  List<Bullet> _listBullets = [];
  List<Widget> _listWidgets = [];

  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: GlobalVars.screenWidth / 2,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight / 2,
            child: GestureDetector(
              onTap: _onAcceleration,
            ),
          ),
        ),
        Positioned(
          top: GlobalVars.screenHeight / 2,
          left: GlobalVars.screenWidth / 2,
          child: SizedBox(
            width: GlobalVars.screenWidth / 2,
            height: GlobalVars.screenHeight / 2,
            child: GestureDetector(
              onTap: _onShoot,
            ),
          ),
        ),
        Stack(
          children: _listWidgets,
        ),
      ],
    );
  }

  @override
  void update() {
    _player.update();
    _listWidgets.clear();
    _listBullets.removeWhere((element) => !element.visible);
    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
      
    });
  }

  GameScene();

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if (updateGlobalPosition > _startGlobalPosition + 30) {
      _player.isMoveRight = true;
    } else if (updateGlobalPosition < _startGlobalPosition - 30) {
      _player.isMoveLeft = true;
    }
  }

  void _onAcceleration() {
    _player.isAcceleration = !_player.isAcceleration;
  }

  void _onShoot() {
    _listBullets.add(Bullet(
      playerAngle: _player.getAngle,
      playerX: _player.x,
      playerY: _player.y,
    ));
  }
}
