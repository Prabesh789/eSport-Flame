import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBodyWidget extends StatelessWidget {
  const CustomBodyWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConnectivityBuilder(
      builder:
          (BuildContext context, bool? connected, ConnectivityStatus? status) =>
              Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            bottom: false,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              color:
                  connected ?? true ? AppColors.greyColor : AppColors.redColor,
              height: connected ?? true ? 0 : 17,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: connected ?? true
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.wifi_off_sharp,
                            color: AppColors.whiteColor,
                            size: 12,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'No Internet Connection',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: AppColors.whiteColor),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
