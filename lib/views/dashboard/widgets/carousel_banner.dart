import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/app_colors.dart';

class CarouselBanner extends StatelessWidget {
  final List<String> items;
  final RxInt carouselIndex;

  const CarouselBanner({
    Key? key,
    required this.items,
    required this.carouselIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(item, fit: BoxFit.cover, width: double.infinity),
            );
          }).toList(),
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.95,
            onPageChanged: (index, reason) => carouselIndex.value = index,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: carouselIndex.value == index ? 20 : 8,
              decoration: BoxDecoration(
                color: carouselIndex.value == index
                    ? AppColors.primary
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
