import 'package:dart_mappable/dart_mappable.dart';
import 'package:entity_mapper/entity_mapper.dart';
import 'package:flappt/core/modules/index.dart';

part 'user_model.mapper.dart';
part 'user_model.entity_mapper.dart';

@MappableClass()
@MapToEntity(User)
class UserModel with UserModelMappable, UserEntityMappable {
  const UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.details,
  });

  final int id;
  final String username;
  final String password;
  final DetailsModel details;
}

@MappableClass()
@MapToEntity(Details)
class DetailsModel with DetailsModelMappable, DetailsEntityMappable {
  DetailsModel({
    required this.firstname,
    required this.lastname,
    required this.balance,
  });

  final String firstname;
  final String lastname;
  final double balance;
}
