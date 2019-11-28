



nvcc matrix_gpu.cu -L /usr/local/cuda/lib -lcudart -o matrix_gpu -N=$1

gcc -c matrix_cpu.c -o matrix_cpu.o N=$1
gcc -c milli.c -o milli.o

gcc matrix_cpu.o milli.o -o matrix_cpu
