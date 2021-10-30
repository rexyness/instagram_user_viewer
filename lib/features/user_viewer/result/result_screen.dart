import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_user_viewer/core/failure.dart';

import '../user_viewer_controller.dart';

class ResultScreen extends ConsumerWidget {
  static route({bool fullscreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreen(),
        fullscreenDialog: fullscreenDialog,
      );
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(userViewerControllerProvider).instaProfile.when(
            data: (data) {
              return Center(
                  child: Column(
                children: [
                  Image.network(
                    data.profilePicURL ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                  Text(data.bio ?? 'No bio is set'),
                ],
              ));
            },
            error: (e, es, previousData) {
              log('Error block inside screen ${e.toString()}');
              if (e is Failure) {
                return Center(
                  child: Text(e.message),
                );
              }
              return Center(child: Text(e.toString()));
            },
            loading: (_) => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
