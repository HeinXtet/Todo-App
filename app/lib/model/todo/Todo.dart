import 'package:freezed_annotation/freezed_annotation.dart';

part 'Todo.freezed.dart';

part 'Todo.g.dart';


@freezed
class Todo with _$Todo {
  const factory Todo({
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Description') required String description,
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
