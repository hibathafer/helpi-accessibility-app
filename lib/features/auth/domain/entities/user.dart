import 'package:equatable/equatable.dart';

/// Authenticated account. Domain layer has no Flutter dependencies.
class User extends Equatable {
  const User({required this.id, required this.fullName, required this.email});

  final String id;
  final String fullName;
  final String email;

  @override
  List<Object?> get props => [id, fullName, email];
}
