import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController data1 = new TextEditingController();
  TextEditingController data2 = new TextEditingController();
  TextEditingController data3 = new TextEditingController();
  TextEditingController data4 = new TextEditingController();
  TextEditingController data5 = new TextEditingController();
  TextEditingController data6 = new TextEditingController();
  TextEditingController data7 = new TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App Bar'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    TextFormField(
                      controller: data1,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Property type',
                          hintText: 'Enter property type as flat, house'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: data2,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Bedrooms',
                          hintText: 'Enter the bedrooms as studio, one or two'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text("Date and time"),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: data4,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Month rent price',
                          hintText: 'Enter price'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: data5,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Furniture types',
                          hintText:
                              'Such as furnished, unfurnished or par furnished'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: data6,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Notes',
                          hintText: '...'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: data7,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE8E8E8), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Name of the reporter',
                          hintText: '...'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "Property type": data1.text,
                          "Bedrooms": data2.text,
                          // "field1": data3.text,
                          "Monthly rent price": data4.text,
                          "Furniture types": data5.text,
                          "Notes": data6.text,
                          "Name of the reporter": data7.text,
                        };
                        if (formkey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection("test")
                              .add(data);
                          print('share');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        } else {
                          print("Not Validated");
                        }
                      },
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
