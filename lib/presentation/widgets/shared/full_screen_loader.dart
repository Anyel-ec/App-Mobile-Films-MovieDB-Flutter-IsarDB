import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    'Cargando...',
    'Espera un momento...',
    'Estamos preparando todo...',
    'Casi listo...',
    'Un momento por favor...',
  ];

  Stream <String> getLoadingMessage()  {
    return Stream.periodic(const Duration(milliseconds: 500), (step){
      return messages[step % messages.length];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Cargando...'),
        const SizedBox(height: 20),
        const CircularProgressIndicator(),
        const SizedBox(height: 20),

        StreamBuilder(
          stream: getLoadingMessage(),
           builder: (context, AsyncSnapshot<String> snapshot) {
             if (!snapshot.hasData) {
               return const Text('Cargando...');
             }
             return Text(snapshot.data!);
           }
        )
      ],
    ));
  }
}
