import '../../domain/entities/user.dart';

/// Serializable [User] used at the data boundary.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson({String? password}) {
    return <String, dynamic>{
      'id': id,
      'name': fullName,
      'email': email,
      'password': ?password,
    };
  }
}
