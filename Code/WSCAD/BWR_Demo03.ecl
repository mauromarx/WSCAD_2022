//
// *****  Estruturas de dados basicas em ECL
//
IMPORT $;
//
Persons := $.modPersons.File;
//
//
// *****  SHOW 08
// *****  Conteudo do dataset: Persons
OUTPUT(Persons, NAMED('Persons'));                              //	SUBMIT 01a
COUNT(Persons);    // 963.512 registros                         //	SUBMIT 01b
//
OUTPUT(Persons,{ID,FirstName,LastName,Gender,DependentCount,BirthDate}, NAMED('Personal_Info'));     //	SUBMIT 02a
OUTPUT(Persons,{ID,StreetAddress,City,State,ZipCode}, NAMED('Address_Info'));                        //	SUBMIT 02b
//
//
//
// *****  SHOW 09
// *****  Basic Queries
OUTPUT(Persons(State='FL',City='MIAMI'), NAMED('FL_Miami'));        //	SUBMIT 03a
COUNT(Persons(State='FL',City='MIAMI'));                            //	SUBMIT 03b  = 2821
//
OUTPUT(Persons(ZipCode='33102'), NAMED('ZipCode_33102'));           //	SUBMIT 04a
COUNT(Persons(ZipCode='33102'));                                    //	SUBMIT 04b  = 53
//
OUTPUT(Persons(FirstName[1]='B'), NAMED('FirstName_B'));            //	SUBMIT 04a
COUNT(Persons(FirstName[1]='B'));                                   //	SUBMIT 04b  = 35619
//
//