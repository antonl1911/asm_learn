asm_learn
=========
Note: A representation of p-string is saving the string together with its length:

typedef struct{
         char size;
         char string[255];
}Pstring;



In this assignment, you will implement (in Assembly) library functions that will work on
strings in a similar way to the C library string.h.

What you need to hand in:
  1. pstring.s – Source file that will implement the library functions (listed below),
       without a 'main' function.
  2. func_select.s – A file that will implement a function that calls the suitable library
       function (see "Program Structure").

Attached with this assignment:
    1. pstring.h – Contains the declarations for the requested functions.
    2. main.c – The file with the 'main' function, calls 'run_func' from func_select.h.
    3. makefile – Creates an executable file for the program.                          

Program Structure:

The 'main' function receives from user two strings, their lengths, and a menu option. It
builds two 'pstrings' according to the input strings and input lengths, and sends 'run_func'
the menu option and the addresses of the 'pstrings'. The full code appears in 'main.c'.
Function 'run_func' (which you will implement in 'func_select.s') reads the menu option
(received as parameter) and uses a jump table (switch-case):

If 50 is received – Using function 'pstrlen', calculate the lengths of the two 'pstrings' and
print the two lengths. Print format: "first pstring length: %d, second pstring length: %d\n".

If 51 is received – Using function 'pstrcpy', copy the second 'pstring' (source) into the first
(destination). After copying, print the first 'pstring' (destination) with print format: "length:
%d, string: %s\n".
Then print the second 'pstring' (source) with the same format.

If 52 is received – Receive as input from user two integers – the first number will be the start
index, and the second number will be the end index. Next, call function 'pstrijcpy', where 'j'
is the end index, 'i' is start index, 'src' is a pointer to the second 'pstring', and 'dst' is a
pointer to the first 'pstring'. After copying, print the first 'pstring' (destination) with format:
"length: %d, string: %s\n".
Then print the second 'pstring' (source) with the same format.
Notice: You will print these messages even if 'pstrijcpy' printed an error message (see info
about 'pstrijcpy').
If 53 is received – Using function 'pstrcmp', compare the two 'pstring's received. Notice that
'pstr2' is a pointer to the second 'pstring' and 'pstr1' is a pointer to the first 'pstring'. After
comparison, print the comparison result in format: "compare result: %d\n".

If 54 is received – Receive as input from user two integers – the first number will be the start
index, and the second number will be the end index. Next, call function 'pstrijcmp', where 'j'
is the end index, 'i' is start index, 'src' is a pointer to the second 'pstring', and 'dst' is a
pointer to the first 'pstring'. After comparison, print the comparison result in format:
"compare result: %d\n".
Notice: You will print these messages even if 'pstrijcmp' printed an error message (see info
about 'pstrijcmp').

In any case, after completing the action, the program should be ended neatly.

If 'run_func' received a different number – print: "invalid option!\n".

Functions for implementation in pstring.s:

char pstrlen(Pstring* pstr)
Function receives pointer to Pstring and returns the string's length.

Pstring* pstrcpy(Pstring* dst, Pstring* src)
Function receives two Pstring pointers, copies 'src' to 'dst' and returns a pointer to 'dst'.
Notice that you need to update the 'str' and 'len' fields. If 'src' is longer than 'dst', do not
change 'dst'.

Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)
Like 'pstrcpy', but copies sub-string 'src[i:j]' (inclusive)into 'ds[i:j]' (inclusive). If indices 'i' or 'j'
are out of bounds of 'src' or 'dst', do not change 'dst' and print: "invalid input!\n".

int pstrcmp(Pstring* pstr1, Pstring* pstr2)
Function receives two Pstring pointers, and compares them:
   1. If 'pstr1' is longer than 'pstr2', function returns 1.
   2. If 'pstr2' is longer than 'pstr1', function returns -1.
   3. If their lengths are equal, function returns the same value as
       strcmp(pstr1->str,pstr2->str):                               
       a. Function returns 1 if 'pstr1' is larger lexicographically (by ASCII) than 'pstr2'.
       b. Function returns -1 if 'pstr2' is larger lexicographically (by ASCII) than 'pstr1'.
       c. Function returns 0 if the strings are identical.                                   

int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)
Function compares pstr1->str[i:j] (inclusive) and pstr2->str[i:j] (inclusive). If indices 'i' or 'j'
are out of bounds of pstr1->str or pstr2->str, print: "invalid input!\n".
Notice that 'pstr1' and 'pstr2' may have different lengths, but still sub-strings between 'i' and
'j' (inclusive) of each will be equal. Function returns:
      1. 1 if pstr1->str[i:j] is larger lexicographically than pstr2->str[i:j].
      2. -1 if pstr2->str[i:j] is larger lexicographically than pstr1->str[i:j].
      3. 0 if pstr1->str[i:j] and pstr2->str[i:j] are equal.                    
Comments:
   1. You cannot use functions from string.h.
    2. The only external functions you are allowed to use are 'scanf' and 'printf'.
    3. Code will be tested with different inputs, but you can assume all inputs will be
        according to what was defined in the instructions.
    4. You can assume that in any of the 'pstring's received as input, the string length will
        be equal to its length field (for example, if input is "hello", then you can assume the
        length field will be 5 for sure).
    5. Follow the instructions carefully (for example, don't use a series of 'if' statements
        instead of 'switch').
    6. Insert meaningful comments every 1-5 lines, and of course in any non-trivial
        command. An outside programmer looking at your code should be able to easily
        understand the program's structure and flow.
    7. Organize your code: TAB before a command (but not before 'label'), TAB between a
        command and its arguments, and TAB before comments. This way, all command
        names (addl, movl, subl…) appear one underneath the other, the arguments appear
        under other arguments, and the same with comments. You can see "Hello.s" for an
        example.
    8. You must use each register according to its convention (caller save, callee save, etc.)
    9. In each function make sure you do the regular actions in the beginning: saving the
        old frame pointer, assigning a new frame with the right size, saving the correct
        registers that will be used, and all the same reversed actions in the end of the
        function.
    10. Code should be efficicent and readable.


Running exmaples:

hello
5
world
5
50
first pstring length: 5, second pstring length: 5

hello
5
bye
3
51
length: 3, string: bye
length: 3, string: bye
hello
5
world
5
52
1
4
length: 5, string: horlo
length: 5, string: world

hello
5
world
5
53
compare result: -1

hello
5
world
5
54
1
10
invalid input!
compare result: -2

hello
5
world
5
78
invalid input!

