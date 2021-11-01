class User {
  late String? name;
  late String? mail;
  late String? password;
  late bool? keepOn;

  User({this.name, this.mail, this.password, this.keepOn});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['mail'] = mail;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return "Name: " + name! + "\nEmail: " + mail! + "\nPassword: " + password!;
  }
}
