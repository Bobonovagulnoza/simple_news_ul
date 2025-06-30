import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/app_assets.dart';
import 'package:news_app/core/widgets/app_container.dart';
import 'package:news_app/core/widgets/app_image.dart';
import 'package:news_app/features/home/presentation/screens/bookmark_screen.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';
import 'package:news_app/features/home/presentation/screens/search_screen.dart';
import 'package:news_app/features/home/presentation/screens/settings_screen.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class Pages extends ConsumerStatefulWidget {
  const Pages({super.key});

  @override
  ConsumerState<Pages> createState() => _PagesState();
}

class _PagesState extends ConsumerState<Pages> {
  late final PageController _pageController;

  final List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    // final selectedIndexProvider = StateProvider<int>((ref) => 0);
    // final selectedIndex = ref.watch(selectedIndexProvider);
    // ref.read(selectedIndexProvider.notifier).state = index;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        children: pages,
      ),
      bottomNavigationBar: AppContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              index: 0,
              selectedIndex: selectedIndex,
              selectedIcon: AppAssets.homeSelected,
              unselectedIcon: AppAssets.homeUnselected,
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 0;
                _pageController.jumpToPage(0);
              },
            ),
            _NavItem(
              index: 1,
              selectedIndex: selectedIndex,
              selectedIcon: AppAssets.searchSelected,
              unselectedIcon: AppAssets.searchUnselected,
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 1;
                _pageController.jumpToPage(1);
              },
            ),
            _NavItem(
              index: 2,
              selectedIndex: selectedIndex,
              selectedIcon: AppAssets.bookmarkSelected,
              unselectedIcon: AppAssets.bookmarkUnselected,
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 2;
                _pageController.jumpToPage(2);
              },
            ),
            _NavItem(
              index: 3,
              selectedIndex: selectedIndex,
              selectedIcon: AppAssets.settingsSelected,
              unselectedIcon: AppAssets.settingsUnselected,
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 3;
                _pageController.jumpToPage(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String selectedIcon;
  final String unselectedIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: AppImage(
        image: isSelected ? selectedIcon : unselectedIcon,
        width: 24,
        height: 24,
      ),
    );
  }
}
