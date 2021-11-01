import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/insta_profile_data.dart';


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
