#include <stdio.h>
#include "pstring.h"
#define str_inv "invalid input!\n"
char pstrlen(Pstring *pstr)
{
	return pstr->len;
}
Pstring* pstrcpy(Pstring* dst, Pstring* src)
{
	if (src->len > dst->len)
    {
        printf(str_inv);
		return dst;
    }
    pstrijcpy(dst, src, 0, src->len);
	dst->len = src->len;
    return dst;
}
Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)
{
	int n, l1 = dst->len, l2 = src->len;
	if (i > j || i > l1 || i > l2 || j > l1 || j > l2)
    {
		printf("invalid input!\n");
        return dst;
    }
	for( n = i; n <= j; n++)
	{
		dst->str[n] = src->str[n];
	}
	return dst;
}
int pstrcmp(Pstring* pstr1, Pstring* pstr2)
{
     return pstrijcmp(pstr1, pstr2, 0, pstr1->len);
}
int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)
{
	int n, l1 = pstr1->len, l2 = pstr2->len;
	if (i > j || i > l1 || i > l2 || j > l1 || j > l2)
    {
		printf(str_inv);
        return -2;
    }
	for (n = i; n <= j; n++)
	{
		if (pstr1->str[n] > pstr2->str[n])
			return 1;
		else if (pstr1->str[n] < pstr2->str[n])
			return -1;
	}
	return 0;
}
