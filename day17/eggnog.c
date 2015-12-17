#include <stdio.h>
#include <stdlib.h>

#define NUM_CONTAINERS 20
#define TARGET 150
#define MAX_LEN 80

int main(int argc, char *argv[]) {
        FILE *fp;

        if ((fp = fopen("input.txt", "r")) == NULL) {
                perror("input.txt");
                exit(1);
        }

        char line[MAX_LEN];
        int container[NUM_CONTAINERS];
        int buckets[NUM_CONTAINERS];
        int i = 0;

        while (fgets(line, MAX_LEN, fp) != NULL) {
                container[i++] = atoi(line);
        }

        fclose(fp);

        int cnt = 0;
        for (i = 0; i < NUM_CONTAINERS; i++)
                buckets[i] = 0;

        for (i = 1; i < 1 << NUM_CONTAINERS; i++) {
                int sum = 0;
                int num_buckets = 0;
                int exp;
                for (exp = 0; exp < NUM_CONTAINERS; exp++) {
                        if (i & 1 << exp) {
                                sum += container[exp];
                                num_buckets++;
                        }
                }
                if (sum == TARGET) {
                        cnt++;
                        buckets[num_buckets]++;
                }
        }

        printf("total = %d\n", cnt);
        for (i = 0; i < NUM_CONTAINERS; i++)
                printf("%d => %d\n", i, buckets[i]);

        return 0;
}

  
