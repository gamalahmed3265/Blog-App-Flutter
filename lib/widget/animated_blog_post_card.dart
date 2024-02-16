import 'package:flutter/material.dart';
import 'package:models/arc/blog_post.dart';

class AnimatedBlogPostCard extends StatelessWidget {
  final BlogPost blogPosts;
  const AnimatedBlogPostCard({super.key, required this.blogPosts});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 100,
          color: Colors.primaries[3],
          child: Center(child: Text("${blogPosts.title}")),
        )
      ],
    );
  }
}
