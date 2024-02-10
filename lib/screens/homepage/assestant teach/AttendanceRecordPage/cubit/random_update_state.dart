part of 'random_update_cubit.dart';

@immutable
sealed class RandomUpdateState {}

final class RandomUpdateInitial extends RandomUpdateState {}

final class StartMethodState extends RandomUpdateState {}

final class LoopMethodState extends RandomUpdateState {}
