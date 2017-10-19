grammar kukulkan;

// Domain Model Rule

domainModel
:
	entities += entity+
	| settings += option
;

/* =========================================================================
 * Entity Rule
 * ========================================================================= */
entity
:
	'entity' name = ID
	(
		'(' tableName = ID ')'
	)?
	(
		'{'
		(
			fields += entityField
			(
				','? fields += entityField
			)*
		)? '}'
	)?
;

entityField
:
	id = ID type = fieldType
;

fieldType
:
	stringFieldType
	| numericFieldType
	| booleanFieldType
	| dateFieldType
	| blobFieldType
	| entityType
;

entityType
:
	entity
;

stringFieldType
:
	name = stringType constraints += stringValidators*
;

stringType
:
	'String'
;

numericFieldType
:
	name = numericTypes constraints += numericValidators*
;

numericTypes
:
	INTEGER
	| LONG
	| BIG_DECIMAL
	| FLOAT
	| DOUBLE
;

INTEGER
:
	'Integer'
;

LONG
:
	'Long'
;

BIG_DECIMAL
:
	'BigDecimal'
;

FLOAT
:
	'Float'
;

DOUBLE
:
	'Double'
;

booleanFieldType
:
	BOOLEAN_TYPE required=requiredValidator*
;

BOOLEAN_TYPE
:
	'Boolean'
;

dateFieldType
:
	type=dateTypes required=requiredValidator?
;

dateTypes
:
	DATE
	| LOCAL_DATE
	| ZONED_DATETIME
	| INSTANT
;

DATE
:
	'Date'
;

LOCAL_DATE
:
	'LocalDate'
;

ZONED_DATETIME
:
	'ZonedDateTime'
;

INSTANT
:
	'Instant'
;

blobFieldType
:
	name=blobTypes constraints+=blobValidators*
;

blobTypes
:
	BLOB
	| ANY_BLOB
	| IMAGE_BLOB
	| TEXT_BLOB
;

BLOB
:
	'Blob'
;

ANY_BLOB
:
	'AnyBlob'
;

IMAGE_BLOB
:
	'ImageBlob'
;

TEXT_BLOB
:
	'TextBlob'
;

/* =========================================================================
 * VALIDATOR
 * ========================================================================= */
stringValidators
:
	required=requiredValidator
	| minLenght=minLengthValidator
	| maxLenght=maxLengthValidator
	| pattern=patternValidator
;

numericValidators
:
	required=requiredValidator
	| minValue=minValidator
	| maxValue=maxValidator
;

blobValidators
:
	required=requiredValidator
	| minBytesValue=minBytesValidator
	| maxBytesValue=maxBytesValidator
;

requiredValidator
:
	'required'
;

minLengthValidator
:
	'minlength' '(' NUMERIC_VALUE ')'
;

maxLengthValidator
:
	'maxlength' '(' NUMERIC_VALUE ')'
;

patternValidator
:
	'pattern' '(' NUMERIC_VALUE ')'
;

minValidator
:
	'min' '(' NUMERIC_VALUE ')'
;

maxValidator
:
	'max' '(' NUMERIC_VALUE ')'
;

minBytesValidator
:
	'minbytes' '(' NUMERIC_VALUE ')'
;

maxBytesValidator
:
	'maxbytes' '(' value = NUMERIC_VALUE ')'
;

cardinality
:
	ONE_TO_MANY
	| MANY_TO_ONE
	| ONE_TO_ONE
	| MANY_TO_MANY
;

/* =========================================================================
 * OPTION 
 * ========================================================================= */
option
:
	setting = optionSetting
;

optionSetting
:
	dtoOption
;
/* =========================================================================
 * DTO OPTION 
 * ========================================================================= */
dtoOption
:
	'dto'?
;

dtoType
:
	'mapstruct'
;

WS
:
	[ \t\r\n\u000C]+ -> skip
;

COMMENT
:
	'/*' .*? '*/' -> channel ( HIDDEN )
;

LINE_COMMENT
:
	'//' ~[\r\n]* -> channel ( HIDDEN )
;

NUMERIC_VALUE
:
	[0-9]+
;

ID
:
	[a-zA-Z$_]*
;

JavaLetterOrDigit
:
	[a-zA-Z0-9$_] // these are the "java letters or digits" below 0x7F

	| // covers all characters above 0x7F which are not a surrogate
	~[\u0000-\u007F\uD800-\uDBFF]
	| // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
	[\uD800-\uDBFF] [\uDC00-\uDFFF]
;

ONE_TO_MANY
:
	'OneToMany'
;

MANY_TO_ONE
:
	'ManyToOne'
;

ONE_TO_ONE
:
	'OneToOne'
;

MANY_TO_MANY
:
	'ManyToMany'
;

