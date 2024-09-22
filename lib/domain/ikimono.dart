import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ikimono.freezed.dart';
part 'ikimono.g.dart';

@freezed
class Ikimono with _$Ikimono {
  const factory Ikimono({
    required int id,
    required String name,
    required String description,
    required String user,
    required String location,
    required String tag,
    @JsonKey(name: 'captured_date') required DateTime capturedDate,
    @JsonKey(name: 'ikimono_url') required String ikimonoUrl,
  }) = _Ikimono;

  factory Ikimono.fromJson(Map<String, Object?> json) =>
      _$IkimonoFromJson(json);
}
