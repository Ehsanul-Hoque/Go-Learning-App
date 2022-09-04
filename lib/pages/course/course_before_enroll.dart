import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/models/page_model.dart";
import "package:app/pages/course/course_playlist.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/material.dart"
    show DefaultTabController, IconButton, Icons, Scaffold, Tab;
import "package:flutter/services.dart"
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class CourseBeforeEnroll extends StatefulWidget {
  final Map<String, String> course;

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
  int _selectedTabBarIndex = 0;

  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: SampleData.previewVideoId, // TODO change initial video id
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );

    _pageModels = <PageModel>[
      PageModel(
        title: Res.str.courseDetails,
      ),
      PageModel(
        title: Res.str.coursePlaylist,
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Res.color.pageRootBg,
      child: SafeArea(
        child: Scaffold(
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
                imageUrl: widget.course["banner"]!, // TODO Get banner from API
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
              return DefaultTabController(
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
                        avatarConfig: MyAppBarAvatarConfig.noAvatar(),
                        title: Text(
                          widget.course["title"]!, // TODO Get title from API
                        ),
                        subtitle:
                            "${Res.str.by} ${widget.course["instructor"]!}", // TODO change if necessary
                        startActions: <Widget>[
                          IconButton(
                            // TODO extract this back button as a component
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                        onTabChange: onTabChange,
                      ),
                    ),
                    Expanded(
                      // TODO convert to PageView
                      child: CoursePlaylist(
                        course: widget.course,
                        onVideoClick: (String videoId, bool isLocked) {
                          if (!isLocked) {
                            // _youtubePlayerController.pause();
                            _youtubePlayerController.load(videoId);
                          }
                        },
                        selectedVideoId: SampleData.previewVideoId,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onTabChange(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedTabBarIndex = index;
    });
  }
}
