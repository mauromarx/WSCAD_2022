//
IMPORT $,STD;
//
Persons            := $.Persons;
profilePersons     := STD.DataPatterns.Profile(Persons);
bestrecordPersons  := STD.DataPatterns.BestRecordStructure(Persons);
//
//
OUTPUT(profilePersons,     ALL, NAMED('profilePersons'));
OUTPUT(bestrecordPersons,  ALL, NAMED('bestrecordPersons'));
//