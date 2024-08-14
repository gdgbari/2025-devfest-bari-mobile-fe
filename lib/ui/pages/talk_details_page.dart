import 'dart:convert';

import 'package:devfest_bari_2024/logic/cubit/talk_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TalkDetailsPage extends StatelessWidget {
  const TalkDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: BlocBuilder<TalkCubit, TalkState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  const JsonEncoder.withIndent('  ')
                      .convert(state.selectedTalk.toMap()),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'INDIETRO',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
