import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../cubit/number_trivia_cubit.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_controls.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: SingleChildScrollView(child: buildBody(context)));
  }

  BlocProvider<NumberTriviaCubit> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaCubit>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaCubit, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyTrivia) {
                    return const MessageDisplay(message: 'Start searching');
                  } else if (state is LoadingTrivia) {
                    return const LoadingWidget();
                  } else if (state is LoadedTrivia) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is ErrorTrivia) {
                    return MessageDisplay(message: state.message);
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Placeholder(),
                  );
                },
              ),
              const SizedBox(height: 20),
              const TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
