
class GetApiModel {
  List<Users>? users;

  GetApiModel({this.users});

  GetApiModel.fromJson(Map<String, dynamic> json) {
    if(json["users"] is List) {
      users = json["users"] == null ? null : (json["users"] as List).map((e) => Users.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(users != null) {
      _data["users"] = users?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Users {
  String? id;
  String? avatar;
  String? name;
  String? title;
  String? role;
  int? balance;

  Users({this.id, this.avatar, this.name, this.title, this.role, this.balance});

  Users.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["avatar"] is String) {
      avatar = json["avatar"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["role"] is String) {
      role = json["role"];
    }
    if(json["balance"] is int) {
      balance = json["balance"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["avatar"] = avatar;
    _data["name"] = name;
    _data["title"] = title;
    _data["role"] = role;
    _data["balance"] = balance;
    return _data;
  }
}