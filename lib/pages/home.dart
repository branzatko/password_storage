import 'package:flutter/material.dart';
import 'package:password_storage/db/WP_database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    WebPageDB().getLastId();

    return Scaffold(
        backgroundColor: Colors.blue,
      body: SafeArea(
          child: Container(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: FutureBuilder(
                  builder: (context, AsyncSnapshot projectSnap) {
                    if(projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null){
                      print('project snapshot data is: ${projectSnap.data}');
                                            return Container();
                    }
                    return ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index){
                          return Card(
                            child: ListTile(
                              onTap: () {
                                projectSnap.data[index]['id'];

                                Navigator.pushNamed(context, '/detail', arguments:{
                                  'id': projectSnap.data[index]['id']
                                }).then((_) => setState(() {}));
                              },
                              title: Text(
                                projectSnap.data[index]['url'],

                                style: TextStyle(
                                ),
                              ),
                              subtitle: Text(
                                projectSnap.data[index]['username'],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: (){
                                  projectSnap.data[index]['id'];

                                  Navigator.pushNamed(context, '/detail', arguments:{
                                    'id': projectSnap.data[index]['id']
                                  }).then((_) => setState(() {}));
                                },
                              )
                            ),
                          );
                        }
                    );
                  },
                  future: WebPageDB().getPages(),
              ),
            )
          ),
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        Navigator.pushNamed(context, '/form').then((_) => setState(() {}));
      },
    child: Icon(Icons.add),
    )
    );
  }
}
