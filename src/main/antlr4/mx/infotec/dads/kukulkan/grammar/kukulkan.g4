grammar kukulkan;

start
:
	'hello' 'world'
;

WS
:
	[ \t\r\n]+ -> skip
;