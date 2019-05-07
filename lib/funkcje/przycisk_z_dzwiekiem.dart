import 'package:flutter/material.dart';
import 'package:glina_soundboard/funkcje/odtworz_dzwiek.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:glina_soundboard/funkcje/dodaj_do_ulubionych.dart';
import 'package:glina_soundboard/funkcje/kolory_przyciskow.dart';
import 'package:glina_soundboard/funkcje/dni.dart';

const int _progLuminacji = 128; //min: 0, max: 255

GestureDetector przyciskZDzwiekiem(
    int idDzwieku, String opis, BuildContext context) {
  if (indeksKoloru + 1 == koloryPrzyciskow.length) {
    indeksKoloru = 0;
  } else {
    indeksKoloru++;
  }
  Color _kolor = koloryPrzyciskow[indeksKoloru];

  bool _czyCiemny(Color kolor) {
    String string = kolor.toString();
    string = string.substring(10, 16); ///Color(0xffffffff) do ffffff
    final int r = int.parse(string.substring(0, 2), radix: 16);
    final int g = int.parse(string.substring(2, 4), radix: 16);
    final int b = int.parse(string.substring(4, 6), radix: 16);
    final double luminacja = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    if (luminacja < _progLuminacji) {
      return true;
    } else {
      return false;
    }
  }

  return GestureDetector(
    onLongPress: () {
      dodajDoUlubionych(idDzwieku, opis);
      final SnackBar snackBar = SnackBar(
        content: Text('Dodano do ulubionych ❤'),
        duration: Duration(seconds: 2),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    },
    child: Container(
      child: RaisedButton(
        onPressed: () {
          odtworzDzwiek(idDzwieku);
          zmienDni();
        },
        child: AutoSizeText(
          opis,
          softWrap: true,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 13,
            color: _czyCiemny(_kolor) ? Colors.white : Colors.black,
          ),
          minFontSize: 6,
          overflow: TextOverflow.ellipsis,
        ),
        color: _kolor,
      ),
    ),
  );
}