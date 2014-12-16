CFLAGS:=-m32 -fno-asynchronous-unwind-tables -O2

dumps: func_select.c pstring.c
	gcc func_select.c $(CFLAGS) -g -c -o func_select_dump.o
	gcc pstring.c $(CFLAGS) -g -c -o pstring_dump.o
	objdump -S func_select_dump.o > func_select.dump
	objdump -S pstring_dump.o > pstring.dump
	rm *_dump.o

%.s: %.c
	$(CC) -S -o $@ $< $(CFLAGS)

a.out: main.o func_select.o pstring.o
	gcc -m32 -g -o a.out main.o func_select.o pstring.o

main.o: main.c pstring.h
	gcc -m32 -g -c -o main.o main.c

func_select.o: func_select.s pstring.h
	gcc -m32 -g -c -o func_select.o func_select.s

pstring.o: pstring.s
	gcc -m32 -g -c -o pstring.o pstring.s	

clean:
	rm -f *.o a.out
