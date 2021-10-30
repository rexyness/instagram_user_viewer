import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_public_api/instagram_public_api.dart';
import 'package:instagram_user_viewer/core/failure.dart';

import 'package:instagram_user_viewer/features/user_viewer/user_viewer_service.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_state.dart';

final userViewerControllerProvider = StateNotifierProvider.autoDispose<UserViewerController, UserViewerState>((ref) {
  final userViewerService = ref.watch(userViewerServiceProvider);
  ref.maintainState = true;
  return UserViewerController(
    userViewerService,
    UserViewerState(
      instaProfile: AsyncValue.data(InstaProfileData()),
      submittedUsername: "",
    ),
  );
});

class UserViewerController extends StateNotifier<UserViewerState> {
  final UserViewerService userViewerService;

  UserViewerController(
    this.userViewerService,
    UserViewerState state,
  ) : super(state);

  void setUsername(String username) {
    state = state.copyWith(submittedUsername: username.trim());
  }

  Future<void> getProfile() async {
    log('${state.submittedUsername} IS SET');
    if (state.submittedUsername.isEmpty) {
      state = state.copyWith(
        instaProfile: AsyncValue.error(
          Failure(message: 'Username cannot be empty'),
        ),
      );
      return;
    }
    state = state.copyWith(instaProfile: const AsyncValue.loading());
    final result = await userViewerService.getProfileByUsername(state.submittedUsername);
    result.when(
      (error) => state = state.copyWith(
        instaProfile: AsyncValue.error(error),
      ),
      (success) => state = state.copyWith(
        instaProfile: AsyncValue.data(success),
      ),
    );
  }
}
