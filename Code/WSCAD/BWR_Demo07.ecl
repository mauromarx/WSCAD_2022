//
// *****  Estruturas de dados basicas em ECL
//
IMPORT $;
//
Persons := $.modPersons.File;
//
//
// *****  SHOW 10
// *****  Transformacoes basicas em ECL
// *****  Eliminacao de campos desnecessarios
ptable := TABLE(Persons,{ID,Firstname,LastName,Gender,DependentCount,BirthDate,StreetAddress,City,State,ZipCode});
ptable;                                                            //	SUBMIT 05a
// OUTPUT(ptable,,'~CLASS::MDM::DEMO::PersonsTBL',OVERWRITE);         //	SUBMIT 05b
//
//
//
// *****  SHOW 11
// *****  Filtragem e Tabulaçao de datasets
// *****  Tabulação cruzada - "CrossTab Report" form
rec3 := RECORD
  Persons.Gender;
  cnt3 := COUNT(GROUP);
END;
//
// crosstab03 := TABLE(Persons,rec3,Gender);
// crosstab03;                                                     //	SUBMIT 06


rec4 := RECORD
  Persons.DependentCount;
  cnt4 := COUNT(GROUP);
END;
//
// crosstab04 := TABLE(Persons,rec4,DependentCount);
// crosstab04;                                                     //	SUBMIT 07


// *****  Funçoes de Agregação: MIN & MAX
MinVal := MIN(Persons,DependentCount);
MaxVal := MAX(Persons,DependentCount);
//
DCds := DATASET([{'n. Minimum',MinVal},
                 {'n. Maximum',MaxVal}],
                 {STRING15 ValueType,INTEGER AllVal});
// DCds;                                                           //	SUBMIT 08
//
//
//
// *****  SHOW 12
// *****  Filtragem com definição do tipo "boolean"
IsFloridian := Persons.State = 'FL';
IsBorn2000  := Persons.BirthDate <> '' AND Persons.BirthDate[..4] >= '2000';
//
IsFloridianYoung := Persons(IsFloridian AND IsBorn2000);
//
//
// *****  Tabulação cruzada
FYrec := RECORD
  IsFloridianYoung.Gender;
  UNSIGNED4 FYcnt := COUNT(GROUP);
END;
//
// crosstab05 := TABLE(IsFloridianYoung,FYrec,Gender);
// crosstab05;                                                      //	SUBMIT 09
//