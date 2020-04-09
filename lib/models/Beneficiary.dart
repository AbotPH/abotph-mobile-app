class Beneficiary {
  String status;
  String id;
  int accountId;
  String firstName;
  String middleName;
  String lastName;
  String mobileNumber;
  int sizeOfFam;
  int lat;
  int long;
  String address;
  int generatedId;

  Beneficiary(
      this.status, this.id, this.accountId, this.firstName, this.middleName, this.lastName, this.mobileNumber, this.sizeOfFam, this.lat, this.long, this.address, this.generatedId );

  Beneficiary.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    id = json["_id"];
    accountId = int.parse(json["accountId"]);
    firstName = json["firstName"];
    middleName = json["middleName"];
    lastName = json["lastName"];
    mobileNumber = json["mobileNumber"];
    sizeOfFam = json["sizeOfFam"];
    lat = json["lat"];
    long = json["long"];
    address = json["address"];
    generatedId = json["generatedId"];
  }

}

enum statusList {
  STABLE,
  HELP_NEEDED
}