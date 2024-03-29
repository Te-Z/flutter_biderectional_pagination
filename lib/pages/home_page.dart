import 'package:flutter/material.dart';
import 'package:flutter_biderectional_pagination/data/entities/character_entity.dart';
import 'package:flutter_biderectional_pagination/domain/useCase/get_character.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CharacterPagination> characterPagination;

  @override
  void initState() {
    characterPagination = GetCharater()(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: characterPagination,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("error"),
                );
              }
              final data = snapshot.data as CharacterPagination;
              final list = data.results;

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Text(list[index].name),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
