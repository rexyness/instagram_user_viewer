import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_user_viewer/core/constants.dart';
import 'package:instagram_user_viewer/core/failure.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_controller.dart';
import 'package:instagram_user_viewer/theme/palette.dart';

class UserViewerScreen extends ConsumerWidget {
  const UserViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onSubmitted: (value) async {
                    ref.read(userViewerControllerProvider.notifier).getProfile(value);
                  },
                  style: textTheme.bodyText1!.copyWith(color: Palette.almostBlack),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                const SizedBox(
                  height: kListItemSpacing,
                ),
                ref.watch(userViewerControllerProvider).instaProfile.when(
                      data: (data) => Text(data.bio ?? 'No bio is set'),
                      error: (e, es, previousData) {
                        log('Error block inside screen ${e.toString()}');
                        if (e is Failure) {
                          return Text(e.message);
                        } 
                          return Text(e.toString());
                        
                      },
                      loading: (_) => const CircularProgressIndicator(),
                    )
              ],
            )),
      ),
    );
  }
}
