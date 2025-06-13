import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovingCarouselScreen(),
    );
  }
}

class MovingCarouselScreen extends StatefulWidget {
  @override
  _MovingCarouselScreenState createState() => _MovingCarouselScreenState();
}

class _MovingCarouselScreenState extends State<MovingCarouselScreen> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  bool _isUserScrolling = false;
  bool _isScrollingForward = true;
  bool _isPaused = false;

  final List<String> images = [
    "https://source.unsplash.com/random/800x600?nature",
    "https://source.unsplash.com/random/800x600?water",
    "https://source.unsplash.com/random/800x600?mountain",
    "https://source.unsplash.com/random/800x600?forest",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _scrollController.addListener(_checkScrollPosition);
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients && !_isUserScrolling && !_isPaused) {
        double newOffset = _scrollController.offset + (_isScrollingForward ? 6 : -6);
        _scrollController.animateTo(
          newOffset,
          duration: Duration(milliseconds: 30),
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _isUserScrolling = true;
    Future.delayed(Duration(seconds: 2), () {
      _isUserScrolling = false;
    });
  }

  void _pauseAutoScroll() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeAutoScroll() {
    setState(() {
      _isPaused = false;
    });
  }

  void _checkScrollPosition() {
    if (_scrollController.hasClients) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double minScroll = _scrollController.position.minScrollExtent;
      double currentScroll = _scrollController.offset;

      if (currentScroll >= maxScroll - 10) {
        _isScrollingForward = false;
      } else if (currentScroll <= minScroll + 10) {
        _isScrollingForward = true;
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fast Moving Carousel (Pause on Long Press)")),
      body: SizedBox(
        height: 200,
        child: GestureDetector(
          onPanDown: (_) => _stopAutoScroll(), // Detect user scroll
          onLongPress: _pauseAutoScroll, // Pause auto-scroll on long press
          onLongPressUp: _resumeAutoScroll, // Resume auto-scroll when released
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    images[index],
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
