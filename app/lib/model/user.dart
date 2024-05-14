import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';


@freezed
class User with _$User {
  const factory User({
    required int userId,
    required String title,
    required bool completed
  })  = _User;
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
}



// flutter packages pub run build_runner build