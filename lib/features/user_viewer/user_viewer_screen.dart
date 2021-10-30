import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_user_viewer/core/constants.dart';
import 'package:instagram_user_viewer/core/widgets/primary_button.dart';
import 'package:instagram_user_viewer/features/user_viewer/result/result_screen.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_controller.dart';
import 'package:instagram_user_viewer/theme/palette.dart';

class UserViewerScreen extends ConsumerWidget {
  const UserViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram User Viewer'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) async {
                  ref.read(userViewerControllerProvider.notifier).setUsername(value);
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
              PrimaryButton(
                onPressed: () async {
                  await ref.read(userViewerControllerProvider.notifier).getProfile();
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).push(ResultScreen.route());
                },
                text: 'Submit',
                isLoading: ref.watch(userViewerControllerProvider).instaProfile is AsyncLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
