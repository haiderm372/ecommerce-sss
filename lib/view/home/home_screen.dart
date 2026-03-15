import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ecommerce/configs/themes/colors.dart';

import './widgets/home_search_field.dart';
import './screens/home_foryou_screen.dart';
import './screens/home_explore_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/home';
  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  final ValueNotifier<bool> _isPinned = ValueNotifier(false);

  // TabBar (~48) + SizedBox (16) = 64
  static const double _pinThreshold = 64;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        _isPinned.value = _scrollController.offset > _pinThreshold;
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _isPinned.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // TabBar — scrolls away with content
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.main,
                indicatorColor: AppColors.main,
                overlayColor: WidgetStatePropertyAll(
                  AppColors.main.withValues(alpha: 0.1),
                ),
                labelStyle: textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                  color: const Color(0xff2B2B2C),
                ),
                unselectedLabelStyle: textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                  color: const Color(0xff2B2B2C),
                ),
                tabs: const [
                  Tab(text: 'For You'),
                  Tab(text: 'Explore'),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Search field — pinned with liquid-glass background
            SliverPersistentHeader(
              pinned: true,
              delegate: _LiquidGlassSearchDelegate(_isPinned),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: const [HomeForyouScreen(), HomeExploreScreen()],
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassSearchDelegate extends SliverPersistentHeaderDelegate {
  _LiquidGlassSearchDelegate(this._isPinned);

  final ValueNotifier<bool> _isPinned;

  static const double _height = 64;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPinned,
      builder: (context, isPinned, _) {
        //When the search field is not pinned
        if (!isPinned) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: HomeSearchField(),
          );
        }

        // When the textField pinned then show this view
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                border: const Border(
                  top: BorderSide(color: Colors.white38, width: 0.8),
                  bottom: BorderSide(color: Colors.white24, width: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.18),
                    blurRadius: 16,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const HomeSearchField(),
            ),
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(_LiquidGlassSearchDelegate oldDelegate) => false;
}
