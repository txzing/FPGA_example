#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include "HLS/hls.h"
#define N 32
component void avg(float* x,float* y)
{
  int i, j, k;
  float sum;
  float avg;

  for (i = 0; i < N; i++)
    {
      sum = 0;
	  #pragma unroll 1
      for (j = -2; j <= 2; j++)
        {
          k = i + j;
          if (k >= 0 && k < N)
            sum += x[k];
        }
      avg = sum * 51 / 256;
      y[i] = avg;
    }
}

int main(){
	float a[N];
	float b[N];
	int i=0;
	srand(3);
	for(i=0;i<N;i++)
	{
		a[i] = rand()%10;
	}
	avg(a,b);
	for(i=0;i<N;i++)
	{
		printf("a[%d] = %f \n",i,a[i]);
		printf("b[%d] = %f \n",i,b[i]);
		printf("\n");
	}	
	return 0;
}
