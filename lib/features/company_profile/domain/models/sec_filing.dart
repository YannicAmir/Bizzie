import 'package:equatable/equatable.dart';

class SecFiling extends Equatable {
  final String date;
  final String year;
  final String period;
  final String link;

  const SecFiling({
    required this.date,
    required this.year,
    required this.period,
    required this.link,
  });

  @override
  List<Object?> get props => [date, year, period, link];
}
