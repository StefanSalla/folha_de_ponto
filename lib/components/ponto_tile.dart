import 'package:ficha_de_ponto_pk/ficha_de_ponto_pk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PontoTile extends StatelessWidget {
  final Ponto ponto;
  final VoidCallback onTap;

  PontoTile({required this.ponto, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final nome = ponto.nome;
    final data = ponto.dataHora;
    final datyMd = DateFormat.yMd().format(data);
    final datHm = DateFormat.Hm().format(data);

    return ListTile(
      leading: Icon(
        Icons.circle,
        color: ponto.isSaida ? Colors.red : Colors.green,
      ),
      title: Text('$nome'),
      subtitle: Text(
        '${ponto.isSaida ? 'Saída' : 'Entrada'}',
      ),
      trailing: Column(
        children: [
          const Text('Data: '),
          Text('$datyMd'),
          Text('$datHm'),
        ],
      ),
      onTap: onTap,
    );
  }
}
