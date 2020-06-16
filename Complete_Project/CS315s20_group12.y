%{
      #include <stdio.h>
      #include <stdlib.h>
  int yylex(void);
  void yyerror(char* s);
  extern int yylineno;
  %}

%token COMMENT

//TYPES
%token CONSTANT
%token VOID_TYPE
%token DOUBLE_TYPE
%token INT_TYPE
%token CHAR_TYPE
%token STRING_TYPE
%token BOOLEAN_TYPE
%token TYPE
%token DIGIT
%token LETTER


//Assignments
%token ASSIGNMENT_OP
%token ASSIGN_SUM
%token ASSIGN_DIFF
%token ASSIGN_PROD
%token ASSIGN_QUOT

//Isaretler
%token LP
%token RP
%token LSB
%token RSB
%token LB
%token RB
%token COMMA
%token SEMICOLON
%token DOT
%token UNDERSCORE
%token BOOLEAN
%token STR_IDENT
%token CHAR_IDENT

// AND MAND İŞARET
%token BIT_AND
%token BIT_OR
%token BIT_XOR
%token AND
%token NOT
%token OR
%token XOR

//COMPARISON
%token EQUAL_OP
%token NOT_EQUAL
%token GREATER
%token LESS
%token GREATER_OR_EQ
%token LESS_OR_EQ

// TOPLAMA FALAN
%token INCREMENT
%token DECREMENT
%token MULT
%token DIV
%token MINUS
%token PLUS
%token MOD

//Sayılar
%token UNSIGNED_INT
%token POSITIVE_INT
%token NEGATIVE_INT
%token UNSIGNED_REAL
%token POSITIVE_REAL
%token NEGATIVE_REAL

//SET
%token DEFINE_SET
%token SET_COMPLEMENT
%token SET_UNION
%token SET_DIFF
%token SET_INTERSECTION
%token SUBSET
%token SUPERSET
%token CARTESIAN_PRODUCT
%token DELETE_SET

//
%token IF
%token ELSE
%token ELSE_IF

//
%token FOR
%token DO
%token WHILE
%token CHOKE
%token RETURN

%right ASSIGNMENT_OP
%left DIV
%left MINUS
%left PLUS
%left MULT

//SYS-INPUT-OUTPUT
%token SYSTEM_CALL
%token CALL_FUNC
%token DEFINE_FUNC
%token INPUT_FUNC
%token OUTPUT_FUNC

//IDENTIFIER
%token IDENTIFIER
%token STRING

%start program
%%

 // BNF

program: stmts

stmts: stmt | stmts stmt

stmt: COMMENT
| declaration_stmt
| end_stmt
| assign_stmt
| declaration_togetherInit
| for_stmt
| if_stmt
| while_stmt
| input_stmt
| output_stmt
| set_stmt
| set_init_stmt
| set_op_stmt
| funct_stmt
| functcall_stmt
| return_stmt

end_stmt: SEMICOLON

declaration_stmt: var IDENTIFIER end_stmt

assign_stmt: IDENTIFIER ASSIGNMENT_OP arithmetic_expr end_stmt

declaration_togetherInit: var IDENTIFIER ASSIGNMENT_OP arithmetic_expr end_stmt

for_stmt: FOR LP declaration_togetherInit for_expr end_stmt for_update RP LB stmts RB

if_stmt: IF LP logic_expr RP LB stmts RB
         | IF LP logic_expr RP LB stmts RB ELSE LB stmts RB

while_stmt: WHILE LP logic_expr RP LB stmts RB

input_stmt: INPUT_FUNC LP RP

output_stmt: OUTPUT_FUNC LP assignment_values RP

set_stmt: DEFINE_SET IDENTIFIER end_stmt
| DEFINE_SET IDENTIFIER LSB RSB end_stmt
| DEFINE_SET IDENTIFIER LSB UNSIGNED_INT RSB end_stmt

set_init_stmt: DEFINE_SET IDENTIFIER LSB UNSIGNED_INT RSB ASSIGNMENT_OP LB parameter_expr RB end_stmt
| DEFINE_SET IDENTIFIER LSB RSB ASSIGNMENT_OP set_op_stmt end_stmt
| IDENTIFIER ASSIGNMENT_OP LB parameter_expr RB end_stmt

set_op_stmt: set_operation IDENTIFIER
| IDENTIFIER set_relation IDENTIFIER 
| set_op_stmt set_relation IDENTIFIER

funct_stmt: VOID_TYPE IDENTIFIER LP funcparameter_expr RP LB stmts RB
| VOID_TYPE IDENTIFIER LP RP LB stmts RB
| var IDENTIFIER LP funcparameter_expr RP LB stmts return_stmt RB
| var IDENTIFIER LP RP LB stmts return_stmt RB

functcall_stmt: IDENTIFIER LP parameter_expr RP
| IDENTIFIER LP RP
| IDENTIFIER DOT IDENTIFIER LP RP

return_stmt: RETURN assignment_values  end_stmt | RETURN set_op_stmt end_stmt

 // Expressions
assignment_values: DIGIT | LETTER | BOOLEAN | STRING | UNSIGNED_INT | POSITIVE_INT | NEGATIVE_INT | UNSIGNED_REAL | POSITIVE_REAL | NEGATIVE_REAL | IDENTIFIER

logic_expr:  arithmetic_expr comparison arithmetic_expr

arithmetic_expr: term
| arithmetic_expr PLUS term
| arithmetic_expr MINUS term
| arithmetic_expr set_relation term
term: factor
|term MULT factor
| term DIV factor
factor: result
| MINUS factor
| PLUS  factor
result: functcall_stmt
| input_stmt
| assignment_values
| LP arithmetic_expr RP

set_operation: SET_COMPLEMENT | DELETE_SET

set_relation: SET_UNION | SET_DIFF | SET_INTERSECTION | SUBSET | SUPERSET | CARTESIAN_PRODUCT

comparison: GREATER | LESS | GREATER_OR_EQ | LESS_OR_EQ | EQUAL_OP | AND | OR | NOT_EQUAL

for_expr: arithmetic_expr comparison arithmetic_expr

funcparam_dec: var assignment_values

funcparameter_expr: funcparam_dec
| funcparam_dec  COMMA funcparam_dec

parameter_expr: assignment_values | assignment_values COMMA parameter_expr

for_update: IDENTIFIER ASSIGNMENT_OP arithmetic_expr

var: INT_TYPE | BOOLEAN_TYPE | STRING_TYPE | DOUBLE_TYPE | CONSTANT var

%%
#include "lex.yy.c"
void yyerror(char *s) {
  fprintf(stdout, "line %d: %s\n", yylineno,s);
 }
int main(void){
  yyparse();
  if(yynerrs < 1){
    printf("Parsing is successful\n");
  }
  return 0;
}

