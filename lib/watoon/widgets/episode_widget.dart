import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:watoon/watoon/models/watoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.watoonId,
  }) : super(key: key);

  final WatoonEpisodeModel episode;
  final String watoonId;

  onEpClick() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$watoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEpClick,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              width: 1,
              color: const Color(0xFF232B55),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Color(0xFF232B55),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(color: Color(0xFF232B55), Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
