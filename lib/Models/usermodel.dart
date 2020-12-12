class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String dob;
  final String qualification;
  final String university;
  final int points;

  UserModel(this.id, this.fullName, this.email, this.dob, this.qualification,
      this.university, this.points);

  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        dob = data['dob'],
        qualification = data['qualification'],
        university = data['university'],
        points = data['points'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'dob': dob,
      'qualification': qualification,
      'university': university,
      'points': points
    };
  }
}
