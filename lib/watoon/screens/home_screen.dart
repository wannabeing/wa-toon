import 'package:flutter/material.dart';
import 'package:watoon/watoon/models/watoon_model.dart';
import 'package:watoon/watoon/services/api_service.dart';
import 'package:watoon/watoon/widgets/watoon_widget.dart';

class WatoonHome extends StatelessWidget {
  WatoonHome({super.key});

  final Future<List<WatoonModel>> watoons = ApiService.getToday();

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
          future: watoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Text(
                      '관심와툰',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Text(
                      '오늘의 와툰',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: makeListView(snapshot),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  // API 데이터로 리스트뷰 생성
  ListView makeListView(AsyncSnapshot<List<WatoonModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        var watoon = snapshot.data![index];
        return Watoon(
          watoonTitle: watoon.title,
          watoonThumb: watoon.thumb,
          watoonId: watoon.id,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 25,
        );
      },
    );
  }
}
