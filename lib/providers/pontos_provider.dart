import 'dart:io';
import 'package:ficha_de_ponto_pk/ficha_de_ponto_pk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class PontosProvider with ChangeNotifier {
  List<Ponto> _pontos = [];
  int _nextId = 1;
  
  List<Ponto> get pontos => _pontos;

  Future<void> adicionarPonto(String nome, bool isSaida) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      final newPonto = Ponto(
        id: _nextId,
        nome: nome,
        imagePath: savedImage.path,
        isSaida: isSaida,
        dataHora: DateTime.now(),
      );

      _pontos.add(newPonto);
      _nextId++;
      notifyListeners();
    }
  }

  void deletarPonto(int id) {
    _pontos.removeWhere((ponto) => ponto.id == id);
    notifyListeners();
  }

  Ponto obterPontoPorId(int id) {
    return _pontos.firstWhere((ponto) => ponto.id == id);
  }
}
