import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final int productId;

  const ShareProductButton({super.key, required this.productId});

  static const String productWebBaseUrl =
      'https://huma-volve-ecommerce.web.app/products';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () async {
        final productLink = '$productWebBaseUrl/$productId';
        await Share.share(
          'Check out this product on Huma Volve:\n$productLink',
          subject: 'Huma Volve product',
        );
      },
    );
  }
}
