import 'package:flutter/material.dart';
import 'package:mongodb_project_flutter/mongoDb.dart';
import 'package:mongodb_project_flutter/mongoDbModel.dart';
import 'package:mongodb_project_flutter/mongodbInsert.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
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
                        return displayCard(
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

  Widget displayCard(MongoDbModel data) {
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MongodbInsert(),settings: RouteSettings(arguments: data)));
                },
                icon: Icon(Icons.edit)),
          ],
        ),
      ),
    );
  }
}
