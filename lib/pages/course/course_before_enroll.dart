import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/promo_buy_panel/promo_buy_panel.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/models/page_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/pages/course/course_checkout.dart";
import "package:app/pages/course/course_details.dart";
import "package:app/pages/course/course_playlist.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/material.dart"
    show DefaultTabController, IconButton, Icons, Scaffold, Tab;
import "package:flutter/services.dart"
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class CourseBeforeEnroll extends StatefulWidget {
  final CourseGetResponseModel course;

  const CourseBeforeEnroll({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CourseBeforeEnroll> createState() => _CourseBeforeEnrollState();
}

class _CourseBeforeEnrollState extends State<CourseBeforeEnroll> {
  late final YoutubePlayerController _youtubePlayerController;
  late final List<PageModel> _pageModels;
  late final PageController _pageController;
  int _selectedTabBarIndex = 0;
  bool _pageViewScrolling = false;

  @override
  void initState() {
    String initialVideoId = SampleData.previewVideoId;
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: initialVideoId, // TODO change initial video id
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );
    _pageController = PageController(initialPage: 0);

    _pageModels = <PageModel>[
      PageModel(
        title: Res.str.courseDetails,
        page: CourseDetails(course: widget.course),
      ),
      PageModel(
        title: Res.str.coursePlaylist,
        page: CoursePlaylist(course: widget.course),
      ),
    ];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<CourseContentNotifier?>()?.youtubePlayerController =
          _youtubePlayerController;
    });
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    context.read<CourseContentNotifier?>()?.youtubePlayerController?.dispose();
    context.read<CourseContentNotifier?>()?.youtubePlayerController = null;
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Res.color.pageRootBg,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Res.color.pageBg,
          body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _youtubePlayerController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Res.color.videoProgressIndicator,
              progressColors: ProgressBarColors(
                playedColor: Res.color.videoProgressPlayed,
                handleColor: Res.color.videoProgressHandle,
              ),
              thumbnail: MyCachedImage(
                imageUrl: widget.course.thumbnail,
                fit: BoxFit.fill,
              ),
            ),
            onEnterFullScreen: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
            },
            onExitFullScreen: () {
              SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.manual,
                overlays: SystemUiOverlay.values,
              );
            },
            builder: (BuildContext context, Widget player) {
              return Stack(
                children: <Widget>[
                  NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.depth == 0 &&
                          notification is ScrollEndNotification) {
                        _pageViewScrolling = false;
                      }
                      return false;
                    },
                    child: DefaultTabController(
                      animationDuration: Res.durations.defaultDuration,
                      length: _pageModels.length,
                      child: Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: Res.dimen.videoAspectRatio,
                            child: Container(
                              color: Res.color.videoBg,
                              child: player,
                            ),
                          ),
                          SizedBox(
                            height: Res.dimen.smallSpacingValue,
                          ),
                          MyPlatformAppBar(
                            config: MyAppBarConfig(
                              backgroundColor: Res.color.appBarBgTransparent,
                              shadow: const <BoxShadow>[],
                              title: Text(
                                widget.course.title ?? "",
                              ),
                              subtitle: Text(
                                "${Res.str.by} ${widget.course.instructorName ?? ""}",
                              ),
                              startActions: <Widget>[
                                IconButton(
                                  // TODO extract this back button as a component
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                  ),
                                  iconSize: Res.dimen.iconSizeNormal,
                                  color: Res.color.iconButton,
                                  onPressed: () {
                                    PageNav.back(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Res.dimen.normalSpacingValue,
                            ),
                            child: AppTabBar(
                              tabs: _pageModels.map((PageModel page) {
                                return Tab(
                                  text: page.title,
                                );
                              }).toList(),
                              onTabChange: (int newSelectedIndex) {
                                _pageViewScrolling = true;
                                updatePage(newSelectedIndex, true);
                              },
                            ),
                          ),
                          Expanded(
                            child: PageView(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: PromoBuyPanel(
                      initialPrice:
                          widget.course.originalPrice?.toDouble() ?? 0,
                      discountedPrice: widget.course.price?.toDouble(),
                      onBuyCourseTap: onBuyCourseTap,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void updatePage(int index, bool updatePageView) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedTabBarIndex = index;

      if (updatePageView) {
        _pageController.animateToPage(
          _selectedTabBarIndex,
          duration: Res.durations.defaultDuration,
          curve: Res.curves.defaultCurve,
        );
      }
    });
  }

  void onBuyCourseTap(double finalPrice) {
    _youtubePlayerController.pause();

    PageNav.replace(
      context,
      CourseCheckout(
        course: widget.course,
        finalPrice: finalPrice,
      ),
    );
  }
}
