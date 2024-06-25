import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficha_de_ponto_pk/ficha_de_ponto_pk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';


class PontosProvider with ChangeNotifier {
  List<Ponto> _pontos = [];
  int _nextId = 1;
  FirebaseFirestore storage = FirebaseFirestore.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String collection = "pontos";

  List<Ponto> get pontos => _pontos;

  Future<void> adicionarPonto(String nome, bool isSaida) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      final newPonto = Ponto(
         _nextId.toString(),
        nome,
        savedImage.path,
        isSaida,
        DateTime.now(),
      );

      // _pontos.add(newPonto);
      _nextId++;
      
      
      
    var data = <String, dynamic>{
    'id': newPonto.id,
    'nome': newPonto.nome,
    'imagePath': newPonto.imagePath,
    'isSaida': newPonto.isSaida,
    'dataHora': newPonto.dataHora,
    };
    var future = db.collection(collection).doc(newPonto.id.toString()).set(data);
    // var future = db.collection(collection).add(data);
    future.then((_){
       _pontos.add(newPonto);
        notifyListeners();
      }
    );
  
    }
  }

  // void deletarPonto(String id) {
  //   _pontos.removeWhere((ponto) => ponto.id == id);
  //   notifyListeners();
  // }

  Ponto obterPontoPorId(String id) {
    return _pontos.firstWhere((ponto) => ponto.id == id);
  }

  list(){
    db.collection(collection).get().then((QuerySnapshot qs){
      for (var doc in qs.docs){
        var ponto = doc.data() as Map<String, dynamic>;
        pontos.add(Ponto.fromMap(doc.id, ponto));
        notifyListeners();
      }
    });
  }
  
  delete(String id) {
    var future = db.collection(collection).doc(id).delete();
    future.then((_) {
      pontos.removeWhere((ponto) => ponto.id == id);
    notifyListeners();
  
      }
    );
  }
  
  
}
