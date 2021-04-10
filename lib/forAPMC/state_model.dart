class StateModel {
  String state;
  String alias;
  List<String> districts;

  StateModel({this.state, this.alias, this.districts});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    // districts = json['districts'].cast<String>();
    districts = json['districts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['districts'] = this.districts;
    return data;
  }
}
