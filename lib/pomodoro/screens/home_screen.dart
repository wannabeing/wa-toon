import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const maxSeconds = 1500;
  int totalSec = maxSeconds;
  int totalSuccess = 0;
  bool isStart = false;
  late Timer timer;

  void onTikTok(Timer timer) {
    if (totalSec == 0) {
      setState(() {
        totalSuccess += 1;
        isStart = false;
        totalSec = maxSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSec -= 1;
      });
    }
  }

  // 1. 초 세기 (1초 지날때마다 onTikTok() 실행)
  // 2. onStart() 실행될 때마다 isStart = true
  void onStart() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTikTok,
    );
    setState(() {
      isStart = true;
    });
  }

  // 1. 초 멈추기
  // 2. onStop() 실행될 때마다 isStart = false
  void onStop() {
    timer.cancel();
    setState(() {
      isStart = false;
    });
  }

  // 초기화
  void onRefresh() {
    timer.cancel();
    setState(() {
      isStart = false;
      totalSec = maxSeconds;
    });
  }

  // 남은 초 예쁘게 보이기
  String getTimeFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isStart
          ? Theme.of(context).textTheme.headline1?.color
          : Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                getTimeFormat(totalSec),
                style: TextStyle(
                  fontSize: 90,
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    color: Theme.of(context).cardColor,
                    iconSize: 80,
                    onPressed: isStart ? onStop : onStart,
                    icon: Icon(
                      isStart
                          ? Icons.pause_circle_outline_outlined
                          : Icons.play_circle_outline_outlined,
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).cardColor,
                    iconSize: 80,
                    onPressed: onRefresh,
                    icon: const Icon(
                      Icons.refresh_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '완료횟수',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                        Text(
                          '$totalSuccess',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
