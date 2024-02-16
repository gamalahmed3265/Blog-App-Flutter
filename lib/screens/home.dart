import 'package:blogapp/widget/animated_blog_post_card.dart';
import 'package:flutter/material.dart';
import 'package:models/arc/blog_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  late List<BlogPost> blogPosts;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.25);

    blogPosts = [
      ...BlogPost.blogPosts,
      ...BlogPost.blogPosts,
      ...BlogPost.blogPosts,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("atombox"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: blogPosts.length,
            padEnds: false,
            itemBuilder: (context, index) => AnimatedBlogPostCard(
                  blogPosts: blogPosts[index],
                  cardIndex: index,
                )),
      ),
    );
  }
}
