class userInfoModel {
  String? nameSurname;
  String? citizenNumber;
  String? city;
  String? phoneNumber;
  String? numOfMember;

  userInfoModel(
      {this.nameSurname,
      this.citizenNumber,
      this.city,
      this.phoneNumber,
      this.numOfMember});

  userInfoModel.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    citizenNumber = json['citizenNumber'];
    city = json['city'];
    phoneNumber = json['phoneNumber'];
    numOfMember = json['numOfMember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameSurname'] = this.nameSurname;
    data['citizenNumber'] = this.citizenNumber;
    data['city'] = this.city;
    data['phoneNumber'] = this.phoneNumber;
    data['numOfMember'] = this.numOfMember;
    return data;
  }
}