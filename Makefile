FC=gfortran
FARGS=-std=f95 -nocpp -pedantic -Wall
EXES=valdist fileinfo

.PHONY: all clean

all: valdist fileinfo

clean:
	rm -f $(EXES)
	cd src && $(MAKE) clean

valdist: src/valdist.f
	cd src && $(MAKE) valdist.o
	$(FC) $(FARGS) -o valdist src/valdist.o

fileinfo: src/fileinfo.f
	cd src && $(MAKE) fileinfo.o
	$(FC) $(FARGS) -o fileinfo src/fileinfo.o
