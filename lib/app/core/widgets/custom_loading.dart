import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final String? message;
  final double? size;

  const CustomLoading({Key? key, this.message, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: size ?? 15.0, // default size
          ),
          if (message != null) ...[
            const SizedBox(height: 10),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
