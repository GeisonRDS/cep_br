import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cep/telas/TelaPesquisaPorCep.dart';
import 'package:cep/telas/TelaPesquisaPoEndereco.dart';
import 'package:cep/telas/TelaSobre.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  void _abrirSobreNos(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> TelaSobre())
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      TelaPesquisaPorCep(),
      TelaPesquisaPoEndereco(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Text(
          "CEPbr",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blue
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),

            onPressed: (){
              _abrirSobreNos();
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: Container(
        child: telas[_indiceAtual],
        color: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.white,
          currentIndex: _indiceAtual,
          onTap: (indice){
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              title: Text("Pesquisa por CEP"),
              icon: Icon(Icons.looks_one)
            ),
            BottomNavigationBarItem(
              title: Text("Pesquisa por endereço"),
              icon: Icon(Icons.font_download),
            ),
          ],
        elevation: 0.0,
      ),
    );;
  }
}
