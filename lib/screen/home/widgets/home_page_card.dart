import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePageCard extends StatelessWidget {
  final String image;
  final String text;
  final Widget? location;
  const HomePageCard({
    super.key,
    required this.image,
    required this.text,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (b) => location!,
            ),
          );
        },
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: HexColor('262a35'),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Container(
                      width: 75,
                      height: 75,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 75,
                      height: 75,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                text,
                maxLines: 1,
                minFontSize: 10,
                maxFontSize: 22,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
