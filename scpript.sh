



nvcc matrix_gpu.cu -L /usr/local/cuda/lib -lcudart -o matrix_gpu

gcc milli.o matrix_cpu.c -o matrix_cpu -std=c99

echo gpu
for i in `seq 1 10`;
do	
	./matrix_gpu
done

echo

echo cpu
for i in `seq 1 10`;
do	
	./matrix_cpu
done
