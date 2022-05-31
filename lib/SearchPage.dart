import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'model.dart';

class Searchbook extends StatefulWidget {
  const Searchbook({Key? key}) : super(key: key);

  @override
  State<Searchbook> createState() => _SearchbookState();
}

class _SearchbookState extends State<Searchbook> {

  List<Books> bookList = [];
  late Books books;
  void _callApi({String AuthorName =''}) async {
    late Books books;
    print("searching data ::$AuthorName");
    String api;
      // api = 'http://localhost:8080/Books?filter={\'author\':\'$AuthorName\'}';
api = "http://localhost:8080/Books?filter={\'author\':\'$AuthorName\'}";

    final response =  await http.get(Uri.parse(api));
    print("response code :: ${response.request?.url.toString()}");
    print("response code :: ${response.statusCode}");
    print("response code :: ${response.body.toString()}");

    if(response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      // books = Books.fromJson(responseJson);

      bookList = [];
      setState(() {
        for (Map book in responseJson) {
          print("decoded data :: ${book.toString()}");
          bookList.add(Books.fromJson(book));
        }
      });
    }

    // print(response.request?.url.toString());
    // print(responseJson);


  }
  TextEditingController SearchAuthorName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Container(
          child: Row(
            children: [
              Container(
                child: ElevatedButton(
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BooksExample(),
                        ));
                  },
                ),
              ),
            ],
          ),
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Container(
                margin: EdgeInsets.only(top: 47),
                height: 48,
                width: 1441,
                child: new Card(
                  margin: EdgeInsets.zero,
                  color: Color.fromRGBO(228, 234, 251, 1),
                  //color: Colors.red,
                  child: new ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Container(
                        height: 57,
                        width: 54.0,
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    title: new TextField(
                      controller: SearchAuthorName,
                      decoration: new InputDecoration(
                        hintText: 'Search Book Author Name',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 20),
                      onChanged: (value) {
                        _callApi(AuthorName:value.trim());
                        print(value.runtimeType);
                      },
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        SearchAuthorName.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  bookList.isNotEmpty ? Container(
                    child: Text(
                      ("No result found"),
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),

                  ):Container(
                    child: ListView.builder(
                      itemCount: bookList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(bookList.elementAt(index).book.toString()),
                          subtitle: Text("Author name :: ${bookList.elementAt(index).author.toString()}"),
                        );
                      },
                    ),
                  )
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
