import 'package:json_annotation/json_annotation.dart';
import 'package:proplay/utils/functions.dart';
part 'session.model.g.dart';

@JsonSerializable()
class Session {
  final int id;
  final int schedule;
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  final double? amount;
  final String address;
  final DateTime date;

  Session({
    required this.id,
    required this.schedule,
    required this.amount,
    required this.address,
    required this.date,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
