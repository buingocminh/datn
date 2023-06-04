import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/models/rate_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/detail_location/components/comment_component.dart';
import 'package:datn/screens/detail_location/components/near_location_item.dart';
import 'package:datn/screens/detail_location/components/rating_component.dart';
import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/constants.dart';

class DetailLocationScreen extends StatefulWidget {
  const DetailLocationScreen({super.key, required this.model});
  static const id = 'detail_location_screen';
  final PlaceModel model;

  @override
  State<DetailLocationScreen> createState() => _DetailLocationScreenState();
}

class _DetailLocationScreenState extends State<DetailLocationScreen> {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.model.name),
        actions: [
          Selector<AppState, bool>(
            selector: (ctx, state) => state.isPlaceFavorite(widget.model),
            builder: (ctx, value, _) {
              return GestureDetector(
                onTap: () {
                  if(value) {
                    ctx.read<AppState>().removeUserFavoritePlace(widget.model);
                  } else {
                    ctx.read<AppState>().addUserFavoritePlace(widget.model);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    value ? Icons.favorite : Icons.favorite_border_outlined
                  ),
                ),
              );
            }
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _instance
            .collection(baseDoccumentStorage)
            .doc(placeDoccumentName)
            .collection("data")
            .doc(widget.model.id)
            .collection('rate')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Có lỗi sảy ra'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          List<RateModel> listRatings = [];

          if (documents.isNotEmpty) {
            listRatings = context.read<AppState>().convertRatingData(documents);
          }
          return SingleChildScrollView(
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
                    widget.model.address,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tổng hợp đánh giá',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  RatingComponent(
                    idPlace: widget.model.id,
                    namePlace: widget.model.name,
                    rateModels: listRatings,
                    totalRateModel:
                        context.read<AppState>().countRating(listRatings),
                  ),
                  const Text(
                    'Bình luận',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  listComment(listRatings),
                  const Divider(
                    height: 20,
                    color: Colors.grey,
                    thickness: 1,
                  ),
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
          );
        },
      ),
    );
  }

  Widget listNearLocation() {
    return FutureBuilder<List<PlaceModel>>(
      future: StorageService.getNearestPlace(widget.model),
      builder: (ctx, snapShot) {
        if(snapShot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator(),);
        if(snapShot.data?.isEmpty ?? true) return const SizedBox();
        return ListView.separated(
          itemCount: snapShot.data!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return NearLocationItem(
              place: snapShot.data![index]
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 5.0);
          },
        );
      }
    );
  }

  Widget listImage() {
    return (widget.model.listPreviewImg ?? []).isEmpty
        ? const SizedBox()
        : ListView.separated(
            itemCount: (widget.model.listPreviewImg ?? []).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: (widget.model.listPreviewImg ?? [])[index],
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

  Widget listComment(List<RateModel> listComments) {
    return ListView.separated(
      itemCount: listComments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CommentComponent(rateModel: listComments[index]);
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
