clean:
	rm *.o
	rm interactiveMandelbrotCUDA
	
all: interactiveMandelbrotCUDA 


interactiveMandelbrotCUDA: interactiveMandelbrot.o milli.o
	nvcc interactiveMandelbrot.o milli.o -o interactiveMandelbrotCUDA -lglut -lGL
	
interactiveMandelbrot.o: interactiveMandelbrot.cu
	nvcc -c interactiveMandelbrot.cu -o interactiveMandelbrot.o -lglut -lGL
	
milli.o: milli.c
	gcc -c milli.c -o milli.o




