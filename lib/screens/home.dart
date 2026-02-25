import 'package:blog_app_flutter/models/blog_post.dart';
import 'package:blog_app_flutter/widget/animated_blog_post_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController pageController;
  late List<BlogPost> blogPosts;

  final Map<int, AnimationController> animationController = {};
  var middleCardIndex = -1;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.25);
    pageController.addListener(_calculatedMiddleCard);
    blogPosts = [
      ...BlogPost.blogPosts,
      ...BlogPost.blogPosts,
      ...BlogPost.blogPosts,
    ];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initlizedAnimation();
    });
  }

  void _initlizedAnimation() {
    int initMiddelCard = (pageController.page?.floor() ?? 0) + 2;

    for (var i = 0; i <= initMiddelCard; i++) {
      if (i == initMiddelCard) {
        animationController[i]?.forward();
      }
    }
    setState(() {
      middleCardIndex = initMiddelCard;
    });
  }

  void _calculatedMiddleCard() {
    int newMiddleCard = (pageController.page?.round() ?? 0) + 2;
    if (newMiddleCard > middleCardIndex) {
      animationController[newMiddleCard - 1]?.forward();
      setState(() {
        middleCardIndex = newMiddleCard;
      });
    }
    if (newMiddleCard < middleCardIndex) {
      animationController[newMiddleCard]?.reverse();
      setState(() {
        middleCardIndex = newMiddleCard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("atombox")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: blogPosts.length,
          padEnds: false,
          itemBuilder: (context, index) {
            animationController.putIfAbsent(
              index,
              () => AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 500),
              ),
            );

            var animation = Tween<double>(begin: 0.0, end: 0.4).animate(
              CurvedAnimation(
                parent: animationController[index]!,
                curve: Curves.bounceOut,
              ),
            );
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "blog-post",
                  arguments: blogPosts[index].id,
                );
              },
              child: AnimatedBlogPostCard(
                blogPosts: blogPosts[index],
                cardIndex: index,
                animation: animation,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.forEach((key, controller) => controller.dispose());
    pageController.removeListener(_calculatedMiddleCard);
    pageController.dispose();
    super.dispose();
  }
}
