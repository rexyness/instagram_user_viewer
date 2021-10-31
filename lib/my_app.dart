import 'package:flutter/material.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_screen.dart';

import 'theme/custom_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram User Viewer',
      theme: CustomTheme.lightTheme(context),
      home: const UserViewerScreen(),
      
    );
  }
}