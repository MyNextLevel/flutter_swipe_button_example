import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swipe_button_example/action_slider/action_slider.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void makeConfirm(ActionSliderController controller) async {
    emit(state.copyWith(isLoading: true));
    controller.loading();
    debugPrint('=====> loading');
    await Future.delayed(const Duration(seconds: 5));
    emit(state.copyWith(isLoading: false));
    controller.success();
    debugPrint('=====> success');
    await Future.delayed(const Duration(seconds: 1));
    controller.reset();
    debugPrint('=====> reset');
  }
}
