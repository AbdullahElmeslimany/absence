part of 'seclect_day_cubit.dart';

@immutable
sealed class SeclectDayState {}

final class SeclectDayInitial extends SeclectDayState {}

final class ChangeDayState extends SeclectDayState {
  final day;
  ChangeDayState({required this.day});
}
