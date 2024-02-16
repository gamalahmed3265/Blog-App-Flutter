import 'package:flutter/material.dart';
import 'package:models/arc/blog_post.dart';

class AnimatedBlogPostCard extends StatelessWidget {
  final BlogPost blogPosts;
  final int cardIndex;
  const AnimatedBlogPostCard(
      {super.key, required this.blogPosts, required this.cardIndex});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer
    ];
    final fontColors = [
      colorScheme.onPrimary,
      colorScheme.onSecondary,
      colorScheme.onPrimaryContainer,
      colorScheme.onSecondaryContainer
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leadIconsContainer(colors, textTheme),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  authImage(),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: titleContainer(textTheme),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                color: colors[cardIndex % colors.length],
              ),
            ],
          ),
        )
      ],
    );
  }

  RichText titleContainer(TextTheme textTheme) {
    return RichText(
        text: TextSpan(
            text: blogPosts.author,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            children: [
          TextSpan(text: "created a new post", style: textTheme.bodyLarge),
          TextSpan(text: blogPosts.publishedDateFormatted)
        ]));
  }

  ClipRRect authImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        blogPosts.authorImageUrl,
        height: 50,
        width: 50,
        cacheHeight: 50,
        cacheWidth: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  CircleAvatar leadIconsContainer(List<Color> colors, TextTheme textTheme) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: colors[cardIndex % colors.length],
      child: Text(
        blogPosts.authorInitials,
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
