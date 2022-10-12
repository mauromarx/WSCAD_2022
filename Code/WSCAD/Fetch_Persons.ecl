//
IMPORT $;
//
EXPORT Fetch_Persons (STRING25 LName_Val, STRING15 FName_Val, STRING2 St_Val) := FUNCTION
//
	basekey := $.IDX_Persons.IDX_LName_FName_St;
//	
	FilteredKey := IF(St_Val = '',
                    basekey(LastName=LName_Val),
                    IF(FName_Val = '',
                       basekey(LastName=LName_Val AND State=St_Val AND NOT FirstName=FName_Val),
                       basekey(LastName=LName_Val AND State=St_Val AND FirstName=FName_Val))
                    );
//
	RETURN OUTPUT(FilteredKey);
END;
//