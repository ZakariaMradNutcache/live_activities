import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:live_activities/live_activities.dart';
import 'package:nutcache_live_activities/models/nutcache_timer.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _start = 0;
  bool _isPaused = true;
  final _liveActivities = LiveActivities();
  String? activityId;

  @override
  void initState() {
     super.initState();
    _liveActivities.init(
        appGroupId: 'group.nutcache.live', urlScheme: 'nutcache');
    _liveActivities.urlSchemeStream().listen((schemeData) {
      print(schemeData.path);
    });
  }

  void startTimer() {
    if (_isPaused) {
      _isPaused = false;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        setState(() {
          _start++;
        });
        if (activityId == null) {
        activityId =
            await _liveActivities.createActivity(NutcacheTimer(start: _start).toJson());
        print(activityId);
      } else {
        _liveActivities.updateActivity(activityId!, NutcacheTimer(start: _start).toJson());
      }
      });
    } else {
      _isPaused = true;
      _timer.cancel();
    }
  }

  void resetTimer() {
    setState(() {
      _timer.cancel();
      _start = 0;
      _isPaused = true;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    // _liveActivities.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Timer',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Roboto',
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 22,
                letterSpacing: 0,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _start.toString(),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Roboto',
                    fontSize: 25,
                    letterSpacing: 0,
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FFButtonWidget(
                  onPressed: () {
                    startTimer();
                  },
                  text: _isPaused ? 'Start' : 'Pause',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    resetTimer();
                  },
                  text: 'Reset',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).error,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ].divide(SizedBox(height: 30)),
        ),
      ),
    );
  }
}
