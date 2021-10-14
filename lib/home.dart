import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _inputController = TextEditingController();
  String _textoSalvo = "Nada Salvo!";
  _salvar() async{
  String valorDigitado = _inputController.text;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("nome", valorDigitado);
  print('salvou ${valorDigitado}');
  }
  _recuperar() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo =  prefs.getString("nome")??'nenhum valor encontrado';
    });

    print("Texto recuperado ${_textoSalvo}");

  }
  _remover() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
    print("Texto removido");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Utilizando preferencias de usuario"),),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Text(_textoSalvo,
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Insira um texto"
                ),
                controller:_inputController
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: _salvar, child:const Text('Salvar',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                ),
                TextButton(onPressed: _recuperar, child:const Text('Recuperar',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                ),
                TextButton(onPressed: _remover, child:const Text('Remover',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
