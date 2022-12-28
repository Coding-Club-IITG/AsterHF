
class EmergencyContact {
  String contactName;
  String contactSpeciality;
  String contactNumber;
  
  EmergencyContact({required this.contactName, required this.contactSpeciality, required this.contactNumber});
}

EmergencyContact contactOne = EmergencyContact(contactName: "Dr. Raghunath Mahajan", contactSpeciality: "Cardiologist", contactNumber: "123456789");
EmergencyContact contactTwo = EmergencyContact(contactName: "Emergency Ambulance", contactSpeciality: "Ambulance + First Aid", contactNumber: "123456789");
List <EmergencyContact> emergencyContacts= [contactOne, contactTwo];