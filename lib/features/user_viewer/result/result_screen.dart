import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_user_viewer/core/constants.dart';
import 'package:instagram_user_viewer/core/failure.dart';
import 'package:instagram_user_viewer/features/user_viewer/result/text_card.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ref.watch(userViewerControllerProvider).instaProfile.value.username ?? ''),
            if (ref.watch(userViewerControllerProvider).instaProfile.value.isVerified ?? false)
              const SizedBox(
                width: 8,
              ),
            if (ref.watch(userViewerControllerProvider).instaProfile.value.isVerified ?? false)
              const Icon(
                Icons.verified,
                color: Colors.cyan,
              )
          ],
        ),
        centerTitle: true,
      ),
      body: ref.watch(userViewerControllerProvider).instaProfile.when(
            data: (data) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CircularProfilePicture(profilePicURL: data.profilePicURL ?? '',),
                  const SizedBox(height: kListItemSpacing,),
                  if (data.bio?.isNotEmpty ?? false)
                    TextCard(
                      title: '${data.fullName}',
                      desc: data.bio ?? '',
                    ),
                    // TextCard(title: 'External Link', desc: data.externalURL ?? '')
                ],
              );
            },
            error: (e, es, previousData) {
              log('Error block inside screen ${e.toString()}');
              if (e is Failure) {
                return Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/errorCat.png',
                      fit: BoxFit.cover,
                    ),
                    Text(e.message),
                    const Spacer(),
                  ],
                );
              }
              return Center(child: Text(e.toString()));
            },
            loading: (_) => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

class CircularProfilePicture extends StatelessWidget {
  final String profilePicURL;
  const CircularProfilePicture({
    Key? key,
    required this.profilePicURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0), //width of the border
            child: ClipOval(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                // this width forces the container to be a circle
                height: 300.0, // this height forces the container to be a circle
                child: Image.network(
                  profilePicURL,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                ),
                decoration: kInnerDecoration,
              ),
            ),
          ),
          decoration: kGradientBoxDecoration,
        ),
      ),
    );
  }
}
