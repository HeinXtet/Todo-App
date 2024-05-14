
import 'package:freezed_annotation/freezed_annotation.dart';
part 'LoginData.freezed.dart';
part 'LoginData.g.dart';

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    required String token,
  })  = _LoginData;
  factory LoginData.fromJson(Map<String,dynamic> json) => _$LoginDataFromJson(json);
}
