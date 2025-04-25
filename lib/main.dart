import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

/*
create by Dhramendra Kumar on 25th April 2025 at 6pm
 i have create card swiper demo with animated
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flip Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FlipCard(),
    );
  }
}
