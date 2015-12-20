#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const unsigned long TARGET = 36000000;
const int NUM_ELVES = 2000000;
const int NUM_HOUSES = 2000000;

int main(int argc, char *argv[]) {
        unsigned long house[NUM_HOUSES];


        memset(house, 0, sizeof(unsigned long) * NUM_HOUSES);

        for (int i = 1; i <= NUM_ELVES; i++) {
                const unsigned long val = i * 11;
                for (int j = i-1, k = 0; j < NUM_HOUSES && k < 50; j += i, k++) {
                        house[j] += val;
                }
        }

        for (int i = 0; i < NUM_HOUSES; i++) {
                if (house[i] >= TARGET) {
                        printf("%d\n", i+1);
                        exit(0);
                }
        }
        puts("Not found");
        /* for (int i = 0; i < NUM_HOUSES; i++) { */
        /*         printf("%d\t%u\n", i+1, house[i]); */
        /* } */

        unsigned long max = 0;
        for (int i = 0; i < NUM_HOUSES; i++) {
                if (house[i] > max)
                        max = house[i];
        }
        printf("max was %u\n", max);


        return 0;
}
