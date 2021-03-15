import 'dart:io';
import 'package:flutter/material.dart';
import '../models/data.dart';
import 'package:http/http.dart' as http;

class SendDialog extends StatefulWidget {
  final int steps;
  final BuildContext previousContext;

  SendDialog({this.steps, this.previousContext});

  @override
  _SendDialogState createState() => _SendDialogState();
}

class _SendDialogState extends State<SendDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final Uri _url =
      Uri.parse('https://apiproductorodometrocesar.azurewebsites.net/api/Data');

  Future<String> _sendData() async {
    Data data = Data(
      email: _emailController.text,
      name: _nameController.text,
      dateAndTime: DateTime.now(),
      steps: widget.steps,
    );
    var response = await http.post(
      _url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: dataToJson(data),
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      padding: EdgeInsets.all(20),
      height: 300,
      child: SingleChildScrollView(
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Enviar datos:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  label: Text("Enviar Datos"),
                  icon: Icon(Icons.send_rounded),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    String respuesta = await _sendData();
                    ScaffoldMessenger.of(widget.previousContext).showSnackBar(
                      SnackBar(
                        content: Text(respuesta),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
