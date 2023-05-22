import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailLocationScreen extends StatelessWidget {
  const DetailLocationScreen({super.key});
  static const id = 'detail_location_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nuis truc'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Headline',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 80, child: listImage()),
            const Text(
              'Demo Headline 2',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Demo Headline 2',
              style: TextStyle(fontSize: 18),
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
                      const Text('this is a description of the motivation')),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Motivation $int'),
                subtitle: const Text('this is a description of the motivation'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listImage() {
    return ListView.builder(
      itemCount: imageUrls.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrls[index],
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
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
