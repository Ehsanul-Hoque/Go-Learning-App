- Set app name for iOS in Xcode
- Set placeholder images for banner and other places
- Update landing page bottom navigation to change by page view offset instead of page view current page
- Make page view infinitely scrollable in widget_carousal.dart
- Make carousal indicator by yourself if possible
- Make home page banner auto-scroll after a certain duration
- (SOMEWHAT DONE) Home banner ratio fix (Give aspect ratio to children instead of the whole page view)
- (DONE) Home page view pages should not be removed when off-screen
- (DONE) Make AnimParams two separate classes - Durations and Curves
- fake_loading.dart: load the child after the loading starts, but before the loading finishes.
  Else when the child is loaded after loading widget, a rough transition appears if the child takes too long to be created.
- When opening drawer, if the main screen contains many widgets, the animation lags. This should be fixed.
- In nav item, if the text is too large, an widget overflow error is shown.
  But if I wrap it inside a container and set maxWidth constraint, then the text gets ellipsized when being animated. FIX THIS.
- Resize image in cache to load and animate faster
- Fix YouTube player warnings (may need to fork the original repo is necessary)
- Show progress bar when loading a new video in course_before_enroll.dart.
- YouTube video gets cut when in full screen.
- YoutubePlayerBuilder WidgetsBinding in course_before_enroll.dart continues to listen
  even if the app goes to next screens, because the widget is not disposed.
  So what happens is when user goes to the checkout page and goes to landscape mode,
  the screen goes in immersive mode because the YoutubePlayerBuilder in the previous screen
  also goes to landscape mode and the WidgetsBinding listener gets fired. Fix this piece of shit.
  (Temporary fix is to close the course_before_enroll.dart page when going to the next screen.)
- Show large image on image tap in html_text.dart
- Change page navigation to named routes
- Quiz timer progress is animating smoothly by text color is not animating.
- Quiz page animation is not smooth
- Use selectors instead of consumers to optimize the page
- Improve logger
- Create network cache manager, network logger etc.
- Make all provider methods (read, watch, select) consume null notifiers too.
- Make ColumnRowGrid to take parent width as input, or use LayoutBuilder to get the parent width
  and then calculate the item width.
- Open FB links in FB app
- (DONE. SEPARATED PLAYER PAGE CREATED.)
  Configure fullscreen properly for AppVideoPlayerBuilder and other video player builders
  (Maybe create a separate page for fullscreen videos)
- Configure play/pause properly for video players when screen changes
- (DONE) Play videos (maybe with providers if better) when lecture items click
- Restore Vimeo player webview state on orientation change
  (Look inside the youtube player library to see how they did it, if they have done it already)
- Change Vimeo player background color
- Extract the vertical app bar (when a video gets full-screened) to separate widget
- Properly style the "Please select a video to play." text in app_video_player_builder.dart
- (DONE) Implement "Lock" and "Make It Public" properly
- Create a video queue to play course videos
- Play videos from the course_before_enroll.dart page instead of chapter_item.dart widget
- (DONE) *** IMPORT FONTS IN THE ASSETS FOLDER TO USE IN TEXT STYLES. ***
  *** DO NOT GET FONTS FROM NETWORK IN THE DEFAULT_PARAMS.DART FILE. ***
- (DONE) *** DELETE FLUTTER_LOREM PACKAGE FROM PUBSPEC.YAML ***
- Set up ObjectBox for iOS (using Xcode preferably)
- Improve SnackBar to integrate WidgetsBinding.instance.addPostFrameCallback when possible
- Extract common SnackBars, such as "NO INTERNET" SnackBar etc
- Set Up Google sign in for iOS from https://pub.dev/packages/google_sign_in
- AuthApiNotifier: remove the "ignore: use_build_context_synchronously" warning
  and handle the warning properly
- Convert Google Log In into an interceptor. Also, convert interceptors into async functions
- Cancel the network calls when resetting
- Option to update profile picture in user profile
- (DONE) Update UserNotifier to update properly when AuthApiNotifier is updated
- Change AuthApiNotifier name to something more clear about what it does
- Do not cache for POST calls
- *** REMOVE SAMPLE DATA FILE ***
- Handle unauthenticated or other responses properly
- Refresh course_before_enroll.dart in case user logged in from there
  and see that he/she is already enrolled in that course
- Create and implement text input validator classes
- 