import 'package:blogapp/screens/blog_post_scrren.dart';
import 'package:blogapp/shared/theme.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: const AppTheme().themeData,
      debugShowCheckedModeBanner: false,
      routes: {"/": (context) => const HomePage()},
      onGenerateRoute: (settings) {
        if (settings.name == "blog-post") {
          return MaterialPageRoute(builder: (context) {
            return BlogPostScrren(blogPostId: settings.arguments as String);
          });
        }
      },
    );
  }
}
