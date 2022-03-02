import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_cubit.dart';
import 'action_slider/action_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = HomeCubit();
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                width: MediaQuery.of(context).size.width,
                child: const Text('Slide to confirm'),
                backgroundColor: Colors.grey,
                toggleColor: Colors.yellow,
                icon: SvgPicture.asset('assets/arrow_right.svg'),
                onSlide: (controller) async {
                  cubit.makeConfirm(controller);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
