import 'package:flutter/material.dart';
import 'package:watoon/watoon/models/webtoon_model.dart';
import 'package:watoon/watoon/services/api_service.dart';

class WatoonHome extends StatelessWidget {
  WatoonHome({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getToday();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color(0xFFF4EDDB),
          title: const Text(
            "와툰",
            style: TextStyle(
              color: Color(0xFF232B55),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text("good");
            }

            return const Text("LOADING");
          },
        ),
      ),
    );
  }
}
