import 'package:flutter/material.dart';
import 'package:ecommerce/view/home/data/home_data.dart';

import '../widgets/home_user_tile.dart';
import '../widgets/home_foryou_cards.dart';
import '../widgets/home_gradient_text.dart';

class HomeExploreScreen extends StatelessWidget {
  const HomeExploreScreen({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: .start,
        children: [
          HomeGradientText(
            title: 'Trending Brands',
            subTitle:
                'Loved by the community, picked by us — these brands are changing the game from the ground up.',
          ),

          ...List.generate(HomeData.customerListing.length, (i) {
            return HomeUserTile(customer: HomeData.customerListing[i]);
          }),

          HomeForyouCards(),
        ],
      ),
    );
  }
}
