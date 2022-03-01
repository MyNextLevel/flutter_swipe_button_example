import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> makeConfirm() async {
    emit(state.copyWith(isLoading: true));
    Future.delayed(
      const Duration(seconds: 3),
      () {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
