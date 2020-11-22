class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String qualification;
  final String university;

  UserModel(
      this.id, this.fullName, this.email, this.qualification, this.university);

  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        qualification = data['qualification'],
        university = data['university'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'qualification': qualification,
      'university': university
    };
  }
}
