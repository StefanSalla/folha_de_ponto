import 'package:ficha_de_ponto/components/ponto_tile.dart';
import 'package:ficha_de_ponto/providers/pontos_provider.dart';
import 'package:ficha_de_ponto/routes.dart';
import 'package:ficha_de_ponto_pk/ficha_de_ponto_pk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final pontosProvider = context.watch<PontosProvider>();
    final List<Ponto> listPonto = pontosProvider.pontos;

    if (listPonto.isEmpty) {
      pontosProvider.list();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Folha de Ponto'),
      actions: [
          IconButton(
            onPressed: ()  {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, Routes.SIGNIN);
              },
              icon: const Icon(Icons.logout),
            ),
            
            ],
          ),
        
        
      body: Consumer<PontosProvider>(
        builder: (context, pontosProvider, child) {
          return ListView.builder(
            itemCount: pontosProvider.pontos.length,
            itemBuilder: (context, index) {
              final ponto = pontosProvider.pontos[index];
              return PontoTile(
                ponto: ponto,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.DETAILS,
                    arguments: ponto.id,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.FORM);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
