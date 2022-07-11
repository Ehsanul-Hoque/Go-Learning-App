import 'package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart';
import 'package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart';
import 'package:app/components/bottom_nav/views/app_bottom_navigation_bar.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.veryLightGrey,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AppBottomNavigationBar(
            items: [
              AppBottomNavigationBarModel(
                icon: const Icon(CupertinoIcons.home),
                text: "Home",
              ),
              AppBottomNavigationBarModel(
                icon: const Icon(CupertinoIcons.book),
                text: "Courses",
              ),
              AppBottomNavigationBarModel(
                icon: const Icon(CupertinoIcons.profile_circled),
                text: "Profile",
              ),
            ],
            itemSize: AppBottomNavigationItemSize.flex,
            flex: 2,
          ),
        ),
      ),
    );
  }
}
