import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    watoon = ApiService.getWatoonDetail(widget.watoonId);
    epLists = ApiService.getEpisode(widget.watoonId);
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
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_outlined,
            ),
          )
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
