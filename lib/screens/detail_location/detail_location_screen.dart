import 'package:flutter/material.dart';

class DetailLocationScreen extends StatelessWidget {
  const DetailLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nuis truc'),

      ),
    );
  }

  Widget listImage(){
    return ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: imageUrls[index],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        },
      ),
  }
}