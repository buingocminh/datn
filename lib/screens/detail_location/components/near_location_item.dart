import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NearLocationItem extends StatelessWidget {
  const NearLocationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
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
          const Text(
            'Trâu Thuý Hằng 2',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          ratingContent(),
          const Text(
            'Category',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget ratingContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: const [
          Text(
            '4,3 ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Text(
            ' (119)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
