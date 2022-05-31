import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SearchPage.dart';
import 'model.dart';
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
     home: BooksExample()
      //home: Searchbook(),
    )
);


class BooksExample extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BooksExample> {

  Future<Books> postBooks(String book, String author ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/Books'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': book,
        'author': author,
      }),
      //͋͋͋
    );
    if (response.statusCode == 201) {
      return Books.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }


  validator(){
    if(_formKey.currentState!.validate()){
     String BookName = BookController.text;
     String AuthorName = AuthorController.text;
     print(BookName);
     print(AuthorName);
     postBooks(BookName, AuthorName);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController BookController = new TextEditingController();
  TextEditingController AuthorController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return MaterialApp(

        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Books Example'),
          ),
          body: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SizedBox(
                      child: TextFormField(
                        controller: BookController,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0.5),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter Book Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value != null &&
                              value.isEmpty) {
                            return "Book Name can't be empty";
                          }
                          if (value!.length < 2) {
                            return "Maximum length required";
                          }
                        },

                      ),

                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SizedBox(
                      child: TextFormField(
                        controller: AuthorController,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0.5),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter Book Author Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value != null &&
                              value.isEmpty) {
                            return "Enter Book Author name can't be empty";
                          }
                          if (value!.length < 2) {
                            return "Maximum length required";
                          }
                        },

                      ),

                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, top: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            child: ElevatedButton(
                              child: Text("Add Data"),
                              onPressed: (){
                                validator();

                              },
                            ),
                          ),),

                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            child: ElevatedButton(
                                child: Text("Search Author Name"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Searchbook()),
                                  );
                                }
                            ),
                          ),)

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );


  }

}





