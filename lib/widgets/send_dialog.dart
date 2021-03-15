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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Uri _url =
      Uri.parse('https://apiproductorodometrocesar.azurewebsites.net/api/Data');

  Future<String> _sendData() async {
    Data data = Data(
      email: emailController.text,
      name: nameController.text,
      dateAndTime: DateTime.now(),
      steps: widget.steps,
    );
    final response = await http.post(
      _url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: dataToJson(data),
    );
    print(dataToJson(data));
    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SingleChildScrollView(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Enviar datos:"),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                ),
              ),
              TextField(
                controller: emailController,
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
    );
  }
}
