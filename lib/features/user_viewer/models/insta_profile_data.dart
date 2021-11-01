/// [InstaProfileData]
class InstaProfileData {
  final String? username;
  final String? profilePicURL;
  final bool? isPrivate;
  final bool? isVerified;
  final String? following;
  final String? followers;
  final String? bio;
  final String? externalURL;
  final String? fullName;

  InstaProfileData(
      {this.username,
      this.profilePicURL,
      this.isPrivate,
      this.isVerified,
      this.following,
      this.followers,
      this.bio,
      this.externalURL,
      this.fullName,});
}