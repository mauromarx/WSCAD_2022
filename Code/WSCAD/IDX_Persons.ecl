//
IMPORT $;
//
STD_Persons := $.STD_Persons.File;
//
EXPORT IDX_Persons := MODULE
//
	EXPORT Layout := RECORD
    RECORDOF(STD_Persons) AND NOT [RecID,ID,MiddleName,NameSuffix,FileDate,BureauCode];
  END;
//
  SHARED Filename := '~CLASS::MDM::OUT::Persons_Demo';
  EXPORT File 	  := DATASET(Filename,Layout,FLAT);
	EXPORT IDX_LName_FName_St := INDEX(File,{LastName,FirstName,State},{File},
                                     '~CLASS::MDM::KEY::LName_FName_St');
//
END;
//