import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/screens/detail_location/components/comment_component.dart';
import 'package:datn/screens/detail_location/components/near_location_item.dart';
import 'package:datn/screens/detail_location/components/rating_component.dart';
import 'package:flutter/material.dart';

class DetailLocationScreen extends StatelessWidget {
  const DetailLocationScreen({super.key, required this.model});
  static const id = 'detail_location_screen';
  final PlaceModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(model.name),
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
              const SizedBox(height: 4),
              SizedBox(
                height: 140,
                child: listImage(),
              ),
              const SizedBox(height: 12),
              const Text(
                'Địa chỉ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                model.address,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tổng hợp đánh giá',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              const RatingComponent(),
              const Text(
                'Bình luận',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              listComment(),
              const SizedBox(height: 12),
              const Text(
                'Địa điểm liên quan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 200,
                child: listNearLocation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listNearLocation() {
    return ListView.separated(
      itemCount: imageUrls.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const NearLocationItem();
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 5.0);
      },
    );
  }

  Widget listImage() {
    return (model.listPreviewImg ?? []).isEmpty
        ? const SizedBox()
        : ListView.separated(
            itemCount: (model.listPreviewImg ?? []).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: (model.listPreviewImg ?? [])[index],
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 140,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 5.0);
            },
          );
  }

  Widget listComment() {
    return ListView.separated(
      itemCount: imageUrls.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const CommentComponent();
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 20,
          color: Colors.grey,
          thickness: 1,
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
