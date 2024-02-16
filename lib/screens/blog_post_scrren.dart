import 'package:flutter/material.dart';
import 'package:models/models.dart';

class BlogPostScrren extends StatefulWidget {
  final String blogPostId;
  const BlogPostScrren({super.key, required this.blogPostId});

  @override
  State<BlogPostScrren> createState() => _BlogPostScrrenState();
}

class _BlogPostScrrenState extends State<BlogPostScrren> {
  late BlogPost blogPost;
  @override
  void initState() {
    blogPost = BlogPost.blogPosts
        .firstWhere((blogPost) => blogPost.id == widget.blogPostId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogPost.title),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: blogPost.paragraphs
              .map((paragraph) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SelectTableTextWithMenu(text: paragraph),
                  ))
              .toList()),
    );
  }
}

class SelectTableTextWithMenu extends StatefulWidget {
  final String text;
  const SelectTableTextWithMenu({super.key, required this.text});

  @override
  State<SelectTableTextWithMenu> createState() =>
      _SelectTableTextWithMenuState();
}

class _SelectTableTextWithMenuState extends State<SelectTableTextWithMenu> {
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      widget.text,
      contextMenuBuilder: (context, editableTextState) {
        return AdaptiveTextSelectionToolbar(
            anchors: editableTextState.contextMenuAnchors,
            children: [
              FilledButton(
                  onPressed: () {
                    print("editableTextState.");
                  },
                  child: const Text("Conver To Speech"))
            ]);
      },
    );
  }
}
