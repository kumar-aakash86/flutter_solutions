import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CsvDemo extends StatefulWidget {
  @override
  _CsvDemoState createState() => _CsvDemoState();
}

class _CsvDemoState extends State<CsvDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Csv Demo"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Generate"),
          onPressed: getCsv,
        ),
      ),
    );
  }

  List<String> list;

  getCsv() async {
    print('get csv');
    list = new List();
    list.add("A");
    list.add("B");
    list.add("C");
    list.add("D");

    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows = List<List<dynamic>>();
    for (int i = 0; i < list.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(list[i]);
      // row.add(associateList[i].gender);
      // row.add(associateList[i].age);
      rows.add(row);
    }

    // await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    // bool checkPermission = await SimplePermissions.checkPermission(
    //     Permission.WriteExternalStorage);
    // if (checkPermission) {
//store file in documents folder

      String dir =
          (await getExternalStorageDirectory()).absolute.path + "/documents";
      String file = "$dir";
      print(" FILE " + file);
      File f = new File(file + "filename.csv");

// convert rows to String and write as csv file

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    // }
  }
}
