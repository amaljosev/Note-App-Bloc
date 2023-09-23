import 'package:flutter/material.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenForm extends StatelessWidget {
  const ScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 20)),
                validator: (value) => titleController.text.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                    hintStyle: TextStyle(fontSize: 20)),
                validator: (value) => descriptionController.text.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(5),
                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
