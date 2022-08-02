import "package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart";
import "package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart";
import "package:app/components/bottom_nav/views/app_bottom_navigation_bar.dart";
import "package:app/models/page_view_model.dart";
import "package:app/pages/home/explore.dart";
import "package:app/pages/home/favourites.dart";
import "package:app/pages/home/home.dart";
import "package:app/pages/home/exams.dart";
import "package:app/utils/app_colors.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final List<PageViewModel> _pageModels;
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _pageModels = const <PageViewModel>[
      PageViewModel(
        title: "Admission",
        icon: Icon(CupertinoIcons.home),
        page: Home(),
      ),
      PageViewModel(
        title: "Explore",
        icon: Icon(CupertinoIcons.search_circle),
        page: Courses(),
      ),
      PageViewModel(
        title: "Favourites",
        icon: Icon(CupertinoIcons.square_favorites_alt),
        page: Favourites(),
      ),
      PageViewModel(
        title: "Exams",
        icon: Icon(CupertinoIcons.pencil_outline),
        page: Exams(),
      ),
    ];

    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPageIndex > 0) {
          setState(() {
            _currentPageIndex = 0;
            /*_pageController.animateToPage(
              _currentPageIndex,
              duration: AppParameters.defaultAnimationDuration,
              curve: AppParameters.defaultAnimationCurve,
            );*/
          });
          return false;
        } else {
          return true;
        }
      },
      child: PlatformScaffold(
        backgroundColor: AppColors.veryLightGrey,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: _pageModels.map((PageViewModel model) {
                    return model.page;
                  }).toList(),
                  onPageChanged: (int newSelectedIndex) {
                    setState(() {
                      _currentPageIndex = newSelectedIndex;
                    });
                  },
                ),
              ),
              AppBottomNavigationBar(
                items: _pageModels.map((PageViewModel model) {
                  return AppBottomNavigationBarModel(
                    icon: model.icon,
                    text: model.title,
                  );
                }).toList(),
                selectedIndex: _currentPageIndex,
                itemSize: AppBottomNavigationItemSize.flex,
                flex: 2,
                onItemChangeListener: (int newSelectedIndex) {
                  setState(() {
                    _currentPageIndex = newSelectedIndex;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
