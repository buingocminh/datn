import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/models/rate_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({
    super.key,
    required this.rateModel,
  });
  final RateModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userInfo(
          context: context,
          name: rateModel.userName,
          dateTime: rateModel.dateTime,
        ),
        const SizedBox(height: 5),
        RatingBar.builder(
          minRating: 1,
          itemSize: 15,
          initialRating: rateModel.score,
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
        Text(
          rateModel.comment,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget userInfo(
      {required String name,
      required DateTime dateTime,
      required BuildContext context}) {
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
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              context.read<AppState>().convertDateTime(dateTime),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
