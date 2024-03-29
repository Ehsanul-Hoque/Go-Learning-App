part of "package:app/pages/home/landing.dart";

class LandingMainSection extends StatefulWidget {
  final ZoomDrawerController drawerController;

  const LandingMainSection({
    Key? key,
    required this.drawerController,
  }) : super(key: key);

  @override
  State<LandingMainSection> createState() => _LandingMainSectionState();
}

class _LandingMainSectionState extends State<LandingMainSection> {
  late final List<PageModel> _pageModels;
  late final PageController _pageController;
  int _currentPageIndex = 0;
  bool _pageViewScrolling = false;

  @override
  void initState() {
    _pageModels = <PageModel>[
      PageModel(
        title: Res.str.home,
        icon: const Icon(CupertinoIcons.home),
        page: const Home(),
      ),
      PageModel(
        title: Res.str.explore,
        icon: const Icon(CupertinoIcons.search_circle),
        page: const Courses(),
      ),
      // TODO uncomment the bottom pages
      //  if they are fully functional and needed
      /*PageModel(
        title: Res.str.favourites,
        icon: const Icon(CupertinoIcons.square_favorites_alt),
        page: const Favourites(),
      ),
      PageModel(
        title: Res.str.exams,
        icon: const Icon(CupertinoIcons.pencil_outline),
        page: const Exams(),
      ),*/
    ];

    _pageController = PageController(initialPage: 0);
    /*..addListener(() {
        double a = _pageController.offset;
        double b = MediaQuery.of(context).size.width;
        Utils.log("offset = $a, width = $b, page fraction = ${a / b}");
      })*/

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
        return goBack();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0 &&
              notification is ScrollEndNotification) {
            _pageViewScrolling = false;
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: Res.color.pageBg,
          body: Stack(
            children: <Widget>[
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _pageModels.map((PageModel model) {
                  return model.page;
                }).toList(),
                onPageChanged: (int newSelectedIndex) {
                  if (!_pageViewScrolling) {
                    updatePage(newSelectedIndex, false);
                  }

                  _pageViewScrolling = true;
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: MyPlatformAppBar(
                  config: MyAppBarConfig(
                    avatarConfig: MyAppBarAvatarConfig(context: context),
                    title: SvgPicture.asset(
                      Res.assets.logoSvg,
                      width: 75,
                      height: 32,
                      fit: BoxFit.fill,
                    ),
                    centerTitle: true,
                    endActions: <Widget>[
                      SizedBox(
                        width: Res.dimen.normalSpacingValue,
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.menu_rounded),
                        iconSize: Res.dimen.iconSizeNormal,
                        color: Res.color.iconButton,
                        onPressed: () {
                          widget.drawerController.toggle?.call();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Builder(
                  builder: (BuildContext context) {
                    bool isPortrait = (MediaQuery.of(context).orientation ==
                        Orientation.portrait);

                    return Center(
                      child: AppBottomNavigationBar(
                        key: ValueKey<bool>(isPortrait),
                        items: _pageModels.map((PageModel model) {
                          return AppBottomNavigationBarModel(
                            icon: model.icon,
                            text: model.title,
                          );
                        }).toList(),
                        selectedIndex: _currentPageIndex,
                        itemSize: AppBottomNavigationItemSize.flex,
                        // flex: isPortrait ? 2 : 1,
                        showOnlyIconForInactiveItem: false, // isPortrait,
                        onItemChange: (int newSelectedIndex) {
                          _pageViewScrolling = true;
                          updatePage(newSelectedIndex, true);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePage(int newPageIndex, bool updatePageView) {
    if (_currentPageIndex != newPageIndex) {
      setState(() {
        _currentPageIndex = newPageIndex;

        if (updatePageView) {
          _pageController.animateToPage(
            _currentPageIndex,
            duration: Res.durations.defaultDuration,
            curve: Res.curves.defaultCurve,
          );
        }
      });
    }
  }

  bool goBack() {
    if (widget.drawerController.isOpen?.call() == true) {
      widget.drawerController.close?.call();
      return false;
    } else if (_currentPageIndex > 0) {
      setState(() {
        _pageViewScrolling = true;
        updatePage(0, true);
      });
      return false;
    } else {
      return true;
    }
  }
}
