// Matrix addition, GPU version
// nvcc matrix_gpu.cu -L /usr/local/cuda/lib -lcudart -o matrix_gpu

#include <stdio.h>


const int blocksize = 16; 
const int N = 1024;
const int gridsize = N / blocksize;

__global__
void add_matrix(float *a, float *b, float *c, int N)
{
	int index_x = blockIdx.x * blockDim.x + threadIdx.x;
	int index_y = blockIdx.y * blockDim.y + threadIdx.y;
	
	int grid_width = gridDim.x * blockDim.x;
	
	int index = index_y * grid_width + index_x;
	
	c[index] = a[index] + b[index];
}

int main()
{
	
	
	float *a = new float[N*N];
	float *b = new float[N*N];
	float *c = new float[N*N];
	
	unsigned long size = N*N*sizeof(float);
	
	float *gpu_a;
	float *gpu_b;
	float *gpu_c;

	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
		{
			a[i+j*N] = 10 + i;
			b[i+j*N] = (float)j / N;
		}
		
	cudaEvent_t begin;
	cudaEvent_t end;
	
	float elapsed;
	
	cudaEventCreate(&begin);
	cudaEventCreate(&end);
	
	cudaMalloc( (void**)&gpu_a, size);
	cudaMalloc( (void**)&gpu_b, size);
	cudaMalloc( (void**)&gpu_c, size);
	
	
	// dim3 dimBlock( blockDim.x, blockDim.y, 1);
	dim3 dimBlock( blocksize,blocksize,1);
	
	// dim3 dimGrid( blockIdx.x, blockIdx.y );
	dim3 dimGrid(  gridsize, gridsize );
	
	cudaMemcpy( gpu_a, a, size, cudaMemcpyHostToDevice ); 
	cudaMemcpy( gpu_b, b, size, cudaMemcpyHostToDevice ); 
	
	cudaEventRecord(begin, 0);
	
	add_matrix<<<dimGrid, dimBlock>>>(gpu_a,gpu_b,gpu_c,N);
	
	cudaThreadSynchronize();
	cudaEventRecord(end, 0);
	
	
	
	cudaMemcpy( c, gpu_c, size, cudaMemcpyDeviceToHost ); 
	cudaFree( gpu_a );
	cudaFree( gpu_b );
	cudaFree( gpu_c );
	
	cudaEventSynchronize(end);
	
	cudaEventElapsedTime(&elapsed, begin, end);

	/*
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			printf("%0.2f ", c[i+j*N]);
		}
		printf("\n");
	}
	printf("\n");*/
	printf("Blocksize = %i\tN = %i Time : %f\n",blocksize,N,elapsed*1000);
}
