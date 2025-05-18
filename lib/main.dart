import 'package:flutter/material.dart';
import 'package:gaimzone/utils/colors.dart';

import 'View/Screens/Auction/auction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaim Zone',
      theme: ThemeData(
        primaryColor: primaryBlue,
        fontFamily: 'Lufga',
        useMaterial3: true,
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      ),
      home: const AuctionScreen(title: 'Auction'),
    );
  }
}

