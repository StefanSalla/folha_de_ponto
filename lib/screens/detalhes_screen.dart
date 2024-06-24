import 'dart:io';
import 'package:ficha_de_ponto/providers/pontos_provider.dart';
import 'package:ficha_de_ponto_pk/ficha_de_ponto_pk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetalhesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int pontoId = ModalRoute.of(context)!.settings.arguments as int;
    final Ponto ponto = Provider.of<PontosProvider>(context, listen: false).obterPontoPorId(pontoId);

    final nome = ponto.nome;
    final data = ponto.dataHora;
    final datyMd = DateFormat.yMd().format(data);
    final datHm = DateFormat.Hm().format(data);

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Ponto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                Image.file(
                  File(ponto.imagePath),
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 10),
              Text(
                'Nome: $nome',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Tipo: ${ponto.isSaida ? 'Saída' : 'Entrada'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Data: $datyMd',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Hora: $datHm',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<PontosProvider>(context, listen: false).deletarPonto(ponto.id);
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 8),
                    Text('Deletar Ponto'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
