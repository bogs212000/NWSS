import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            height: 200, // Set the height of the image
            width: double.infinity, // Set the width of the image to fill the dialog
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog when the button is pressed
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}