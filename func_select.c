#include <stdio.h>
#include "pstring.h"
void run_func(int opt, Pstring* p1, Pstring* p2)
{
	int i, j;
	switch(opt)
	{
		case 50:
			printf("first pstring length %d, second pstring length: %d\n", pstrlen(p1), pstrlen(p2));
			break;
		case 51:
			pstrcpy(p1, p2);
			printf("length: %d, string: %s\n", pstrlen(p1), p1->str);
			printf("length: %d, string: %s\n", pstrlen(p2), p2->str);
			break;
		case 52:
			scanf("%d", &i);
			scanf("%d", &j);
			pstrijcpy(p1, p2, i, j);
			printf("length: %d, string: %s\n", pstrlen(p1), p1->str);
			printf("length: %d, string: %s\n", pstrlen(p2), p2->str);
			break;
		case 53:
			printf("compare result: %d\n", pstrcmp(p1, p2));
			break;
		case 54:
			scanf("%d", &i);
			scanf("%d", &j);
			printf("compare result: %d\n", pstrijcmp(p1, p2, i, j));
			break;
		default:
			printf("invalid option!\n");
			break;
	}
}
