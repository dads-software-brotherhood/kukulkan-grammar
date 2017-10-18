/*
Grammar defined for kukulkan project developed at INFOTEC
*/
grammar kukulkan;

/* =========================================================================
 * ROOT
 * ========================================================================= */
JdlDomainModel:
	features+=JdlFeature*;

JdlFeature:
	JdlConstant | JdlEntity | JdlEnum | JdlRelationships | JdlOption;

/* =========================================================================
 * CONSTANT
 * ========================================================================= */
JdlConstant:
	name=ID '=' value=INT;

JdlNumericValue:
	constant=[JdlConstant] | value=INT;

/* =========================================================================
 * ENTITY
 * ========================================================================= */
JdlEntity:
	'entity' name=ID ('(' table=ID ')')? ('{'
		(fields+=JdlEntityField (','? fields+=JdlEntityField)*)?
	'}')?;

JdlEntityField:
	name=ID type=JdlFieldType;

JdlFieldType:
	  JdlEnumFieldType 
	| JdlStringFieldType 
	| JdlNumericFieldType 
	| JdlBooleanFieldType 
	| JdlDateFieldType 
	| JdlBlobFieldType 
	| JdlEntityType;

JdlEntityType:
	element=JdlEntity;

JdlEnumFieldType:
	element=[JdlEnum] validators+=JdlRequiredValidator*;

JdlStringFieldType:
	element=JdlStringType validators+=JdlStringValidators*;

JdlStringType:
	element='String';

JdlNumericFieldType:
	element=JdlNumericTypes validators+=JdlNumericValidators*;

JdlNumericTypes:
	Integer | Long | BigDecimal | Float | Double;

JdlBooleanFieldType:
	element=JdlBooleanType validators+=JdlRequiredValidator*;

JdlBooleanType:
	element='Boolean';

JdlDateFieldType:
	element=JdlDateTypes validators+=JdlRequiredValidator*;

JdlDateTypes:
	Date | LocalDate | ZonedDateTime | Instant;
	
JdlBlobFieldType:
	element=JdlBlobTypes validators+=JdlBlobValidators*;

JdlBlobTypes:
	Blob | AnyBlob | ImageBlob | TextBlob;

/* =========================================================================
 * VALIDATOR
 * ========================================================================= */
JdlStringValidators:
	required?=JdlRequiredValidator |
	minlength=JdlMinLengthValidator |
	maxlength=JdlMaxLengthValidator |
	pattern=JdlPatternValidator;

JdlNumericValidators:
	required?=JdlRequiredValidator | 
	min=JdlMinValidator | 
	max=JdlMaxValidator;

JdlBlobValidators:
	required?=JdlRequiredValidator |
	minbytes=JdlMinBytesValidator | 
	maxbytes=JdlMaxBytesValidator;

JdlRequiredValidator:
	required?='required';

JdlMinLengthValidator:
	'minlength' '(' value=JdlNumericValue ')';

JdlMaxLengthValidator:
	'maxlength' '(' value=JdlNumericValue ')';

JdlPatternValidator:
	'pattern' '(' value=STRING ')';

JdlMinValidator:
	'min' '(' value=JdlNumericValue ')';

JdlMaxValidator:
	'max' '(' value=JdlNumericValue ')';

JdlMinBytesValidator:
	'minbytes' '(' value=JdlNumericValue ')';

JdlMaxBytesValidator:
	'maxbytes' '(' value=JdlNumericValue ')';

/* =========================================================================
 * RELATIONSHIP
 * ========================================================================= */
JdlRelationships:
	'relationship' cardinality=JdlCardinality '{'
		relationships+=JdlRelationship (',' relationships+=JdlRelationship)*
	'}';

JdlRelationship:
	source=JdlRelation 'to' target=JdlRelation;

JdlRelation:
	entity=[JdlEntity] role=JdlRelationRole?;

JdlRelationRole:
	'{' name=ID ((required?=JdlRequiredValidator)? & ('(' role=ID ')')?) '}';

enum JdlCardinality:
	OneToMany | ManyToOne | OneToOne | ManyToMany;

/* =========================================================================
 * ENUM
 * ========================================================================= */
JdlEnum:
	'enum' name=ID '{'
		values+=ID (','? values+=ID)*
	'}';

/* =========================================================================
 * OPTION 
 * ========================================================================= */
JdlOption:
	setting=JdlOptionSetting (excludes=JdlExceptEntityExclusion)?;

JdlOptionSetting:
	JdlDtoOption |
	JdlPaginateOption |
	JdlServiceOption |
	JdlMicroserviceOption |
	JdlSearchOption |
	JdlSkipClientOption |
	JdlSkipServerOption |
	JdlAngularSuffixOption |
	JdlNoFluentMethodOption;

JdlWithEntityInclusion:
	(predicate=JdlWildcardPredicate | selection=JdlEntitySelection) 'with';

JdlForEntityInclusion:
	'for' (predicate=JdlWildcardPredicate | selection=JdlEntitySelection);

JdlExceptEntityExclusion:
	'except' selection=JdlEntitySelection;

JdlEntitySelection:
	entities+=[JdlEntity] (',' entities+=[JdlEntity])*;

JdlWildcardPredicate:
	wildcard?='*' | all?='all';

/* =========================================================================
 * DTO OPTION 
 * ========================================================================= */
JdlDtoOption returns JdlOptionSetting:
	dtoOption?='dto' includes=JdlWithEntityInclusion dtoType=JdlDtoType;

enum JdlDtoType:
	mapstruct;

/* =========================================================================
 * PAGINATION OPTION 
 * ========================================================================= */
JdlPaginateOption returns JdlOptionSetting:
	paginateOption?='paginate' includes=JdlWithEntityInclusion paginateType=JdlPaginateType;

JdlPaginateType:
	pagination?=('pager' | 'pagination') | infiniteScroll?='infinite-scroll';

/* =========================================================================
 * SERVICE OPTION 
 * ========================================================================= */
JdlServiceOption returns JdlOptionSetting:
	serviceOption?='service' includes=JdlWithEntityInclusion serviceType=JdlServiceType;

enum JdlServiceType:
	serviceClass | serviceImpl;

/* =========================================================================
 * MICRO SERVICE OPTION 
 * ========================================================================= */
JdlMicroserviceOption returns JdlOptionSetting:
	microserviceOption?='microservice' includes=JdlWithEntityInclusion appname=ID;

/* =========================================================================
 * SEARCH OPTION 
 * ========================================================================= */
JdlSearchOption returns JdlOptionSetting:
	searchOption?='search' includes=JdlWithEntityInclusion searchType=JdlSearchType;

enum JdlSearchType:
	elasticsearch;

/* =========================================================================
 * SKIP CLIENT OPTION 
 * ========================================================================= */
JdlSkipClientOption returns JdlOptionSetting:
	skipClientOption?='skipClient' includes=JdlForEntityInclusion;

/* =========================================================================
 * SKIP SERVER OPTION 
 * ========================================================================= */
JdlSkipServerOption returns JdlOptionSetting:
	skipServerOption?='skipServer' includes=JdlForEntityInclusion;

/* =========================================================================
 * ANGULAR SUFFIX OPTION 
 * ========================================================================= */
JdlAngularSuffixOption returns JdlOptionSetting:
	angularSuffixOption?='angularSuffix' includes=JdlWithEntityInclusion id=ID;

/* =========================================================================
 * NO FLUENT METHOD OPTION 
 * ========================================================================= */
JdlNoFluentMethodOption returns JdlOptionSetting:
	noFluentMethodOption?='noFluentMethod' includes=JdlForEntityInclusion;
