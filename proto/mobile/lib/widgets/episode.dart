import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10), // 버튼 사이에 간격을 10만큼 준다.
        decoration: BoxDecoration(
          border: Border.all(
            //테두리의 색상과 굵기를 지정하는 부분
            color: Colors.green, //선의 색상
            width: 1, //선의 굵기
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
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
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
