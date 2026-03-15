import '../../../configs/assets/images/images.dart';
import '../../../res/models/customer_model.dart';
import '../../../res/models/for_you_model.dart';

class HomeData {
  static List<ForYouModel> foryouListing = [
    ForYouModel(
      image: AppImages.blackPerson,
      title: 'Urban Edge',
      description: 'Bold streetwear for the modern explorer.',
    ),
    ForYouModel(
      image: AppImages.whitePerson,
      title: 'Clean Minimal',
      description: 'Effortless whites for everyday elegance.',
    ),
    ForYouModel(
      image: AppImages.blackShirt,
      title: 'Classic Black',
      description: 'Timeless black tops that never go out of style.',
    ),
    ForYouModel(
      image: AppImages.sportShoe,
      title: 'Sport Vibes',
      description: 'Performance sneakers built for the streets.',
    ),
    ForYouModel(
      image: AppImages.whiteShoe,
      title: 'Fresh Kicks',
      description: 'Clean white sneakers for a crisp finish.',
    ),
    ForYouModel(
      image: AppImages.pinkShirt,
      title: 'Soft Tones',
      description: 'Pastel pinks that bring warmth to any outfit.',
    ),
    ForYouModel(
      image: AppImages.whitePerson,
      title: 'Light & Airy',
      description: 'Breathable summer styles for sunny days.',
    ),
  ];

  static List<CustomerModel> customerListing = [
    CustomerModel(
      image: AppImages.blackPerson,
      name: "Amanda's Boutique",
      description:
          'A modern designer with a youthful spirit, dedicated to hand-making every piece with care.',
    ),
    CustomerModel(
      image: AppImages.blackPerson,
      name: "Marcus Street Co.",
      description:
          'Urban streetwear rooted in culture, crafted for those who move with purpose.',
    ),
    CustomerModel(
      image: AppImages.blackPerson,
      name: "Noir & Co.",
      description:
          'Luxury minimalism meets bold design in every curated collection.',
    ),
    CustomerModel(
      image: AppImages.whitePerson,
      name: "Ivory Thread",
      description:
          'Soft, sustainable fashion for women who value comfort and style equally.',
    ),
    CustomerModel(
      image: AppImages.whitePerson,
      name: "Blanc Studio",
      description:
          'Clean lines, neutral tones, and timeless silhouettes for the modern wardrobe.',
    ),
    CustomerModel(
      image: AppImages.whitePerson,
      name: "The Linen House",
      description:
          'Ethically sourced linen pieces designed to last a lifetime.',
    ),
  ];
}
