import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 400,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
      ),
      items: [
        'assets/images/carousel/1.jpg',
        'assets/images/carousel/2.jpg',
        'assets/images/carousel/3.jpg',
        'assets/images/carousel/4.jpg',
        'assets/images/carousel/5.jpg',
        'assets/images/carousel/6.jpg',
        'assets/images/carousel/7.jpg',
      ].map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        );
      }).toList(),

    );
  }
}