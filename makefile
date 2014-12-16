CFLAGS:=-m32 -fno-asynchronous-unwind-tables -Og -ggdb -gstabs+

dumps: func_select.c pstring.c
	gcc func_select.c $(CFLAGS) -g -c -o func_select_dump.o
	gcc pstring.c $(CFLAGS) -g -c -o pstring_dump.o
	objdump -S func_select_dump.o > func_select.dump
	objdump -S pstring_dump.o > pstring.dump
	rm *_dump.o

a.out: main.o func_select.o pstring.o
	gcc -m32 -g -o a.out main.o func_select.o pstring.o

main.o: main.c pstring.h
	gcc $(CFLAGS) -c -o main.o main.c

func_select.o: func_select.s pstring.h
	gcc $(CFLAGS) -c -o func_select.o func_select.s

pstring.o: pstring.s
	gcc $(CFLAGS) -c -o pstring.o pstring.s	

clean:
	rm -f *.o a.out
