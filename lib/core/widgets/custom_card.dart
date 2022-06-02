import 'package:cached_network_image/cached_network_image.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.imgUrl,
    required this.gameName,
    required this.productCategory,
    required this.productPrice,
    required this.productStock,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final String imgUrl;
  final String gameName;
  final String productCategory;
  final String productPrice;
  final String productStock;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                gameName,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CustomProductDetails(
            productTitle: 'Category: ',
            productDetail: productCategory,
          ),
          CustomProductDetails(
            productTitle: 'Price: ',
            productDetail: gameName,
          ),
          CustomProductDetails(
            productTitle: 'Stock: ',
            productDetail: productStock,
          ),
          const SizedBox(height: 7),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Add to cart'),
          )
        ],
      ),
    );
  }
}

class CustomProductDetails extends StatelessWidget {
  const CustomProductDetails({
    Key? key,
    required this.productTitle,
    required this.productDetail,
  }) : super(key: key);

  final String productDetail;
  final String productTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            productTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            productDetail,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
