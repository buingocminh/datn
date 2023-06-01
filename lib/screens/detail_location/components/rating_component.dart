import 'package:datn/models/rate_model.dart';
import 'package:datn/models/user_model.dart';
import 'package:datn/screens/detail_location/components/rating_dialog.dart';
import 'package:datn/screens/detail_location/components/requires_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_state.dart';

class RatingComponent extends StatelessWidget {
  const RatingComponent({
    super.key,
    required this.idPlace,
    required this.namePlace,
    required this.rateModels,
    required this.totalRateModel,
  });
  final String idPlace;
  final String namePlace;
  final List<RateModel> rateModels;
  final TotalRateModel totalRateModel;

  @override
  Widget build(BuildContext context) {
    return Selector<AppState, UserModel?>(
      selector: (ctx, state) => state.user,
      builder: (ctx, value, _) {
        if (totalRateModel.total == 0) {
          return emptyRating(context: context, userModel: value);
        }
        return Row(
          children: [
            Flexible(child: linearRating(totalRateModel)),
            Flexible(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      totalRateModel.totalStarPercent.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    RatingBar.builder(
                      minRating: 1,
                      itemSize: 30,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: totalRateModel.totalStarPercent,
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
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: totalRateModel.total.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' Lượt đánh giá',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ratingButton(context: context, userModel: value)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget emptyRating({
    UserModel? userModel,
    required BuildContext context,
  }) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Chưa có lượt đánh giá nào ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 12,
          ),
          ratingButton(context: context, userModel: userModel)
        ],
      ),
    );
  }

  Widget ratingButton({
    UserModel? userModel,
    required BuildContext context,
  }) {
    return OutlinedButton(
      onPressed: !context
              .read<AppState>()
              .checkUserCommented(rateModels, userModel?.id ?? '')
          ? () {
              showAlertDialog(
                userModel: userModel,
                context: context,
              );
            }
          : null,
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
    );
  }

  Widget linearRating(TotalRateModel totalRateModel) {
    return Column(
      children: [
        linearPercentWidget(
          title: '5',
          percent: totalRateModel.fiveStarPercent,
        ),
        linearPercentWidget(
          title: '4',
          percent: totalRateModel.fourStarPercent,
        ),
        linearPercentWidget(
          title: '3',
          percent: totalRateModel.threeStarPercent,
        ),
        linearPercentWidget(
          title: '2',
          percent: totalRateModel.twoStarPercent,
        ),
        linearPercentWidget(
          title: '1',
          percent: totalRateModel.oneStarPercent,
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

  void showAlertDialog({
    UserModel? userModel,
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: userModel == null
              ? const RequiresLogin()
              : RatingDialogContent(
                  userModel: userModel,
                  idPlace: idPlace,
                  namePlace: namePlace,
                ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
