import 'package:datn/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class RequiresLogin extends StatelessWidget {
  const RequiresLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Mời bạn đăng nhập trước khi đánh giá ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        bottomButton(context),
      ],
    );
  }

  Widget bottomButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          child: const Text('Hủy Bỏ'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SignInScreen.id);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }
}
