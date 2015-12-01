#include <stdio.h>

int main (int argc, char *argv[]) {
        int c;
        int floor = 0;
        int basement = 0;
        int i = 0;

        while ((c = getchar()) != EOF) {
                i++;
                switch (c) {
                case '(' :
                        floor++;
                        break;
                case ')' :
                        floor--;
                        if (floor < 0 && basement == 0) {
                                basement = i;
                        }
                        break;
                case '\n' :
                        printf("floor = %d, basement = %d\n", floor, basement);
                        floor = 0;
                        basement = 0;
                        i = 0;
                        break;
                }
        }
        return 0;
}
