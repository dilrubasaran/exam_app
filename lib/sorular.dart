import 'dart:async';

import 'package:flutter/material.dart';

import 'bitir.dart';

class Sorular extends StatefulWidget {
  const Sorular({Key? key}) : super(key: key);

  @override
  State<Sorular> createState() => _SorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000;
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _SorularState extends State<Sorular> {
  String adSoyad = ' ';
  String ogrNo = ' ';

  int mevcutSoru = 0;
  String mevcutCevap = ' ';
  int puan = 0;

  int kullanilansure = 0;

  late Stopwatch _sayac;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
    mevcutSoru = 0;
    mevcutCevap = '';
    puan = 0;
    kullanilansure = 0;

  }
  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  void BitirinceYolla(){
    var data =[];
    data.add(adSoyad);
    data.add(ogrNo);
    data.add(puan.toString());
    data.add(zamaniFormatla(kullanilansure));
    Navigator.push(
      context,
    MaterialPageRoute(builder: (context)=> Bitir(),
      settings: RouteSettings(
        arguments: data,
    ),
    ));
  }

  void kontrolEt() {
    if(mevcutSoru>8){
      mevcutSoru =0;
      _timer.cancel();
      BitirinceYolla();
    }
    if (mevcutCevap == sorular[mevcutSoru]['dogrucevap']) {
      puan = puan + 10;
      mevcutSoru++;
      kullanilansure= kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset();
    } else {
      puan = puan - 10;
      mevcutSoru++;
      kullanilansure= kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset();
    }
  }

  var sorular = [
    {
      'soru': 'Fatih Sultan Mehmet\'in babası kimdir?',
      'cevaplar': ['I. Mehmet', 'II. Murat', 'Yıldırım Beyazıt'],
      'dogrucevap': 'II. Murat'
    },
    {
      'soru': 'Hangi yabancı futbolcu Fenerbahçe forması giymiştir?',
      'cevaplar': ['Simoviç', 'Schumacher', 'Prekazi'],
      'dogrucevap': 'Schumacher'
    },
    {
      'soru': 'Magna Carta hangi ülkenin kralıyla yapılmış bir sözleşmedir?',
      'cevaplar': ['İngiltere', 'Fransa', 'İspanya'],
      'dogrucevap': 'İngiltere'
    },
    {
      'soru': 'Hangisi tarihteki Türk devletlerinden biri değildir?',
      'cevaplar': ['Avar Kağanlığı', 'Emevi Devleti', 'Hun İmparatorluğu'],
      'dogrucevap': 'Emevi Devleti'
    },
    {
      'soru': 'Hangi ülke Asya kıtasındadır?',
      'cevaplar': ['Madagaskar', 'Peru', 'Singapur'],
      'dogrucevap': 'Singapur'
    },
    {
      'soru':
          'ABD başkanlarından John Fitzgerald Kennedy’e suikast düzenleyerek öldüren kimdir?',
      'cevaplar': ['Lee Harvey Oswald', 'Clay Shaw', 'Jack Ruby'],
      'dogrucevap': 'Lee Harvey Oswald'
    },
    {
      'soru':
          'Aşağıdaki hangi Anadolu takımı Türkiye Süper Liginde şampiyon olmuştur?',
      'cevaplar': ['Kocaelispor', 'Bursaspor', 'Eskişehirspor'],
      'dogrucevap': 'Bursaspor'
    },
    {
      'soru': 'Hangisi Kanuni Sultan Süleyman’ın eşidir?',
      'cevaplar': ['Safiye Sultan', 'Kösem Sultan', 'Hürrem Sultan'],
      'dogrucevap': 'Hürrem Sultan'
    },
    {
      'soru': 'Hangi hayvan memeli değildir?',
      'cevaplar': ['Penguen', 'Yunus', 'Yarasa'],
      'dogrucevap': 'Penguen'
    },
    {
      'soru': 'Osmanlı’da Lale devri hangi padişah döneminde yaşamıştır?',
      'cevaplar': ['III. Ahmet', 'IV. Murat', 'III. Selim'],
      'dogrucevap': 'III. Ahmet'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic>? data = [];
    data = ModalRoute.of(context)?.settings.arguments as List?;
    adSoyad = data![0];
    ogrNo = data[1];

    _sayac.start();
    if(_sayac.elapsedMilliseconds> 9999 && mevcutSoru<9){
      kullanilansure= kullanilansure +_sayac.elapsedMilliseconds ;
      _sayac.reset();
      mevcutSoru++;
    }
    if(mevcutSoru==9 && _sayac.elapsedMilliseconds>9999){
      Future.delayed(Duration.zero, () async{
        _sayac.reset();
        _sayac.stop();
        _timer.cancel();
        mevcutSoru =0;
        BitirinceYolla();
      });
    }

    var cevapListesi = [];

    for (var obj in sorular) {
      cevapListesi.add(obj['cevaplar']);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sorular'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'e-Sınav',
              style: TextStyle(fontSize: 60),
            ),
            Text(
              'Ad Soyad :' + adSoyad,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Öğrenci No:' + ogrNo,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Mevcut soru / Toplam Soru: ' +
                  mevcutSoru.toString() +
                  '/' +
                  sorular.length.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                sorular[mevcutSoru]['soru'].toString(),
                style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mevcutCevap = cevapListesi[0].toString();
                    });
                    kontrolEt();
                  },
                  child: Text(cevapListesi[mevcutSoru][0])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mevcutCevap = cevapListesi[1].toString();
                    });
                    kontrolEt();
                  },
                  child: Text(cevapListesi[mevcutSoru][1])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mevcutCevap = cevapListesi[2].toString();
                    });
                    kontrolEt();
                  },
                  child: Text(cevapListesi[mevcutSoru][2])),
            ),
            Text(zamaniFormatla(_sayac.elapsedMilliseconds),
            style: TextStyle(fontSize: 48),),
            Text('Kullanılan Süre:' + zamaniFormatla(kullanilansure),
              style: TextStyle(fontSize: 28),),

          ],
        ),
      ),
    );
  }
}
