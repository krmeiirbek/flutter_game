import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_game/entities/player.dart';
import 'package:flutter_game/game_core/main_loop.dart';
import 'package:flutter_game/utility/common_vars.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late ReceivePort _receivePort;
  late Isolate _isolateLoop;
  late Player player;

  void startIsolateLoop() async {
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isFirstStartGame) {
      startIsolateLoop();
      isFirstStartGame = false;
      player = Player();
    }
    player.update();
    return Stack(
      children: [
        player.build(),
      ],
    );
  }
}
