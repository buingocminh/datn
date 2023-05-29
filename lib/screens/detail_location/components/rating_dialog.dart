import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/models/user_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class RatingDialogContent extends StatelessWidget {
  RatingDialogContent({
    super.key,
    required this.userModel,
    required this.idPlace,
  });

  final String idPlace;
  final UserModel userModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

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
          onRatingUpdate: (value) {
            _formData["score"] = value;
            print(_formData["score"]);
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
        bottomButton(
          context,
          commentController.text,
        ),
      ],
    );
  }

  Widget bottomButton(BuildContext context, String? comment) {
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
            await _rating(context, userModel, comment);
            //Navigator.pop(context);
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
  ) async {
    if (userModel == null) {
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        _formData["uid"] = (userModel.id).trim();
        _formData["comment"] = comment ?? "";
        _formData['date'] = Timestamp.fromDate(DateTime.now());

        context.loaderOverlay.show();
        print(_formData["comment"]);
        await context.read<AppState>().recordRating(_formData).then((value) {
          context.loaderOverlay.hide();
          Navigator.of(context).pop();
        });
      } catch (e) {
        context.loaderOverlay.hide();
        //showAlertDialog(context: context, title: e.toString());
      }
    }
  }
}
