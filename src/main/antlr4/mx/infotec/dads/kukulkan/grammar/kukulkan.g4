grammar kukulkan;

/* =========================================================================
 * ROOT
 * ========================================================================= */
domainModel: feature+;

feature:
	entity | option;


/* =========================================================================
 * ENTITY
 * ========================================================================= */
entity:
	'entity' ID ('(' ID ')')? ('{'
		(entityField (','? entityField)*)?
	'}')?;

entityField:
	name=ID type=fieldType;

fieldType:
	  stringFieldType 
	| numericFieldType 
	| booleanFieldType 
	| dateFieldType 
	| blobFieldType 
	| entityType;

entityType:
	element=entity;

stringFieldType:
	element=stringType validators+=stringValidators*;

stringType:
	element='String';

numericFieldType:
	element=numericTypes validators+=numericValidators*;

numericTypes:
	INTEGER | LONG | BIG_DECIMAL | FLOAT | DOUBLE;

booleanFieldType:
	element=booleanType validators+=requiredValidator*;

booleanType:
	element='Boolean';

dateFieldType:
	dateTypes requiredValidator?;

dateTypes:
	DATE | LOCAL_DATE | ZONED_DATETIME | INSTANT;
	
blobFieldType:
	element=blobTypes validators+=blobValidators*;

blobTypes:
	BLOB | ANY_BLOB	| IMAGE_BLOB | TEXT_BLOB;

/* =========================================================================
 * VALIDATOR
 * ========================================================================= */
stringValidators:
	requiredValidator |
	minlength=minLengthValidator |
	maxlength=maxLengthValidator |
	pattern=patternValidator;

numericValidators:
	requiredValidator | 
	min=minValidator | 
	max=maxValidator;

blobValidators:
	requiredValidator |
	minbytes=minBytesValidator | 
	maxbytes=maxBytesValidator;

requiredValidator: 'required'?;

minLengthValidator:
	'minlength' '(' value=NUMERIC_VALUE ')';

maxLengthValidator:
	'maxlength' '(' value=NUMERIC_VALUE ')';

patternValidator:
	'pattern' '(' value=NUMERIC_VALUE ')';

minValidator:
	'min' '(' value=NUMERIC_VALUE ')';

maxValidator:
	'max' '(' value=NUMERIC_VALUE ')';

minBytesValidator:
	'minbytes' '(' value=NUMERIC_VALUE ')';

maxBytesValidator:
	'maxbytes' '(' value=NUMERIC_VALUE ')';

cardinality:
	ONE_TO_MANY | MANY_TO_ONE | ONE_TO_ONE | MANY_TO_MANY;

/* =========================================================================
 * OPTION 
 * ========================================================================= */
option:
	setting=optionSetting;

optionSetting:
	dtoOption ;
/* =========================================================================
 * DTO OPTION 
 * ========================================================================= */
dtoOption :'dto'? ;

dtoType:
	'mapstruct';


wildcardPredicate : '*'? | 'all'?;

//
// Whitespace and comments
//

WS  :  [ \t\r\n\u000C]+ -> skip
    ;

COMMENT
    :   '/*' .*? '*/' -> channel(HIDDEN)
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> channel(HIDDEN)
    ;
    
NUMERIC_VALUE : [0-9]+ ;
  
ID
    :   [a-zA-Z$_] // these are the "java letters" below 0x7F
    |   // covers all characters above 0x7F which are not a surrogate
        ~[\u0000-\u007F\uD800-\uDBFF]
    |   // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
        [\uD800-\uDBFF] [\uDC00-\uDFFF]
    ;

JavaLetterOrDigit
    :   [a-zA-Z0-9$_] // these are the "java letters or digits" below 0x7F
    |   // covers all characters above 0x7F which are not a surrogate
        ~[\u0000-\u007F\uD800-\uDBFF]
    |   // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
        [\uD800-\uDBFF] [\uDC00-\uDFFF]
    ;
    
INTEGER			: 'Integer';
LONG			: 'Long';
BIG_DECIMAL		: 'BigDecimal';
FLOAT			: 'Float';
DOUBLE			: 'Double';
DATE			: 'Date'; 
LOCAL_DATE		: 'LocalDate'; 
ZONED_DATETIME	: 'ZonedDateTime'; 
INSTANT			: 'Instant';
ONE_TO_MANY		: 'OneToMany';
MANY_TO_ONE		: 'ManyToOne'; 
ONE_TO_ONE		: 'OneToOne'; 
MANY_TO_MANY	: 'ManyToMany';
BLOB			: 'Blob';
ANY_BLOB		: 'AnyBlob';
IMAGE_BLOB		: 'ImageBlob';
TEXT_BLOB		: 'TextBlob';

