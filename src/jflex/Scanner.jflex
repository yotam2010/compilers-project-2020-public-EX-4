/***************************/
/* Based on a template by Oren Ish-Shalom */
/***************************/

/*************/
/* USER CODE */
/*************/
import java_cup.runtime.*;



/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************/
/* OPTIONS AND DECLARATIONS SECTION */
/************************************/

/*****************************************************/
/* Lexer is the name of the class JFlex will create. */
/* The code will be written to the file Lexer.java.  */
/*****************************************************/
%class Lexer

/********************************************************************/
/* The current line number can be accessed with the variable yyline */
/* and the current column number with the variable yycolumn.        */
/********************************************************************/
%line
%column

/******************************************************************/
/* CUP compatibility mode interfaces with a CUP generated parser. */
/******************************************************************/
%cup

/****************/
/* DECLARATIONS */
/****************/
/*****************************************************************************/
/* Code between %{ and %}, both of which must be at the beginning of a line, */
/* will be copied verbatim (letter to letter) into the Lexer class code.     */
/* Here you declare member variables and functions that are used inside the  */
/* scanner actions.                                                          */
/*****************************************************************************/
%{
	/*********************************************************************************/
	/* Create a new java_cup.runtime.Symbol with information about the current token */
	/*********************************************************************************/
	private Symbol symbol(int type)               {return new Symbol(type, yyline, yycolumn);}
	private Symbol symbol(int type, Object value) {return new Symbol(type, yyline, yycolumn, value);}

	/*******************************************/
	/* Enable line number extraction from main */
	/*******************************************/
	public int getLine()    { return yyline + 1; }
	public int getCharPos() { return yycolumn;   }
	public int multiCommentStartLine=-1;
%}

/***********************/
/* MACRO DECALARATIONS */
/***********************/

LineTerminator = \r|\n|\r\n

WhiteSpace = [\t ]|{LineTerminator}

INTEGER = 0|[1-9][0-9]*

ID = [a-zA-Z][a-zA-Z_0-9]*

%state COMMENTS
%state MULTICOMMENTS
%state MULTICOMMENTSSECOUND
/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************************************/
/* LEXER matches regular expressions to actions (Java code) */
/************************************************************/

/**************************************************************/
/* YYINITIAL is the state at which the lexer begins scanning. */
/* So these regular expressions will only be matched if the   */
/* scanner is in the start state YYINITIAL.                   */
/**************************************************************/

<YYINITIAL> "//"        { yybegin(COMMENTS); }
<YYINITIAL> "/*"        { multiCommentStartLine= yyline;yybegin(MULTICOMMENTS); }
<YYINITIAL> {WhiteSpace}            { }

<YYINITIAL> {
"public"                { return symbol(sym.PUBLIC); }
"+"                     { return symbol(sym.PLUS); }
"-"                     { return symbol(sym.MINUS); }
"*"                     { return symbol(sym.MULT); }
"("                     { return symbol(sym.LPAREN); }
")"                     { return symbol(sym.RPAREN); }
"["                     { return symbol(sym.LPARENSQUARE); }
"]"                     { return symbol(sym.RPARENSQUARE); }
"{"                     { return symbol(sym.LPARENCURL); }
"}"                     { return symbol(sym.RPARENCURL); }
"static"                { return symbol(sym.STATIC); }
"void"                  { return symbol(sym.VOID); }
"return"                { return symbol(sym.RETURN); }
"class"                 { return symbol(sym.CLASS); }
"main"                  { return symbol(sym.MAIN); }
{INTEGER}               { return symbol(sym.NUMBER,Integer.parseInt(yytext())); }
"String"                { return symbol(sym.STRING); }
"int"                   { return symbol(sym.INT); }
"boolean"               { return symbol(sym.BOOLEAN); }
"while"                 { return symbol(sym.WHILE); }
"else"                  { return symbol(sym.ELSE); }
"if"                    { return symbol(sym.IF); }
"System.out.println"    { return symbol(sym.SYSOUT); }
";"                     { return symbol(sym.SEMICOLON); }
"="                     { return symbol(sym.ASSIGN); }
"extends"               { return symbol(sym.EXTENDS); }
","                     { return symbol(sym.COMMA); }
"."                     { return symbol(sym.DOT); }
"false"                 { return symbol(sym.FALSE); }
"true"                  { return symbol(sym.TRUE); }
"this"                  { return symbol(sym.THIS); }
"new"                   { return symbol(sym.NEW); }
"!"                     { return symbol(sym.NOT); }
"length"                { return symbol(sym.LENGTH); }
"&&"                    { return symbol(sym.AND); }
"<"                     { return symbol(sym.LESSTHAN); }
<<EOF>>				    { return symbol(sym.EOF); }
}

<YYINITIAL> {
{ID}                    { return symbol(sym.ID,new String(yytext())); }
}

<COMMENTS> [^\n]        { }
<COMMENTS> [\n]         { yybegin(YYINITIAL); }
<MULTICOMMENTS> [^*] { }
<MULTICOMMENTS> [*] { yybegin(MULTICOMMENTSSECOUND);}
<MULTICOMMENTSSECOUND> [^/] { yybegin(MULTICOMMENTS);}
<MULTICOMMENTSSECOUND> "/" { yybegin(YYINITIAL);}