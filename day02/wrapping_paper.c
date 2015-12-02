#include <stdio.h>
#include <string.h>

int wrapping(int *d);
int ribbon(int *d);

int main (int argc, char *argv[]) {
        int c;
        int total_wrapping = 0;
        int total_ribbon = 0;
        int d[3];
        int i = 0;

        memset(d, 0, sizeof(int) * 3);
        while ((c = getchar()) != EOF) {
                if (c >= '0' && c <= '9') {
                        d[i] = d[i] * 10 + c - '0';
                } else if (c == 'x') {
                        if (++i >= 3) {
                                fprintf(stderr, "parse error: too many x's\n");
                                return 1;
                        } 
                } else if (c == '\n') {
                        int wrap = wrapping(d);
                        int rib = ribbon(d);
                        total_wrapping += wrap;
                        total_ribbon += rib;
                        i = 0;
                        memset(d, 0, sizeof(int) * 3);
                } else {
                        fprintf(stderr, "unexpected character: %c\n", c);
                        return 2;
                }
        }

        printf("total wrapping = %d\n", total_wrapping);
        printf("total ribbon = %d\n", total_ribbon);

        return 0;
}

int wrapping (int *d) {
        int volume = 0;
        int smallest = 0;
        int i, j;

        for (i = 0; i <= 1; i++) {
                for (j = i+1; j <= 2; j++) {
                        int area = d[i] * d[j];
                        volume += 2 * area;
                        if (smallest == 0 || area < smallest) {
                                smallest = area;
                        }
                }
        }

        return volume + smallest;
}

int ribbon (int *d) {
        int smallest = 0;
        int i, j;

        for (i = 0; i <= 1; i++) {
                for (j = i+1; j <= 2; j++) {
                        int perim = 2 * (d[i] + d[j]);
                        if (smallest == 0 || perim < smallest) {
                                smallest = perim;
                        }
                }
        }

        return smallest + d[0] * d[1] * d[2];
}
