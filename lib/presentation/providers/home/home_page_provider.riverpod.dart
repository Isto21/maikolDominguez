import 'package:hooks_riverpod/hooks_riverpod.dart';

final homePageProvider = StateProvider<int>((ref) {
  return 0;
});

// final pageControllerProvider = StateProvider<PageController>((ref) {
//   print('redibujo');
//   final pageController =
//       PageController(initialPage: ref.read(homePageProvider), keepPage: true);
//   return pageController;
// });
