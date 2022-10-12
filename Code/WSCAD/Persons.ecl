/*
	Raw Dataset: Persons_CSV    // see BWR_Tests - used to generate the CSV file
*/
Layout_Raw := RECORD
  STRING  ID;
  STRING  FirstName;
  STRING  LastName;
  STRING  MiddleName;
  STRING  NameSuffix;
  STRING  FileDate;
  STRING  BureauCode;
  STRING  MaritalStatus;
  STRING  Gender;
  STRING  DependentCount;
  STRING  BirthDate;
  STRING  StreetAddress;
  STRING  City;
  STRING  State;
  STRING  ZipCode;
END;
//
EXPORT Persons := DATASET('~CLASS::MDM::DEMO::Persons_CSV',Layout_Raw,CSV);
//