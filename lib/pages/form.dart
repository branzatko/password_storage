import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:password_storage/db/WP_database.dart';
import 'package:password_storage/db/WebPage.dart';

class FormPass extends StatefulWidget {
  const FormPass({Key? key}) : super(key: key);

  @override
  State<FormPass> createState() => _FormPassState();
}

class _FormPassState extends State<FormPass> {



  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();



  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Přidat záznam"),
        backgroundColor: Colors.blue.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(1,5,1,0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.web),
                  title: TextFormField(
                    controller: myController1,
                    validator: (value) {
                      if(value == null || value.isEmpty)
                        {
                          return "Pole nesmí být prázdné";
                        }
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: TextFormField(
                    controller: myController2,
                    validator: (value) {
                      if(value == null || value.isEmpty)
                      {
                        return "Pole nesmí být prázdné";
                      }
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.password),
                  title: TextFormField(
                    controller: myController3,
                    validator: (value) {
                      if(value == null || value.isEmpty)
                      {
                        return "Pole nesmí být prázdné";
                      }
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState((){
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: () async{
                if(_formKey.currentState!.validate()){




                  WebPage page = new WebPage(null, myController1.text, myController2.text, myController3.text);



                  await WebPageDB().insertPage(page);


                  final List<Map<String, dynamic>> idpokus = await WebPageDB().getLastId();



                  print('Číslo je ${idpokus[0]['id']}');

                  String idpokus2 = idpokus.toString();





                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ukládám data')),
                  );
                  Navigator.pop(context);
                }
              }, child: Text('Přidat'))
            ],
          ),
        ),
      ),
    );
  }
}
