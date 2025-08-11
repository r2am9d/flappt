import 'package:dart_mappable/dart_mappable.dart';
import 'package:flappt/core/shared/index.dart';

part 'user_model.mapper.dart';

@MappableClass()
class UserModel with UserModelMappable {
  const UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.details,
  });

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      password: user.password,
      details: DetailsModel.fromEntity(user.details),
    );
  }

  final int id;
  final String username;
  final String password;
  final DetailsModel details;

  User toEntity() {
    return User(
      id: id,
      username: username,
      password: password,
      details: details.toEntity(),
    );
  }
}

@MappableClass()
class DetailsModel with DetailsModelMappable {
  DetailsModel({
    required this.firstname,
    required this.lastname,
    required this.balance,
  });

  factory DetailsModel.fromEntity(Details details) {
    return DetailsModel(
      firstname: details.firstname,
      lastname: details.lastname,
      balance: details.balance,
    );
  }

  final String firstname;
  final String lastname;
  final double balance;

  Details toEntity() {
    return Details(
      firstname: firstname,
      lastname: lastname,
      balance: balance,
    );
  }
}
