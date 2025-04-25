import 'package:flip_card_swiper/flip_card_swiper.dart';
import 'package:flutter/material.dart';

import 'card_swipe_widget.dart';

/*
create by Dhramendra Kumar on 25th April 2025 at 6pm
this si demo for whip cards like as apple wallet card
 */

class FlipCard extends StatefulWidget {
  const FlipCard({super.key});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> {
  ///this is is a list of card those i want to show bellow
  final List<Map<String, dynamic>> cards = [
    {'color': Colors.blue, 'text': 'Hello! Peter'},
    {'color': Colors.red, 'text': 'What are your doing?'},
    {'color': Colors.green, 'text': 'Are you okay?'},
    {'color': Colors.pink, 'text': '''Let's meet today evening'''},
    {'color': Colors.black26, 'text': 'Hey Dharmendra!'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Card Swiper"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            FlipCardSwiper(
              cardData: cards,
              animationDuration: Duration(seconds: 1),
              onCardChange: (newIndex) {
                debugPrint("onCardChange :::: $newIndex");
              },
              onCardCollectionAnimationComplete: (value) {
                debugPrint("onCardCollectionAnimationComplete :::: $value");
              },
              // Build each card widget
              cardBuilder: (context, index, visibleIndex) {
                final card = cards[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: card['color'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    card['text'],
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              },
            ),
            SizedBox(height: 50),

            ///this is different flip card
            AppleWalletSwiper(
              cardData: cards,
              cardBuilder: (context, index, visibleIndex) {
                return Container(
                  width: 370,
                  height: 200,
                  decoration: BoxDecoration(
                    // color: Colors.blueGrey,
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      cards[index]['text'],
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              },
              onCardChange: (index) {
                debugPrint('Current card: $index');
              },
            ),
          ],
        ),
      ),
    );
  }
}
