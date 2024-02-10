part of 'random_update_cubit.dart';

@immutable
sealed class RandomUpdateState {}

final class RandomUpdateInitial extends RandomUpdateState {}

final class RandomUpdateChangeState extends RandomUpdateState {}
