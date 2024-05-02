import 'package:json_annotation/json_annotation.dart';
import 'package:proplay/models/user.model.dart';
part 'sessionuser.model.g.dart';

@JsonSerializable()
class SessionUser {
  final int id;
  final int session;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(includeToJson: false)
  final User? user;
  @JsonKey(includeToJson: false)
  final int order;
  @JsonKey(includeToJson: false)
  final bool paid;
  @JsonKey(includeToJson: false)
  final bool assisted;
  @JsonKey(includeToJson: false)
  final bool late;

  SessionUser({
    required this.id,
    required this.session,
    required this.userId,
    this.user,
    required this.order,
    this.paid = false,
    this.assisted = false,
    this.late = false,
  });

  factory SessionUser.fromJson(Map<String, dynamic> json) =>
      _$SessionUserFromJson(json);
  Map<String, dynamic> toJson() => _$SessionUserToJson(this);
}
