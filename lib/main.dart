import 'package:flutter/material.dart';
import 'package:gaimzone/utils/theme.dart';

import 'View/Screens/Auction/auction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Gaim Zone',
      home: AuctionScreen(),
    );
  }
}
