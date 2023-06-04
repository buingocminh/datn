import 'package:datn/models/rate_model.dart';
import 'package:datn/models/user_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class RatingDialogContent extends StatefulWidget {
  const RatingDialogContent({
    super.key,
    required this.userModel,
    required this.idPlace,
    required this.namePlace,
  });
  final String namePlace;
  final String idPlace;
  final UserModel userModel;

  @override
  State<RatingDialogContent> createState() => _RatingDialogContentState();
}

class _RatingDialogContentState extends State<RatingDialogContent> {
  late TextEditingController commentController;
  double score = 5.0;

  @override
  void initState() {
    commentController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.namePlace,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        RatingBar.builder(
          minRating: 1,
          itemSize: 35,
          initialRating: score,
          unratedColor: Colors.grey[300],
          itemBuilder: (context, _) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          },
          onRatingUpdate: (value) {
            score = value;
          },
        ),
        const SizedBox(height: 12),
        TextField(
          minLines: 3,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          controller: commentController,
          decoration: const InputDecoration(
            hintMaxLines: 1,
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            labelText: 'Bình luận',
            isDense: true,
          ),
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
          onPressed: () async {
            await _rating(
                context, widget.userModel, commentController.text, score);
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

  Future<void> _rating(
    BuildContext context,
    UserModel? userModel,
    String? comment,
    double score,
  ) async {
    if (userModel == null) {
      return;
    }
    if (comment == '') {
      return;
    }
    final rattingItem = RateModel(
      id: widget.idPlace,
      score: score,
      comment: comment ?? '',
      dateTime: DateTime.now(),
      userId: userModel.id,
      userName: userModel.name,
    );

    try {
      context.loaderOverlay.show();
      await context.read<AppState>().recordRating(rattingItem).then((value) {
        context.loaderOverlay.hide();
        Navigator.of(context).pop();
      });
    } catch (e) {
      context.loaderOverlay.hide();
    }
  }
}
