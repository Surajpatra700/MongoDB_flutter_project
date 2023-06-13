import 'package:flutter/material.dart';
import 'package:mongodb_project_flutter/mongoDb.dart';
import 'package:mongodb_project_flutter/mongoDbModel.dart';
import 'package:mongodb_project_flutter/mongodbInsert.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FutureBuilder(
            future: MongoDatabase.getdata(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, index) {
                        return _displayCard(
                            MongoDbModel.fromJson(snapshot.data[index]));
                      }));
                } else {
                  return Text("No data found");
                }
              }
            }),
      )),
    );
  }

  Widget _displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("${data.id}"),
                SizedBox(
                  height: 5,
                ),
                Text("${data.firstName}"),
                SizedBox(
                  height: 5,
                ),
                Text("${data.lastName}"),
                SizedBox(
                  height: 5,
                ),
                Text("${data.address}"),
              ],
            ),
            IconButton(
                onPressed: () async {
                  await MongoDatabase.delete(data);
                  setState(() {
                    
                  });
                },
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
