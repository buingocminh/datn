import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialogContent extends StatelessWidget {
  const RatingDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Công viên Cầu Giấy',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        RatingBar.builder(
          minRating: 1,
          itemSize: 35,
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
        const SizedBox(height: 12),
        const TextField(
          minLines: 3,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
              hintMaxLines: 1,
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              labelText: 'Bình luận',
              isDense: true),
        ),
        const SizedBox(height: 12),
        bottomButton(context),
      ],
    );
  }

  Widget bottomButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          child: const Text('Hủy Bỏ'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          child: const Text('Đánh giá'),
        ),
      ],
    );
  }
}
