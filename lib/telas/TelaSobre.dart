import 'package:flutter/material.dart';

class TelaSobre extends StatefulWidget {
  @override
  _TelaSobreState createState() => _TelaSobreState();
}

class _TelaSobreState extends State<TelaSobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          "Sobre o App",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "CEPbr foi desenvolvido com o objetivo de fornecer uma "
                  "alternativa simples e fácil de busca e consulta de "
                  "informações de endereços postais com base no CEP ou "
                  "endereço fornecido.\n"
                  "O CEPbr utiliza a API do ViaCep, um webservice gratuito de "
                  "alto desempenho para consultar Códigos de Endereçamento "
                  "Postal (CEP) do Brasil.\n\n"
                  "Site API\n"
                  "viacep.com.br\n\n"
                  "Contato CEPbr\n"
                  "cepbr@makeinapps.com",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                  ),
                ),
              )
            ),
          ),
        )
      )
    );
  }
}
