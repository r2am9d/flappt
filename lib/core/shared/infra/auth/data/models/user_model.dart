import 'package:flappt/core/shared/index.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.password,
    required super.details,
  });

  // Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      details: DetailsModel.fromJson(json['details'] as Map<String, dynamic>),
    );
  }

  // Creates a UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      password: user.password,
      details: DetailsModel.fromEntity(user.details),
    );
  }

  // Converts UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'details': (details as DetailsModel).toJson(),
    };
  }

  // Converts to User entity
  User toEntity() {
    return User(
      id: id,
      username: username,
      password: password,
      details: details,
    );
  }

  // Creates a copy with updated fields
  UserModel copyWith({
    int? id,
    String? username,
    String? password,
    Details? details,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      details: details ?? this.details,
    );
  }
}

// Details Model to handle the nested Details entity
class DetailsModel extends Details {
  DetailsModel({
    required super.firstname,
    required super.lastname,
    required super.balance,
  });

  // Creates a DetailsModel from JSON
  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      balance: json['balance'] as double,
    );
  }

  // Creates a DetailsModel from Details entity
  factory DetailsModel.fromEntity(Details details) {
    return DetailsModel(
      firstname: details.firstname,
      lastname: details.lastname,
      balance: details.balance,
    );
  }

  // Converts DetailsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'balance': balance,
    };
  }

  // Creates a copy with updated fields
  DetailsModel copyWith({
    String? firstname,
    String? lastname,
    double? balance,
  }) {
    return DetailsModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      balance: balance ?? this.balance,
    );
  }
}
