import 'package:flutter/material.dart';
import 'package:watoon/watoon/screens/detail_screen.dart';

class Watoon extends StatelessWidget {
  final String watoonTitle, watoonThumb, watoonId;

  const Watoon({
    super.key,
    required this.watoonTitle,
    required this.watoonThumb,
    required this.watoonId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => WatoonDetail(
                watoonTitle: watoonTitle,
                watoonThumb: watoonThumb,
                watoonId: watoonId)),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: watoonId,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              width: 150,
              child: Image.network(watoonThumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            watoonTitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
