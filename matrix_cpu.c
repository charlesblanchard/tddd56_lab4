// Matrix addition, CPU version
// gcc matrix_cpu.c -o matrix_cpu -std=c99

#include <stdio.h>
#include "milli.h"

#define N 256

void add_matrix(float *a, float *b, float *c, int M)
{
	int index;
	
	for (int i = 0; i < M; i++)
		for (int j = 0; j < M; j++)
		{
			index = i + j*M;
			c[index] = a[index] + b[index];
		}
}

int main()
{
	//const int N = 80;
	
	int time;

	float a[N*N];
	float b[N*N];
	float c[N*N];

	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
		{
			a[i+j*N] = 10 + i;
			b[i+j*N] = (float)j / N;
		}
		
	ResetMilli();
	add_matrix(a, b, c, N);
	time = GetMicroseconds();
	/*
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			printf("%0.2f ", c[i+j*N]);
		}
		printf("\n");
	}*/
	printf("\n%i Time : %i\n",N, time);
}
