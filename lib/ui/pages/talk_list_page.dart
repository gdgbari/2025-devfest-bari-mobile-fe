import 'package:devfest_bari_2024/logic/cubit/talk_cubit.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class TalkListPage extends StatelessWidget {
  const TalkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TalkCubit, TalkState>(
      listener: (context, state) {
        switch (state.status) {
          case TalkStatus.fetchInProgress:
          case TalkStatus.selectionInProgress:
            context.loaderOverlay.show();
            break;

          case TalkStatus.fetchSuccess:
            context.loaderOverlay.hide();
            break;

          case TalkStatus.fetchFailure:
            context.loaderOverlay.hide();
            // TODO: show error message
            break;

          case TalkStatus.selectionSuccess:
            context.loaderOverlay.hide();
            context.pushNamed(RouteNames.talkDetailsRoute.name);
            break;

          default:
            break;
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<TalkCubit, TalkState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final talk = state.talkList[index];
                      return TalkTile(
                        title: talk.title,
                        onTap: () =>
                            context.read<TalkCubit>().selectAnswer(talk),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: state.talkList.length,
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
      ),
    );
  }
}
