import 'package:app/model/todo/Todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'TodoListResponse.freezed.dart';
part 'TodoListResponse.g.dart';

@freezed
class TodoListResponse with _$TodoListResponse{
  const factory TodoListResponse({
    required List<Todo> data,
  })  = _TodoListResponse;

  factory TodoListResponse.fromJson(Map<String,dynamic> json ) => _$TodoListResponseFromJson(json);
}