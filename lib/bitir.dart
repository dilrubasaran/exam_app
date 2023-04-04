import 'package:flutter/material.dart';

class Bitir extends StatefulWidget {
  const Bitir({Key? key}) : super(key: key);

  @override
  State<Bitir> createState() => _BitirState();
}

class _BitirState extends State<Bitir> {
  @override
  Widget build(BuildContext context) {
    List<dynamic>? data = [];
    data = ModalRoute.of(context)?.settings.arguments as List?;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('e-Sınav', style: TextStyle(fontSize: 60),),
            Text(data![0].toString()),
            Text(data[1].toString()),
            Text(data[2].toString()),
            Text(data[3].toString()),
            ElevatedButton(onPressed:(){
              Navigator.pushNamed(context, '/');
              }, child: Text('Anasayfaya Dön'))
          ],
        ),
      ),
    );
  }
}
