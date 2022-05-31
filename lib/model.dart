class Books{
  String? id;
  String? book;
  String? author;
  Books({this.id, this.book, this.author});

  Books.fromJson(dynamic json) {
    id = json['_id']['\$oid'].toString();
    book = json['name'].toString();
    author = json['author'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.book.toString();
    data['author'] = this.author.toString();

    return data;
  }
}