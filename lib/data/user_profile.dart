class UserProfile {
  static Map<String, dynamic>? profileData;

  static void saveProfile(Map<String, dynamic> data) {
    profileData = data;
  }

  static Map<String, dynamic>? getProfile() {
    return profileData;
  }
}