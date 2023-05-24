import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        userInfo(),
        const Text(
          'Comment ádsadasdsadasdjkfsahfjkashdfkjlhasldjkfhajksdhfljkasdhfj',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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
            width: 20,
            height: 20,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const Text(
          'Nguyễn Văn A',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
