part of 'show_attendance_cubit.dart';

@immutable
sealed class ShowAttendanceState {}

final class ShowAttendanceInitial extends ShowAttendanceState {}

final class SuccessDataState extends ShowAttendanceState {}

final class LoadingState extends ShowAttendanceState {}

final class FailureDataState extends ShowAttendanceState {
  final String massageError;

  FailureDataState(this.massageError);
}
