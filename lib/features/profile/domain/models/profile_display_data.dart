import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_display_data.freezed.dart';

@freezed
abstract class ProfileDisplayData with _$ProfileDisplayData {
  const factory ProfileDisplayData({
    required String displayName,
    required String sectorName,
    required String sectorDescription,
    required DateTime joinedDate,
    required double? sectorPe,
    required double? sectorAverageChange,
    required DateTime? marketDataDate,
  }) = _ProfileDisplayData;
}
