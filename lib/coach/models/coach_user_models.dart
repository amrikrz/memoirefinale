class CoachUserModel {
  final bool? approved;
  final String? buisnessName;
  final String? email;
  final String? phoneNumber;
  
  final String? countryValue;
  final String? stateValue;
  final String? cityValue;
  final String? storeImage;
  
  final String? coachId;

  const CoachUserModel({
    this.approved,
    this.buisnessName,
    this.email,
    this.phoneNumber,
    
    this.countryValue,
    this.stateValue,
    this.cityValue,
    this.storeImage,
    
    this.coachId,
  });

  factory CoachUserModel.fromJson(Map<String, dynamic> json) {
    return CoachUserModel(
      approved: json['accverified'] as bool?,
      buisnessName: json['buisnessName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      
      countryValue: json['countryValue'] as String?,
      stateValue: json['stateValue'] as String?,
      cityValue: json['cityValue'] as String?,
      storeImage: json['storeImage'] as String?,
    
      coachId: json['coachId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accverified': approved,
      'coachId': coachId,
      'buisnessName': buisnessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'email': email,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      
  
      'storeImage': storeImage,
    };
  }
}
