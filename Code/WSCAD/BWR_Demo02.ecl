//
// *****  Estruturas de dados basicas em ECL
//
// *****  SHOW 01
// *****  Estrutura RECORD
rec := RECORD
    STRING10  	Firstname;
	STRING     	Lastname;
	STRING1   	Gender;
	UNSIGNED1	Age;
    STRING      Nationality;
    STRING      Occupation;
    STRING      Account;
	INTEGER  	Balance;
	DECIMAL7_2 	Income;
END;
//
// Declaracao DATASET
ds := DATASET([{'Isaac','Newton','M',84,'english','scientist','cc100',100,3500.00},
               {'Albert','Einstein','M',76,'german','scientist','cc200',-100,4000.30},
               {'Marie','Curie','F',66,'polish','scientist','cc300',200,3640.10},
            // {'John','Doe','U',65,'american','retired','cc900',750,3211.11},   //  "ON" Added to be removed by Dedup Full
               {'Victor','Hugo','M',83,'french','writer','cc400',150,1900.00},
               {'Jane','Austen','F',41,'english','writer','cc500',180,2000.00},
               {'Emily','Bronte','F',30,'english','writer','cc600',120,1800.00},
               {'Jane','Doe','',25,'brazilian','unemployed','cc700',-500,0.00},
               {'John','Doe','U',65,'american','retired','cc800',750,3211.11}],rec);
// OUTPUT(ds);                                                //	SUBMIT 00
ds;			                                                      //	SUBMIT 01
//
//
//
// *****  SHOW 04
// *****  Transformacoes basicas em ECL
// *****  Eliminacao de campos desnecessarios - "Vertical Slice" form
mytable := TABLE(ds,{Firstname,Lastname,Account,Balance,Income});
// mytable;                                                          //	SUBMIT 02

// *****  Ordenacao de valores: Lastname (-Lastname = decrescente)
// sort01 := SORT(mytable,Lastname);
// sort01;                                                        //	SUBMIT 03a
//
// *****  Remocao de duplicidades: Lastname   // compara os registros adjacentes (ALL - compara com todos os registros)
// dedup01 := DEDUP(sort01,Lastname);
// dedup01;                                                       //	SUBMIT 03b


// *****  Ordenacao de valores: FirstName
// sort02 := SORT(mytable,FirstName);
// sort02;                                                        //	SUBMIT 04a
//
// *****  Remocao de duplicidades: FirstName
// dedup02 := DEDUP(sort02,FirstName);
// dedup02;                                                       //	SUBMIT 04b


// *****  Ordenacao de valores: Full = FirstName & LastName
// "ON"           {'John','Doe','U',65,'american','retired',750,3211.11},          //Added to be removed by Dedup Full
// sort03 := SORT(mytable,FirstName,LastName);
// sort03;                                                        //	SUBMIT 05a
//
// *****  Remocao de duplicidades: Full = FirstName & LastName
// dedup03 := DEDUP(sort03,FirstName,LastName);
// dedup03;                                                       //	SUBMIT 05b
//
// *****  Remocao de duplicidades com "Palavras Chaves": LEFT & RIGHT (LEFT.Lastname = RIGHT.Firstname)
// dedup03 := DEDUP(sort03,
                      // LEFT.FirstName = RIGHT.FirstName AND
                      // LEFT.LastName = RIGHT.LastName)
                 // :PERSIST('~CLASS::MDM::PERSIST::DedupPersons');  //	SUBMIT 05c
// dedup03;                                                       //	SUBMIT 05d
//
//
//
// *****  SHOW 05
// *****  Função ROLLUP & TRANSFORM
// *****  Ordenacao de valores do dataset: Full = FirstName & LastName
// sort04 := SORT(ds,FirstName,LastName);
// sort04;                                                           //	SUBMIT 06a
//
rec RollTransf(rec Le, rec Ri) := TRANSFORM
	SELF.Account  := Le.Account + ',' + Ri.Account;
	SELF.Balance  := Le.Balance + Ri.Balance;
	SELF          := Le;
END;
//
// rollup01 := ROLLUP(sort04,
                   // LEFT.FirstName = RIGHT.FirstName AND
                   // LEFT.LastName  = RIGHT.LastName,
                   // RollTransf(LEFT,RIGHT));
// rollup01;                                                     //	SUBMIT 06b
//
//
//
// *****  SHOW 06
// "OFF"            {'John','Doe','U',65,'american','retired',750,3211.11},          //Added to be removed by Dedup Full
// *****  Adicao de campo no dataset
TRrec := RECORD
    UNSIGNED    RecID;  
    STRING10  	Firstname;
	STRING     	Lastname;
	STRING1   	Gender;
	UNSIGNED1	Age;
    STRING      Nationality;
    STRING      Occupation;
    STRING      Account;        // filtrar
	INTEGER  	Balance;        // filtrar
	DECIMAL7_2 	Income;         // filtrar
END;
//
//
IMPORT STD;
//
TRrec MyTransf(rec Le, UNSIGNED cnt) := TRANSFORM
    SELF.RecID 		  := cnt;
    SELF.Firstname 	  := STD.Str.ToUpperCase(Le.Firstname);
	SELF.Lastname 	  := STD.Str.ToUpperCase(Le.LastName);
    SELF 			  := Le;
END;
//
// *****  Project & Transform do dataset
// TRds := PROJECT(ds,MyTransf(LEFT,COUNTER));
// TRds;                                                      //	SUBMIT 07
//
///
//
// *****  SHOW 07
// *****  Uniao de 02 datasets
EPrec := RECORD
    STRING10    Firstname;
	STRING      Lastname;
	STRING  	Email;
    STRING      Phone;
END;
//
// Declaracao do novo DATASET
EPds := DATASET([{'ISAAC','NEWTON','isaac.newton@cam.ac.uk','16431727'},
                 {'ALBERT','EINSTEIN','albert.einstein@princeton.edu','18791955'},
                 {'MARIE','CURIE','marie.curie@sorbonne.fr','18671934'},
                 {'VICTOR','HUGO','victor.hugo@lacroix.fr','18021885'},
                 {'JANE','AUSTEN','jane.austen@hampshire.uk','17751817'},
                 {'EMILY','BRONTE','emily.bronte@thornton.uk','18181848'},
                 {'JANE','DOE','jane.doe@hotmail.com',''},
                 {'JOHN','WAYNE','john.wayne@paramount.com','12345678'}],EPrec);    // Joe Doe ???
// EPds;			                                             //	SUBMIT 08
//
//
//
// *****  SHOW 08
// *****  Fazendo JOIN de datasets
NEWrec := RECORD
  TRrec;
  EPrec.Email;
  EPrec.Phone;
END;
//
NEWrec MyTransf2(TRrec Le, EPrec Ri) := TRANSFORM
  SELF := Le;
  SELF := Ri;
END;
//
// JOINds := JOIN(TRds,EPds,LEFT.Firstname = RIGHT.Firstname AND LEFT.Lastname = RIGHT.Lastname,MyTransf2(LEFT,RIGHT));
// JOINds;			                                             //	SUBMIT 09
//
// *****  Ordenacao de valores do dataset: RecID
// sort05 := SORT(JOINds,RecID);
// sort05;                                                       //	SUBMIT 10
//
//
// JOINdsFull := JOIN(TRds,EPds,LEFT.Firstname = RIGHT.Firstname AND LEFT.Lastname = RIGHT.Lastname,MyTransf2(LEFT,RIGHT),
                   // FULL OUTER);
// JOINdsFull;			                                         //	SUBMIT 11
//
// *****  Ordenacao de valores do dataset: RecID
// sort06 := SORT(JOINdsFull,RecID);
// sort06;                                                       //	SUBMIT 12
//
//