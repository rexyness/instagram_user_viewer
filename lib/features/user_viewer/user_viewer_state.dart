import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_public_api/models/instaData.dart';

@immutable
class UserViewerState {
  final String submittedUsername;
  final AsyncValue<InstaProfileData> instaProfile;
  const UserViewerState({
    required this.submittedUsername,
    required this.instaProfile,
  });

  UserViewerState copyWith({
    String? submittedUsername,
    AsyncValue<InstaProfileData>? instaProfile,
  }) {
    return UserViewerState(
      submittedUsername: submittedUsername ?? this.submittedUsername,
      instaProfile: instaProfile ?? this.instaProfile,
    );
  }

  
}
