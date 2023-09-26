import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/add_form_screen.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchSuccessEvent());
  }

  late String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state is FormNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAddForm(),
                ));
          } else if (state is ShowPopupMessageState) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Delete Note!!'),
                  content: const Text(
                    'Are you sure, do you really want to delete this note!',
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Discard'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Delete'),
                      onPressed: () => delete(context, id),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is SuccessState) {
            return GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(state.notesList.length, (index) {
                final note = state.notesList[index] as Map;
                id = note['_id'];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                note['title'] ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<HomeBloc>()
                                      .add(ShowDialogEvent());
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                        Flexible(
                            child: Text(
                          note['description'] ?? '',
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (state is LoadingState) {
            return const SizedBox.expand(
                child: Center(child: CircularProgressIndicator()));
          } else {
            return const SizedBox.expand(
              child: Center(child: Text('empty notes')),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeBloc>().add(FormNavigationEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void delete(BuildContext context, String id) {
  context.read<HomeBloc>().add(DeleteNoteEvent(id: id));
  Navigator.of(context).pop();
  context.read<HomeBloc>().add(FetchSuccessEvent());
}
