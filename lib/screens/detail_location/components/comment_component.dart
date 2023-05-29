import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userInfo(),
        const SizedBox(height: 5),
        RatingBar.builder(
          minRating: 1,
          itemSize: 15,
          initialRating: 5,
          unratedColor: Colors.grey[300],
          itemBuilder: (context, _) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          },
          onRatingUpdate: (_) {},
        ),
        const SizedBox(height: 5),
        const Text(
          'Comment áds adas ds ada sdj kfs ahf jkas hd fkjl hasldj kfh ajks dh fl jka sd hfj',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget userInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl:
                'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
            width: 35,
            height: 35,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Nguyễn Văn A',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              '23/05/2022',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }
}
