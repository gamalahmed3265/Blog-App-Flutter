import 'package:flutter/material.dart';
import 'package:models/arc/blog_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.25);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("atombox"),
      ),
      body: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: BlogPost.blogPosts.length,
          padEnds: false,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(child: Text("$index")),
            );
          }),
    );
  }
}
