import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_user_viewer/core/constants.dart';
import 'package:instagram_user_viewer/core/failure.dart';
import 'package:instagram_user_viewer/core/widgets/primary_button.dart';
import 'package:instagram_user_viewer/features/user_viewer/result/result_screen.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_controller.dart';
import 'package:instagram_user_viewer/theme/palette.dart';


class UserViewerScreen extends ConsumerWidget {
  const UserViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram User Viewer'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ref.watch(userViewerControllerProvider).instaProfile is AsyncLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged: (value) async {
                        ref.read(userViewerControllerProvider.notifier).setUsername(value);
                      },
                      
                      initialValue: ref.watch(userViewerControllerProvider).submittedUsername,
                      
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Enter the username here',
                          border: OutlineInputBorder(),
                        ),
                    ),
                    const SizedBox(
                      height: kListItemSpacing,
                    ),
                    PrimaryButton(
                      onPressed: () async {
                        await ref.read(userViewerControllerProvider.notifier).getProfile();
                        FocusScope.of(context).unfocus();
                        ref.watch(userViewerControllerProvider).instaProfile.maybeWhen(error: (e, s, previousData) {
                          String message = 'something went wrong';
                          if (e is Failure) {
                            message = e.message;
                          }
                          CoolAlert.show(
                              context: context,
                              title: 'An error has occured',
                              type: CoolAlertType.error,
                              text: message,
                              confirmBtnColor: Palette.red500,
                              animType: CoolAlertAnimType.slideInLeft);
                        }, orElse: () {
                          Navigator.of(context).push(ResultScreen.route());
                        });
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
