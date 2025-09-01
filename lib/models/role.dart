enum UserRole { consumer, pro }

extension UserRoleX on UserRole {
  String get storageValue => this == UserRole.pro ? 'pro' : 'consumer';
  static UserRole fromStorage(String? v) {
    switch (v) {
      case 'pro':
        return UserRole.pro;
      case 'consumer':
      default:
        return UserRole.consumer;
    }
  }

  String get displayName => this == UserRole.pro ? 'Επαγγελματίας' : 'Καταναλωτής';
}
