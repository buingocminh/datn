import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/detail_location/components/near_location_item.dart';
import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailLocationScreen extends StatefulWidget {
  const DetailLocationScreen({super.key, required this.model});
  static const id = 'detail_location_screen';
  final PlaceModel model;

  @override
  State<DetailLocationScreen> createState() => _DetailLocationScreenState();
}

class _DetailLocationScreenState extends State<DetailLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.model.name),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Địa chỉ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.model.address,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AppState>().setUserDirection(widget.model.latLong);
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.directions
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Thông tin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                (widget.model.description ?? "Chưa có thông tin về địa điểm").replaceAll("/n", "\n")
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
}
