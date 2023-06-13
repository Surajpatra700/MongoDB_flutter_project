import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_project_flutter/mongoDb.dart';
import 'package:mongodb_project_flutter/mongoDbDelete.dart';
import 'package:mongodb_project_flutter/mongoDbDisplay.dart';
import 'package:mongodb_project_flutter/mongoDbModel.dart';
import 'package:mongodb_project_flutter/mongoDbUpdate.dart';

class MongodbInsert extends StatefulWidget {
  const MongodbInsert({super.key});

  @override
  State<MongodbInsert> createState() => _MongodbInsertState();
}

class _MongodbInsertState extends State<MongodbInsert> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final addressController = TextEditingController();

  var checkInsertUpdate = "Insert Data";
  @override
  Widget build(BuildContext context) {
    // data stores all the data send from previous page as argumements
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if (data != null) {
      fnameController.text = data.firstName;
      lnameController.text = data.lastName;
      addressController.text = data.address;
      checkInsertUpdate = "Update Data";
      // setState(() {
        
      // });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(checkInsertUpdate),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MongoDbDisplay()));
          }, icon: Icon(Icons.smart_display)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MongoDbUpdate()));
          }, icon: Icon(Icons.update)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MongoDbDelete()));
          }, icon: Icon(Icons.delete)),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: fnameController,
            decoration: InputDecoration(
              hintText: "First Name",
            ),
          ),
          TextFormField(
            controller: lnameController,
            decoration: InputDecoration(
              hintText: "Last Name",
            ),
          ),
          TextFormField(
            controller: addressController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Address",
            ),
          ),
          SizedBox(
            height: 45,
          ),
          ElevatedButton(
              onPressed: () {
                if (checkInsertUpdate == "Update Data") {
                  _updatedata(
                      data.id, data.firstName, data.lastName, data.address);
                } else {
                  _insertdata(fnameController.text, lnameController.text,
                      addressController.text);
                }
              },
              child: Text(checkInsertUpdate)),
        ],
      )),
    );
  }

  _updatedata(var id, String fname, String lname, String address) async {
    final updateData = MongoDbModel(
        id: id, firstName: fname, lastName: lname, address: address);
    var result = await MongoDatabase.update(updateData).whenComplete(()=> Navigator.pop(context));
  }

  _insertdata(String fname, String lname, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id, firstName: fname, lastName: lname, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted Id " + _id.$oid)));
    _clearAll();
  }

  _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }
}
