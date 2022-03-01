import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  const double _fps = 50;
  const double _second = 1000;
  const double _updateTime = _second / _fps;
  double _updates = 0;

  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();
  Stopwatch _timerWatch = Stopwatch();
  _timerWatch.start();
  // entities
  while (_running) {
    if (_loopWatch.elapsedMilliseconds > _updateTime) {
      _updates++;
      _loopWatch.reset();
      sendPort.send(true);
    }
    if(_timerWatch.elapsedMilliseconds > _second) {
      print("${DateTime.now()} FPS: $_updates");
      _updates = 0;
      _timerWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}
