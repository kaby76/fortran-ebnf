grammar wg5_ebnf;

alternative : element* ;
alternatives : alternative (ALT alternative)* ;
element : zero_or_one | zero_or_more | STRING | CHAR | id_ | ANY | LEFT_SQUARE_BRACKET | RIGHT_SQUARE_BRACKET ;
id_ : ID ;
lhs : EXCLAMATION_MARK? id_ ;
zero_or_one : LEFT_SQUARE_BRACKET alternatives RIGHT_SQUARE_BRACKET ;
zero_or_more : LEFT_SQUARE_BRACKET alternatives RIGHT_SQUARE_BRACKET DOT_DOT_DOT;
rhs : alternatives ;
rule_ : RULE_NUMBER lhs ASSIGN rhs ;
rulelist : rule_* EOF ;

QU : '\'';
ASSIGN : '<b>is</b>';
ALT : '<b>or</b>' ;
CHAR : '\'' ~'\''* '\'' ;
COMMENT : '//' ~[\n\r]* -> channel(HIDDEN) ;
DOT_DOT_DOT : '...';
ID : '<i>' ('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' | '_')+ '</i>';
LEFT_SQUARE_BRACKET : '[' ;
RIGHT_SQUARE_BRACKET : ']' ;
STRING : '"' ~'"'* '"'
 | '\'' .*? '\''
 | '\'\'\''
 | '\uFFFD' '\'' '\uFFFD'
 | '\uFFFD' ~('\uFFFD' | '\n' | '\r')* '\uFFFD'
 ;
WS : [ \t] -> channel(HIDDEN) ;
NL : [\r\n]+ -> channel(HIDDEN);
RULE_NUMBER : 'R' { 
Functional.Lambda<bool>( () =>
{
	return this.Column == 1;
})()
 }? [0-9]+;
ANY : .;
