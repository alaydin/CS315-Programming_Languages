%{
#include <stdio.h>
void yyerror(char *);
%}

COMMENT     \/\/[^\n]*

DIGIT       [0-9]
LETTER      [A-Za-z]

CONSTANT    const
VOID_TYPE   void
DOUBLE_TYPE double
INT_TYPE    int
CHAR_TYPE   char
STRING_TYPE string
BOOLEAN_TYPE bool
TYPE        {VOID_TYPE}|{DOUBLE_TYPE}|{INT_TYPE}|{CHAR_TYPE}|{STRING_TYPE}

LP          \(
RP          \)
LSB         \[
RSB         \]
LB          \{
RB          \}
COMMA       \,
SEMICOLON   \;
DOT         \.
UNDERSCORE  \_
STR_IDENT   \"
CHAR_IDENT  \'

BIT_AND     \&
BIT_OR      \|
BIT_XOR     \^
AND         \&\&
NOT         \!
OR          \|\|
XOR         \|\^\|

ASSIGNMENT_OP \=
ASSIGN_SUM    \+\=
ASSIGN_DIFF   \-\=
ASSIGN_PROD   \*\=
ASSIGN_QUOT   \/\=

EQUAL_OP      \=\=
GREATER       \>
LESS          \<
GREATER_OR_EQ \>\=
LESS_OR_EQ    \<\=
NOT_EQUAL     \!\=
BOOLEAN     true|false

INCREMENT   \+\+
DECREMENT   \-\-
MULT        \*
DIV         \/
MINUS       \-
PLUS        \+
MOD         \%

SET_COMPLEMENT   \~
SET_UNION        \*\+
SET_DIFF         \*\/
SET_INTERSECTION \*\%
SUBSET           \$
SUPERSET         \?
CARTESIAN_PRODUCT \*\*

IF          if
ELSE        else
ELSE_IF     "else if"

FOR         for
DO          do
WHILE       while
CHOKE	    choke
RETURN      return

UNSIGNED_INT {DIGIT}+
POSITIVE_INT (\+)({DIGIT})+
NEGATIVE_INT (\-)({DIGIT})+

UNSIGNED_REAL {DIGIT}+|{DIGIT}+\.{DIGIT}+
POSITIVE_REAL (\+){DIGIT}+|(\+){DIGIT}+\.{DIGIT}+
NEGATIVE_REAL (\-){DIGIT}+|(\-){DIGIT}+\.{DIGIT}+

IDENTIFIER  {LETTER}({LETTER}|{DIGIT}|{UNDERSCORE})*
STRING      \"([^\\\"]|\\\"|\\\n|\\\\)*\"

DEFINE_SET  defSet
DELETE_SET  delSet

SYSTEM_CALL vader
INPUT_FUNC  vaderGets
OUTPUT_FUNC vaderGives

DEFINE_FUNC defFunc
CALL_FUNC   run

%option yylineno
%%

{LP}            return LP;
{RP}	      	return RP;
{LSB}	      	return LSB;
{RSB}	      	return RSB;
{LB}	      	return LB;
{RB}	      	return RB;
{DOT}         	return DOT;
{INCREMENT}   	return INCREMENT;
{DECREMENT}   	return DECREMENT;
{PLUS}		return PLUS;
{MINUS}		return MINUS;
{MULT}		return MULT;
{DIV}		return DIV;
{MOD}		return MOD;
{GREATER}     	return GREATER;
{LESS}        	return LESS;
{GREATER_OR_EQ} return GREATER_OR_EQ;
{LESS_OR_EQ}  	return LESS_OR_EQ;
{EQUAL_OP}    	return EQUAL_OP;
{NOT_EQUAL}   	return NOT_EQUAL;
{BIT_AND}     	return BIT_AND;
{BIT_XOR}     	return BIT_XOR;
{BIT_OR}      	return BIT_OR;
{NOT}		return NOT;
{AND}         	return AND;
{OR}          	return OR;
{XOR}         	return XOR;
{ASSIGNMENT_OP} return ASSIGNMENT_OP;
{ASSIGN_SUM}  	return ASSIGN_SUM;
{ASSIGN_DIFF} 	return ASSIGN_DIFF;
{ASSIGN_PROD} 	return ASSIGN_PROD;
{ASSIGN_QUOT} 	return ASSIGN_QUOT;
{BOOLEAN}     	return BOOLEAN;

{SET_COMPLEMENT}   return SET_COMPLEMENT;
{SET_UNION}	   return SET_UNION;
{SET_DIFF}	   return SET_DIFF;
{SET_INTERSECTION} return SET_INTERSECTION;
{SUBSET}           return SUBSET;
{SUPERSET}         return SUPERSET;
{CARTESIAN_PRODUCT} return CARTESIAN_PRODUCT;

{COMMA}       	return COMMA;
{STR_IDENT}   	return STR_IDENT;
{CHAR_IDENT}  	return CHAR_IDENT;

{FOR}         	return OR;
{DO}          	return DO;
{WHILE}       	return WHILE;

{IF}          	return IF;
{ELSE}        	return ELSE;
{ELSE_IF}    	return ELSE_IF;

{CHOKE}		return CHOKE;
{RETURN}      	return RETURN;

{UNSIGNED_INT}  return UNSIGNED_INT;
{POSITIVE_INT}  return POSITIVE_INT;
{NEGATIVE_INT}  return NEGATIVE_INT;
{UNSIGNED_REAL} return UNSIGNED_REAL;
{POSITIVE_REAL} return POSITIVE_REAL;
{NEGATIVE_REAL} return NEGATIVE_REAL;

{CONSTANT}    	return CONSTANT;
{VOID_TYPE}   	return VOID_TYPE;
{DOUBLE_TYPE} 	return DOUBLE_TYPE;
{INT_TYPE}    	return INT_TYPE;
{CHAR_TYPE}   	return CHAR_TYPE;
{STRING_TYPE} 	return STRING_TYPE;
{BOOLEAN_TYPE}	return BOOLEAN_TYPE;
{SEMICOLON}   	return SEMICOLON;
{UNDERSCORE}  	return UNDERSCORE;

{INPUT_FUNC}	return INPUT_FUNC;
{OUTPUT_FUNC}	return OUTPUT_FUNC;
{SYSTEM_CALL}	return SYSTEM_CALL;
{CALL_FUNC}   	return CALL_FUNC;
{DEFINE_FUNC} 	return DEFINE_FUNC;
{DEFINE_SET}	return DEFINE_SET;
{DELETE_SET}	return DELETE_SET;
{COMMENT}	return COMMENT;
{IDENTIFIER}  	return IDENTIFIER;
{STRING}	return STRING;
%%

int yywrap(void) {
	return 1;
}
