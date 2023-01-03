import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watoon/watoon/models/watoon_detail_model.dart';
import 'package:watoon/watoon/models/watoon_episode_model.dart';
import 'package:watoon/watoon/services/api_service.dart';
import 'package:watoon/watoon/widgets/episode_widget.dart';

class WatoonDetail extends StatefulWidget {
  final String watoonTitle, watoonThumb, watoonId;
  const WatoonDetail({
    super.key,
    required this.watoonTitle,
    required this.watoonThumb,
    required this.watoonId,
  });

  @override
  State<WatoonDetail> createState() => _WatoonDetailState();
}

class _WatoonDetailState extends State<WatoonDetail> {
  late Future<WatoonDetailModel> watoon;
  late Future<List<WatoonEpisodeModel>> epLists;
  late SharedPreferences prefs;
  bool isLlike = false;

  @override
  void initState() {
    super.initState();
    watoon = ApiService.getWatoonDetail(widget.watoonId); // 웹툰 정보 가져오기
    epLists = ApiService.getEpisode(widget.watoonId); // 해당 웹툰 에피소드 리스트 가져오기
    initPref(); // 사용자 휴대폰 저장소와 연결
  }

  // 사용자 휴대폰저장소와 연결 함수
  Future initPref() async {
    prefs = await SharedPreferences.getInstance(); // 연결
    final likedWatoons = prefs.getStringList('likedWatoons'); // 좋아요 리스트 가져오기

    // 좋아요 누른 웹툰일 경우, isLike = true
    if (likedWatoons != null) {
      if (likedWatoons.contains(widget.watoonId) == true) {
        setState(() {
          isLlike = true;
        });
      }
    } else {
      await prefs.setStringList('likedWatoons', []);
    }
  }

  // 좋아요 클릭 함수
  onLikeClick() async {
    final likedWatoons = prefs.getStringList('likedWatoons'); // 좋아요 리스트 가져오기

    // 기존 isLike 값에 따라 좋아요 리스트에 삭제 및 추가
    if (likedWatoons != null) {
      if (isLlike) {
        likedWatoons.remove(widget.watoonId);
      } else {
        likedWatoons.add(widget.watoonId);
      }
      // 휴대폰 저장소에 변경된 좋아요 리스트 저장
      await prefs.setStringList('likedWatoons', likedWatoons);
      // isLike 값 변경
      setState(() {
        isLlike = !isLlike;
      });
    }
  }

  // hashtag 변환 함수
  String setHashtag(String genre) {
    var split = genre.split(', ');
    var lists = [];
    String hashGenre;
    for (var element in split) {
      lists.add("#$element");
    }
    hashGenre = lists.join(" ");
    return hashGenre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EDDB),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFFF4EDDB),
        foregroundColor: const Color(0xFF232B55),
        actions: [
          IconButton(
            onPressed: onLikeClick,
            icon: Icon(
              isLlike
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline_outlined,
            ),
          ),
        ],
        title: Text(
          widget.watoonTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.watoonId,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      width: 250,
                      child: Image.network(widget.watoonThumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: watoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          setHashtag(snapshot.data!.genre),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "연령 ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              snapshot.data!.age,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                          future: epLists,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  for (var episode in snapshot.data!)
                                    Episode(
                                      episode: episode,
                                      watoonId: widget.watoonId,
                                    ),
                                ],
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
