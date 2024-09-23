import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String username,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
}
