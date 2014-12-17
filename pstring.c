#include <stdio.h>
#include "pstring.h"
char pstrlen(Pstring *pstr)
{
	return pstr->len;
}
Pstring* pstrcpy(Pstring* dst, Pstring* src)
{
     return pstrijcpy(dst, src, 0, src->len);
}
Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)
{
    int n;
	if (src->len > dst->len)
		return dst;
	for( n = i; n <= j; n++)
	{
		dst->str[n] = src->str[n];
	}
	dst->len = src->len;
	return dst;
}
int pstrcmp(Pstring* pstr1, Pstring* pstr2)
{
     return pstrijcmp(pstr1, pstr2, 0, pstr1->len);
}
int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)
{
	int n;
	if (i > j)
		printf("invalid input!\n");
	if (i > pstr1->len || i > pstr2->len)
		printf("invalid input!\n");
	if (j > pstr1->len || j > pstr2->len)
		printf("invalid input!\n");
	for (n = i; n <= j; n++)
	{
		if (pstr1->str[n] > pstr2->str[n])
			return 1;
		else if (pstr1->str[n] < pstr2->str[n])
			return -1;
	}
	return 0;
}
