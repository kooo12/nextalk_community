class AppConstants {
  // App Information
  static const String appName = 'NexTalk';
  static const String appTagline = 'Connect. Share. Discuss.';

  // App Version
  static const String appVersion = '1.0.0';

  // Collections
  static const String usersCollection = 'users';
  static const String postsCollection = 'posts';
  static const String commentsCollection = 'comments';
  static const String likesCollection = 'likes';
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';
  static const String tagsCollection = 'tags';
  static const String reportsCollection = 'reports';
  static const String notificationsCollection = 'notifications';
  static const String connectionsCollection = 'connections';

  // Pagination
  static const int postsPerPage = 10;
  static const int commentsPerPage = 20;
  static const int messagesPerPage = 30;

  // Image Upload
  static const int maxImageSizeMB = 5;
  static const List<String> allowedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/webp'
  ];

  // User Roles
  static const String roleUser = 'user';
  static const String roleAdmin = 'admin';

  // Cache Keys
  static const String cacheUserKey = 'current_user';
  static const String cacheThemeKey = 'theme_mode';
}
