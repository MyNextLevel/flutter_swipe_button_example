import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'swipebuttonflutter.dart';
import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = HomeCubit();
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwipingButton(
                isLoading: state.isLoading,
                text: 'Swipe to finish',
                onSwipeCallback: () {
                  debugPrint('======> on swipe callback');
                  cubit.makeConfirm();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
