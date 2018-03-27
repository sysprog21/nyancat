OBJECTS = src/nyancat.o

CFLAGS	 ?= -g -Wall -Wextra -std=c99 -pedantic -Wwrite-strings
LDFLAGS  ?= -lpthread

# Control the build verbosity                                                   
ifeq ("$(VERBOSE)","1")
    Q :=
    VECHO = @true
else
    Q := @
    VECHO = @printf
endif

GIT_HOOKS := .git/hooks/applied

.PHONY: all clean

all: $(GIT_HOOKS) nyancat

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

all: nyancat

nyancat: $(OBJECTS)
	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJECTS) -o $@

bench: nyancat
	@echo "Benchmarking..."
	$(Q)./nyancat -b > /tmp/bench_out
	@echo "OK!"

clean:
	-rm -f $(OBJECTS) nyancat

.PHONY: all clean
