import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularSection extends ConsumerStatefulWidget {
  const PopularSection({Key? key, required this.mediaQuery}) : super(key: key);
  final Size mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PopularSectionState();
}

class _PopularSectionState extends ConsumerState<PopularSection> {
  var _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Popular Games',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('popular_games')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log('Warning error alert for popular games snapshot data !!!');
              return const SizedBox();
            } else if (snapshot.hasData) {
              final _popularGamesData = snapshot.data! as QuerySnapshot;

              return GridView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _popularGamesData.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final _data = _popularGamesData.docs[index];
                  return CustomCard(
                    mediaQuery: widget.mediaQuery,
                    img: '${_data['image']}',
                    onTap: () {},
                    title: '${_data['popularGamesTitle']}',
                  );
                },
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 6,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmer(
                          height: widget.mediaQuery.height / 3.5,
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.mediaQuery,
    required this.img,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final Size mediaQuery;
  final String img;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              imageUrl: img,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        AppColors.blackColor.withOpacity(.27),
                        BlendMode.darken,
                      ),
                      image: imageProvider,
                    ),
                  ),
                );
              },
              errorWidget: (context, error, dynamic url) {
                return CustomShimmer(
                  height: mediaQuery.width - 50,
                  width: mediaQuery.width,
                );
              },
              placeholder: (ctx, str) {
                return CustomShimmer(
                  height: mediaQuery.width - 50,
                  width: mediaQuery.width,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                title.toUpperCase(),
                style: GoogleFonts.tinos(
                  textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
