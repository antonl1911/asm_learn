#include <stdio.h>
#include "pstring.h"
static char* errinput = "invalid input!\n";
char pstrlen(Pstring *pstr)
{
	return pstr->len;
}
Pstring* pstrcpy(Pstring* dst, Pstring* src)
{
	int i;
	if (src->len > dst->len)
		return dst;
	for (i = 0; i < src->len; i++)
	{
		dst->str[i] = src->str[i];
	}
	dst->len = src->len;
	return dst;
}
Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)
{
	if (src->len > dst->len)
		return dst;
	for( i = 0; i < src->len; i++)
	{
		dst->str[i] = src->str[i];
	}
	dst->len = src->len;
	return dst;
}
int pstrcmp(Pstring* pstr1, Pstring* pstr2)
{
	int i;
	if (pstr1->len > pstr2->len)
		return 1;
	else if (pstr1->len < pstr2->len)
		return -1;
	else {
		for (i = 0; i < pstr1->len; i++)
		{
			if (pstr1->str[i] > pstr2->str[i])
				return 1;
			else if (pstr1->str[i] < pstr2->str[i])
				return -1;
		}
		return 0;
	}
}
int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)
{
	int n;
	if (i > j)
		printf("%s", errinput);
	if (i > pstr1->len || i > pstr2->len)
		printf("%s", errinput);
	if (j > pstr1->len || j > pstr2->len)
		printf("%s", errinput);
	for (n = i; n <= j; n++)
	{
		if (pstr1->str[n] > pstr2->str[n])
			return 1;
		else if (pstr1->str[n] < pstr2->str[n])
			return -1;
	}
	return 0;
}
