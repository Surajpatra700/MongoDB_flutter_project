import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_project_flutter/constant.dart';
import 'package:mongodb_project_flutter/mongoDbModel.dart';

class MongoDatabase {
  static var db, collection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    print(await collection.find().toList());
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await collection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getdata() async {
    final arrdata = await collection.find().toList();
    return arrdata;
  }

  static Future<void> update(MongoDbModel data) async {
    var result = await collection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastname'] = data.lastName;
    result['address'] = data.address;
    var response = await collection.save(result);
    //inspect(response);
  }

  static delete(MongoDbModel user) async {
    await collection.remove(where.id(user.id));
  }
}
