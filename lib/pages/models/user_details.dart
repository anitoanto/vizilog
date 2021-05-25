class UserDetails {
  final String uid;
  final String name;
  final String address;
  final String pincode;
  final String email;
  final String imageURL;
  final bool vaccinationStatus;

  UserDetails( 
      {this.name,
      this.address,
      this.pincode,
      this.email,
      this.imageURL,
      this.vaccinationStatus,
      this.uid});
}
