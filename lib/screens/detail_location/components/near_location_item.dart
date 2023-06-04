import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/models/place_model.dart';
import 'package:flutter/material.dart';

import '../detail_location_screen.dart';

class NearLocationItem extends StatelessWidget {
  const NearLocationItem({super.key, required this.place});
  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DetailLocationScreen(
              model: place,
            ),
          )
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: place.previewImg,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                fit: BoxFit.cover,
                width: 160,
                height: 100,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    place.address,
                    style: const TextStyle(
                      fontSize: 13,
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget ratingContent() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: Row(
  //       children: const [
  //         Text(
  //           '4,3 ',
  //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  //         ),
  //         Icon(
  //           Icons.star,
  //           color: Colors.amber,
  //         ),
  //         Text(
  //           ' (119)',
  //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
