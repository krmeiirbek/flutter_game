import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/game_core/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).whenComplete(() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    ));
  });
}
