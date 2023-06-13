import 'package:flutter/material.dart';
import 'package:mongodb_project_flutter/mongoDb.dart';
import 'package:mongodb_project_flutter/mongoDbModel.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Page"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getdata(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    print("Total Data = " + totalData.toString());
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return displayCard(
                              MongoDbModel.fromJson(snapshot.data[index]));
                        });
                  } else {
                    return Center(child: Text("No data Found"));
                  }
                }
              })),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("${data.id}"),
            SizedBox(height: 5,),
          Text("${data.firstName}"),
          SizedBox(height: 5,),
          Text("${data.lastName}"),
          SizedBox(height: 5,),
          Text("${data.address}"),
        ],
        ),
      ),
    );
  }
}
