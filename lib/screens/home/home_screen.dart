import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/form_screen.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(
          10,
          (index) => Container(
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
                      const Flexible(
                        child: Text(
                          'title',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                    ],
                  ),
                  const Flexible(
                      child: Text(
                    'description',
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! FormNavigationState,
        listenWhen: (previous, current) => current is FormNavigationState,
        listener: (context, state) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenForm(),
              ));
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () =>
                context.read<HomeBloc>().add(FormNavigationEvent()),
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
