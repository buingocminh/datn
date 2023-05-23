import 'package:cached_network_image/cached_network_image.dart';
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
              ratingContainer(),
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

  Widget ratingContainer() {
    return SizedBox(
      width: double.infinity,
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
          LinearPercentIndicator(
            barRadius: const Radius.circular(10),
            width: 100.0,
            lineHeight: 8.0,
            percent: 0.2,
            progressColor: Colors.amber,
          ),
          const SizedBox(
            height: 12,
          ),
          LinearPercentIndicator(
            barRadius: const Radius.circular(10),
            width: 100.0,
            lineHeight: 8.0,
            percent: 0.5,
            progressColor: Colors.amber,
          ),
          const SizedBox(
            height: 12,
          ),
          LinearPercentIndicator(
            barRadius: const Radius.circular(10),
            width: 100.0,
            lineHeight: 8.0,
            percent: 0.9,
            progressColor: Colors.amber,
          ),
          OutlinedButton(
            onPressed: () {},
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
    );
  }

  Widget linearRating() {
    return Column(
      children: [
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          width: 100.0,
          lineHeight: 5.0,
          percent: 0.2,
          progressColor: Colors.amber,
        ),
        const SizedBox(
          height: 12,
        ),
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          width: 100.0,
          lineHeight: 5.0,
          percent: 0.5,
          progressColor: Colors.amber,
        ),
        const SizedBox(
          height: 12,
        ),
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          width: 100.0,
          lineHeight: 5.0,
          percent: 0.9,
          progressColor: Colors.amber,
        ),
        const SizedBox(
          height: 12,
        ),
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          width: 100.0,
          lineHeight: 5.0,
          percent: 0.9,
          progressColor: Colors.amber,
        ),
        const SizedBox(
          height: 12,
        ),
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          width: 100.0,
          lineHeight: 8.0,
          percent: 0.9,
          progressColor: Colors.amber,
        ),
      ],
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
