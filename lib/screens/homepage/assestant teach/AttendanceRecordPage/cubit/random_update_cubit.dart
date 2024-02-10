import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
part 'random_update_state.dart';

class RandomUpdateCubit extends Cubit<RandomUpdateState> {
  RandomUpdateCubit() : super(RandomUpdateInitial());
  late int randomCount = 0;
  rondomUpDate({required id}) async {
    final refrandom = FirebaseFirestore.instance.collection('random').doc(id);
    for (var i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 3));
      randomCount = Random().nextInt(100000) * 9965999;
      await refrandom.update({"randomSubject": randomCount});
      emit(RandomUpdateChangeState());
      print(randomCount);
    }
  }
}
