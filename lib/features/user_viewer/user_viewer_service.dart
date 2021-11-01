import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:instagram_user_viewer/core/failure.dart';
import 'package:instagram_user_viewer/features/user_viewer/models/insta_profile_data.dart';
import 'package:instagram_user_viewer/features/user_viewer/user_viewer_repository.dart';
import 'package:multiple_result/multiple_result.dart';

final userViewerServiceProvider = Provider<UserViewerService>((ref) {
  final userViewerRepository = ref.watch(userViewerRepositoryProvider);
  return UserViewerService(userViewerRepository: userViewerRepository);
});

class UserViewerService {
  final UserViewerRepository userViewerRepository;
  UserViewerService({
    required this.userViewerRepository,
  });

  Future<Result<Failure, InstaProfileData>> getProfileByUsername(String username) async {
    try {
      final result = await userViewerRepository.getProfileByUsername(username);
      return Success(result);
    } on Failure catch (failure) {
      log('Failure block in Service INVOKED');
      return Error(failure);
    }
  }
}
