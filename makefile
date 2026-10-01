file-read:
	as file-read.s -o file-read.o
	ld file-read.o -o file-read
clean:
	rm *.o
	rm file-read