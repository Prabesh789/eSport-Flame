import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/features/home_screen/section/live_streem.dart';
import 'package:esport_flame/features/home_screen/section/popular_section.dart';
import 'package:esport_flame/features/home_screen/widgets/shadow_button.dart';
import 'package:esport_flame/features/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
          enablePullDown: true,
          enablePullUp: false,
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
                          loop: true,
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
                        width: mediaQuery.width - 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('Loaging'),
                              SizedBox(
                                width: 4,
                              ),
                              JumpingDots(
                                color: Colors.yellow,
                                radius: 10,
                                numberOfDots: 3,
                                animationDuration: Duration(milliseconds: 200),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Buttons(
                        onTap: () {},
                        text: 'Play Tournaments',
                      ),
                      const SizedBox(width: 15),
                      Buttons(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const LiveStreem()));
                        },
                        text: 'Live Streems',
                      ),
                    ],
                  ),
                ),
                const PopularSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
