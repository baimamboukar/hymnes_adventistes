import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SabbathSongBlocs extends StatelessWidget {
  final Widget child;
  const SabbathSongBlocs({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: child,
    );
  }
}
