import 'package:datn/screens/detail_location/components/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RatingComponent extends StatelessWidget {
  const RatingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: linearRating()),
        Flexible(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '2,0',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                RatingBar.builder(
                  minRating: 1,
                  itemSize: 30,
                  ignoreGestures: true,
                  initialRating: 2,
                  itemBuilder: (context, _) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (_) {},
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '20',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' đánh giá',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                OutlinedButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: const Text('Viết đánh giá'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget linearRating() {
    return Column(
      children: [
        linearPercentWidget(
          title: '5',
          percent: 0.9,
        ),
        linearPercentWidget(
          title: '4',
          percent: 0.9,
        ),
        linearPercentWidget(
          title: '3',
          percent: 0.9,
        ),
        linearPercentWidget(
          title: '2',
          percent: 0.9,
        ),
        linearPercentWidget(
          title: '1',
          percent: 0.9,
        ),
      ],
    );
  }

  Widget linearPercentWidget({
    required String title,
    required double percent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(title),
          Expanded(
            child: LinearPercentIndicator(
              barRadius: const Radius.circular(10),
              lineHeight: 5.0,
              percent: percent,
              progressColor: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: RatingDialogContent(),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
