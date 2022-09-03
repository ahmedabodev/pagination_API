class modeldata{
  dynamic body;
  dynamic title;
  dynamic id;

  modeldata({
    required this.body,
    required this.title,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': this.body,
      'title': this.title,
      'id': this.id,
    };
  }

  factory modeldata.fromMap(Map<String, dynamic> map) {
    return modeldata(
      body: map['body'] as dynamic,
      title: map['title'] as dynamic,
      id: map['id'] as dynamic,
    );
  }
}