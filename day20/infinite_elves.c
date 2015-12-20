#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const unsigned long TARGET = 36000000;
const int NUM_ELVES = 1000000;
const int NUM_HOUSES = 1000000;

int main(int argc, char *argv[]) {
        unsigned long house[NUM_HOUSES];


        memset(house, 0, sizeof(unsigned long) * NUM_HOUSES);

        for (int i = 1; i <= NUM_ELVES; i++) {
                const unsigned long val = i * 10;
                for (int j = i-1; j < NUM_HOUSES; j += i) {
                        house[j] += val;
                        if (house[j] >= TARGET) {
                                printf("%d\n", j+1);
                                exit(0);
                        }
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
