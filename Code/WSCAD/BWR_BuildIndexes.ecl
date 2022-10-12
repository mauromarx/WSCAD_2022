//
IMPORT $;
//
OUTPUT($.STD_Persons.File,,'~CLASS::MDM::OUT::Persons_Demo',OVERWRITE);
//
BUILD($.IDX_Persons.IDX_LName_FName_St,OVERWRITE);
COUNT($.IDX_Persons.IDX_LName_FName_St);     //  963512
//