import 'package:example_app/hakkinda.dart';
import 'package:example_app/sorular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/hakkinda': (context) => Hakkinda(),
      },
      home: const MyHomePage(title: 'Anasayfa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String adSoyad = ' ';
  String ogrNo = ' ';

  void kontrol() {
    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      var data = [];
      data.add(adSoyad);
      data.add(ogrNo);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Sorular(),
              settings: RouteSettings(
                arguments: data,
              ),
          ));
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;
    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    void _adSoyadKaydet(String text) {
      setState(() {
        adSoyad = text;
      });
    }

    void _ogrNoKaydet(String text) {
      setState(() {
        ogrNo = text;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Adnız Soyadınız'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _adSoyadKaydet(text);
                },
                decoration: const InputDecoration(
                  hintText: 'Adınız ve Soyadınızı giriniz',
                ),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                  //Tek bir satırda işlemi yapmak isteniyorsa
                ],
              ),
            ),
            Text('Öğrenci Numaranız:'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _ogrNoKaydet(text);
                },
                decoration: const InputDecoration(
                  hintText: 'Öğrenci numaranızı giriniz',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: butonpasif ? null : kontrol,
                  child: Text('Sınava Başla')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hakkinda()),
                    );
                  },
                  child: Text('Hakkında')),
            ),
          ],
        ),
      ),
    );
  }
}
