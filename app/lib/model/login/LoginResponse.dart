import 'package:freezed_annotation/freezed_annotation.dart';

import 'LoginData.dart';
part 'LoginResponse.freezed.dart';
part 'LoginResponse.g.dart';


@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required LoginData data,
  })  = _LoginResponse;
  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
}




// flutter packages pub run build_runner build