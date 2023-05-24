import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/screens/detail_location/components/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailLocationScreen extends StatelessWidget {
  const DetailLocationScreen({super.key});
  static const id = 'detail_location_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Công viên Cầu Giấy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hình ảnh',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 80,
                child: listImage(),
              ),
              const SizedBox(height: 12),
              const Text(
                'Địa chỉ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              const Text(
                'P. Duy Tân, Dịch Vọng, Cầu Giấy, Hà Nội',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tổng hợp đánh giá',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              ratingContainer(context),
              Card(
                child: ListTile(
                    title: Text('Motivation $int'),
                    subtitle:
                        const Text('this is a description of the motivation')),
              ),
              Card(
                child: ListTile(
                    title: Text('Motivation $int'),
                    subtitle:
                        const Text('this is a description of the motivation')),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle:
                      const Text('this is a description of the motivation'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ratingContainer(BuildContext context) {
    return Row(
      children: [
        Flexible(child: linearRating()),
        Flexible(
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

  Widget linearPercentWidget({required String title, required double percent}) {
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

  Widget listImage() {
    return ListView.separated(
      itemCount: imageUrls.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imageUrls[index],
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 5.0);
      },
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

List<String> imageUrls = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
  // Thêm các URL ảnh khác vào đây
];
