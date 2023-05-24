import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, {required String title, String? content}) {
  showDialog(
    context: context, 
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            // style: AppTextStyle.secondaryBlackO80S21W600,
          ),
          SizedBox(height: content != null ? 8 : 0),
          content != null
              ? Text(
                  content,
                  // style: AppTextStyle.grayO40S15W400,
                )
              : const SizedBox(),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            }, 
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(45)),
            child: const Text("OK")
          )
        ],
      ),
    ),
    ),
    barrierDismissible: false,
  );
}