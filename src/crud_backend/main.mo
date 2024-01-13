import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";

actor {
  
  type PatientData ={
    patientId: Nat;
    firstName: Text;
    middleName: Text;
    lastName: Text;
    age: Nat;
    identificationNo: Nat;
    birthCertNo: Nat;
    passportNo: Nat;
    gender: Text;
    bloodGroup: Text; 
    medicalreport: Text;
  };

  var patient = HashMap.HashMap<Nat, PatientData>(1, Nat.equal, Hash.hash);
  stable var patientIdCount: Nat = 0;

  // Post function
  public func uploadPatientData(patientData: PatientData): async () {
    // 1. Prepare Data
    let id: Nat = patientIdCount;
    patientIdCount += 1;

    // 2. Upload Patient Data
    patient.put(id, patientData);

    // 3. Return confirmation
    ();
  };

  // Read function
  public query func readPatientData(id: Nat): async ?PatientData {
    let patientData: ?PatientData = patient.get(id);

    // Return requested patient data or null
    patientData;
  };

  // Update user data
  public func updatePatientData(patientData: PatientData, id: Nat): async Text {
    // 1. Query
    let currentPatientData: ?PatientData = patient.get(id);

    // 2. Validate if exists
    switch (currentPatientData) {
      case (null) {
        // 3. Return error message
        "Such patient does not exist";
      };
      case (?currentData) {
        // 4. Update new Patient Data
        let updatedPatientData: PatientData = {
          patientId = currentData.patientId;
          firstName = patientData.firstName; 
          middleName = patientData.middleName;
          lastName = patientData.lastName;
          age = patientData.age;
          identificationNo = patientData.identificationNo;
          birthCertNo = patientData.birthCertNo;
          passportNo = patientData.passportNo;
          gender = patientData.gender;
          bloodGroup = patientData.bloodGroup;
          medicalreport = patientData.medicalreport;
        };

        // 5. Update patient data
        patient.put(id, updatedPatientData);

        // 6. Return success message
        "Updated successfully";
      };
    };
  };
}
