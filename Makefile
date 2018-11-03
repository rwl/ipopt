# Copyright 2017 Richard Lincoln. All rights reserved.

OBJS = callbackfunctions.o \
       ipoptoptions.o \
       ipopt.o \
       iterate.o \
       matlabexception.o \
       matlabfunctionhandle.o \
       matlabinfo.o \
       matlabjournal.o \
       matlabprogram.o \
       options.o \
       sparsematrix.o

CXXFLAGS = -fPIC -O3 -DIPOPT_BUILD -DMATLAB_MEXFILE -DHAVE_CSTDDEF

INCL = `pkg-config --cflags ipopt` -I/usr/include/octave-4.0.2/octave -I/usr/include/octave-4.0.3/octave -I/usr/include/octave-4.2.2/octave
LIBS = `pkg-config --libs ipopt`

all: ipopt.mex

%.o: %.cpp
	g++ $(CXXFLAGS) $(INCL) -o $@ -c $^

ipopt.mex: $(OBJS)
	mkoctfile $(LIBS) -v --mex --output $@ $^

clean:
	rm -f $(OBJS) ipopt.mex

check:
	octave-cli --no-gui -p `pwd`/examples --eval "examplehs038;examplehs051;examplehs071;examplelasso"
