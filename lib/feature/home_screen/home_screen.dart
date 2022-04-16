import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/feature/home_screen/section/popular_section.dart';
import 'package:esport_flame/feature/menu_nav_bar/menu_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
                SizedBox(
                  height: mediaQuery.height / 3.5,
                  child: Swiper(
                    layout: SwiperLayout.STACK,
                    itemHeight: mediaQuery.height / 3.5,
                    itemWidth: mediaQuery.width - 20,
                    itemCount: 5,
                    onTap: (index) {},
                    autoplayDelay: 500,
                    duration: 1000,
                    loop: true,
                    physics: const BouncingScrollPhysics(),
                    autoplay: true,
                    controller: _swiperController,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 0,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: mediaQuery.width - 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1650012008053-b96b760d8984?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                  fit: BoxFit.cover,
                                ),
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
                                        color: AppColors.blackColor,
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
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
                        onTap: () {},
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

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(
          key: key,
        );
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(4.0, 4.0),
                blurRadius: .0,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                text,
                style: GoogleFonts.baskervville(
                  textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
