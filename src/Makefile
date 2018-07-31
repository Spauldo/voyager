FC=gfortran
FARGS=-std=f95 -nocpp -pedantic -Wall
OBJS=valdist.o fileinfo.o

.PHONY: clean all

all: $(OBJS)

clean:
	rm -f $(OBJS)

valdist.o: valdist.f
	$(FC) $(FARGS) -c valdist.f

fileinfo.o: fileinfo.f
	$(FC) $(FARGS) -c fileinfo.f
