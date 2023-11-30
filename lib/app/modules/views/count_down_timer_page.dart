import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'rounded_button.dart';

class CountDownTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CountDownTimerPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CountDownTimerPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(3),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStopped');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStopped
        .listen((value) => print('stopped from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 4, 80, 91),
        title: const Text('Timer', style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Set text to bold
          ),),
      ),
       backgroundColor: Color.fromARGB(255, 4, 80, 91),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// Display stop watch time
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime = StopWatchTimer.getDisplayTime(value,
                        hours: _isHours, milliSecond: false);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime,
                            style: const TextStyle(
                                fontSize: 40,
                                 color: Colors.white,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 15,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                /// Display every minute.
                StreamBuilder<int>(
                  stream: _stopWatchTimer.minuteTime,
                  initialData: _stopWatchTimer.minuteTime.value,
                  builder: (context, snap) {
                    final value = snap.data;
                    print('Listen every minute. $value');
                    return Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    'minute',
                                    style: TextStyle(
                                      fontSize: 17,
                                       color: Colors.white,
                                      fontFamily: 'Helvetica',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                         color: Colors.white,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
                  },
                ),

                /// Display every second.
                StreamBuilder<int>(
                  stream: _stopWatchTimer.secondTime,
                  initialData: _stopWatchTimer.secondTime.value,
                  builder: (context, snap) {
                    final value = snap.data;
                    print('Listen every second. $value');
                    return Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    'second',
                                    style: TextStyle(
                                      fontSize: 17,
                                       color: Colors.white,
                                      fontFamily: 'Helvetica',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      fontSize: 30,
                                       color: Colors.white,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
                  },
                ),

                /// Lap time.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 100,
                  ),
                ),

                /// Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedButton(
                            color: Colors.lightBlue,
                            onTap: _stopWatchTimer.onStartTimer,
                            child: const Text(
                              'Start',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedButton(
                            color: Colors.green,
                            onTap: _stopWatchTimer.onStopTimer,
                            child: const Text(
                              'Stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedButton(
                            color: Colors.red,
                            onTap: _stopWatchTimer.onResetTimer,
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.pinkAccent,
                          onTap: () {
                            _stopWatchTimer.setPresetHoursTime(1);
                          },
                          child: const Text(
                            'Set Hours',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.pinkAccent,
                          onTap: () {
                            _stopWatchTimer.setPresetMinuteTime(1);
                          },
                          child: const Text(
                            'Set Minute',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.pinkAccent,
                          onTap: () {
                            _stopWatchTimer.setPresetSecondTime(10);
                          },
                          child: const Text(
                            'Set +Second',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.pinkAccent,
                          onTap: () {
                            _stopWatchTimer.setPresetSecondTime(-10);
                          },
                          child: const Text(
                            'Set -Second',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: RoundedButton(
                    color: Colors.pinkAccent,
                    onTap: _stopWatchTimer.clearPresetTime,
                    child: const Text(
                      'Clear PresetTime',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
