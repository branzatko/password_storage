import 'package:flutter/material.dart';
import 'package:password_storage/db/WP_database.dart';
import 'package:flutter/services.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  String passsword = "Heslo";
  bool _passwordVisible = false;
  Map id = {};

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    id = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: Text('Detail položky'),
          centerTitle: true,
        ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 5, 10),
        child: FutureBuilder(
        future: WebPageDB().getPage(id['id']),
    builder: (context, AsyncSnapshot projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return Column(
        children: [
          Card(
            child: SizedBox(
              height: 85,
              child: Center(
                child: ListTile(
                  title: Text(
                      projectSnap.data[0]['url'],
                    style: TextStyle(
                    letterSpacing: 2,
                  ),
                  ),
                  leading: Icon(
                      Icons.web,
                    size: 30,
                  ),
                  trailing: IconButton(onPressed: () {
                    Clipboard.setData(ClipboardData(text: projectSnap.data[0]['url']));
                  },
                      icon: Icon(
                          Icons.copy,
                        size: 30,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            child: SizedBox(
              height: 85,
              child: Center(
                child: ListTile(
                  title: Text(
                      projectSnap.data[0]['username'],
                    style: TextStyle(
                      letterSpacing: 2,
                    ),
                  ),
                  leading: Icon(
                      Icons.people,
                    size: 30,
                  ),
                  trailing: IconButton(onPressed: () {
                    Clipboard.setData(ClipboardData(text: projectSnap.data[0]['username']));
                  },
                      icon: Icon(
                        Icons.copy,
                        size: 30,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            child: SizedBox(
              height: 85,
              child: Center(
                child: ListTile(
                  title: TextField(
                    controller: TextEditingController(text: projectSnap.data[0]['password']),
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons
                                .visibility_off,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                    ),
                  ),
                  leading: Icon(
                      Icons.password,
                    size: 30,
                  ),

                  trailing:
                  IconButton(onPressed: () {
                    Clipboard.setData(ClipboardData(text: projectSnap.data[0]['password']));
                  },
                      icon: Icon(
                          Icons.copy,
                        size: 30,
                      )),
                ),
              ),
            ),
          ),

        ],
      );
    }),
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: ()  => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Smazat záznam'),
                content: const Text('Opravdu chcete smazat tento záznam?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                        Navigator.pop(context);
                      },
                    child: const Text('Ne'),
                  ),
                  TextButton(
                    onPressed: () {

                      WebPageDB().deletePage(id['id']);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Ano'),
                  ),
                ],
              ),
            ),
            /*WebPageDB().deletePage(id['id']);
            Navigator.pop(context);*/
          child: Icon(Icons.delete),
        )
    );
  }
}
