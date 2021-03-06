import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/shimmer.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/home_screen/presentation/section/live_streem.dart';
import 'package:esport_flame/features/home_screen/presentation/section/play_tournaments.dart';
import 'package:esport_flame/features/home_screen/presentation/section/popular_games_section.dart';
import 'package:esport_flame/features/home_screen/presentation/section/widgets/shadow_button.dart';
import 'package:esport_flame/features/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final userIdController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late SwiperController _swiperController;
  late RefreshController _refreshController;

  @override
  void initState() {
    _swiperController = SwiperController();
    _refreshController = RefreshController();
    final userId = ref.read(userIdController.notifier).getUserId();
    log('$userId');
    super.initState();
  }

  void _onRefresh() {
    _refreshController.requestRefresh();
    //todo
    _refreshController.refreshCompleted();
  }

  void _onLoading(int next) {
    _refreshController.requestLoading();
    //todo
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: AppColors.redColor,
        child: MenuNavBar(),
      ),
      appBar: AppBar(
        title: Text(
          'E-sport Flame',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: CustomBodyWidget(
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: () => _onLoading,
          // ignore: prefer_const_constructors
          header: ClassicHeader(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('ads').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      log('Warning error alert for ads snapshot data !!!');
                      return const SizedBox();
                    } else if (snapshot.hasData) {
                      final adsData = snapshot.data as QuerySnapshot;

                      return SizedBox(
                        height: mediaQuery.height / 3.5,
                        child: Swiper(
                          layout: SwiperLayout.STACK,
                          itemHeight: mediaQuery.height / 3.5,
                          itemWidth: mediaQuery.width - 20,
                          itemCount: adsData.docs.length,
                          onTap: (index) {},
                          autoplayDelay: 500,
                          duration: 1000,
                          physics: const BouncingScrollPhysics(),
                          autoplay: true,
                          controller: _swiperController,
                          itemBuilder: (BuildContext context, int index) {
                            final _data = adsData.docs[index];
                            return Card(
                              elevation: 0,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: mediaQuery.height / 3.5,
                                    width: mediaQuery.width - 15,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: '${_data['image']}',
                                        fit: BoxFit.cover,
                                        errorWidget: (ctx, str, dynamic dy) {
                                          return CustomShimmer(
                                            height: mediaQuery.height / 3.5,
                                            width: mediaQuery.width - 15,
                                          );
                                        },
                                        placeholder: (ctx, str) {
                                          return CustomShimmer(
                                            height: mediaQuery.height / 3.5,
                                            width: mediaQuery.width - 15,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    right: 15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: mediaQuery.width / 2,
                                          child: Text(
                                            '${_data['adsTitle']}',
                                            style: GoogleFonts.tinos(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.greencolor,
                                                  ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${_data['aboutInfo']}',
                                          style: GoogleFonts.tinos(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.whiteColor,
                                                ),
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Text(
                                      'Ads.',
                                      style: GoogleFonts.tinos(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        width: mediaQuery.width - 40,
                        height: mediaQuery.height / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const CustomShimmer(),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttons(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<PlayTournaments>(
                              builder: (_) => PlayTournaments(
                                mediaQuery: mediaQuery,
                              ),
                            ),
                          );
                        },
                        text: 'Play Tournaments',
                      ),
                      const SizedBox(width: 15),
                      Buttons(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<LiveStreem>(
                              builder: (_) => LiveStreem(
                                mediaQuery: mediaQuery,
                              ),
                            ),
                          );
                        },
                        text: 'Live Streems',
                      ),
                    ],
                  ),
                ),
                PopularSection(
                  mediaQuery: mediaQuery,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
