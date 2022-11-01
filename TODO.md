- Set app name for iOS in Xcode
- Set placeholder images for banner and other places
- Update landing page bottom navigation to change by page view offset instead of page view current page
- Make page view infinitely scrollable in widget_carousal.dart
- Make carousal indicator by yourself if possible
- Make home page banner auto-scroll after a certain duration
- Home banner ratio fix (Give aspect ratio to children instead of the whole page view)
- Home page view pages should not be removed when off-screen
- Make AnimParams two separate classes - Durations and Curves
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
- 