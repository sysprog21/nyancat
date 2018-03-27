OBJECTS = src/nyancat.o

CFLAGS	 ?= -g -Wall -Wextra -std=c99 -pedantic -Wwrite-strings
LDFLAGS  ?= -lpthread

all: nyancat

nyancat: $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTS) -o $@

bench: nyancat
	@echo "Benchmarking..."
	./nyancat -b > /tmp/bench_out
	@echo "OK!"

clean:
	-rm -f $(OBJECTS) nyancat

.PHONY: all clean
