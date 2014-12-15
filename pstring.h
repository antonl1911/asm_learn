typedef struct {
	char len;
	char str[255];
} Pstring;


char pstrlen(Pstring* pstr);

Pstring* pstrcpy(Pstring* dst, Pstring* src);

Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j);

int pstrcmp(Pstring* pstr1, Pstring* pstr2);

int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j);

