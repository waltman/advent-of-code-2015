#include <stdio.h>
#include <string.h>

#define MAX_LEN 100

int main(int argc, char *argv[]) {
        FILE *fp;
        char line[MAX_LEN];
        int num_nice = 0;

        if (argc != 2) {
                fprintf(stderr, "Usage: naughty <file>\n");
                return 1;
        }

        if ((fp = fopen(argv[1], "r")) == NULL) {
                perror(argv[1]);
                return 1;
        }

        while (fgets(line, MAX_LEN, fp) != NULL) {
                int pair;
                int between;
                int i, j;
                size_t len = strlen(line);

                /* look for repeating pair of letters */
                pair = 0;
                for (i = 0; !pair && i < len - 4; i++) {
                        for (j = i+2; j < len - 2; j++) {
                                if (line[i] == line[j] && line[i+1] == line[j+1])
                                        pair = 1;
                        }
                }

                /* look for double letters */
                between = 0;
                for (i = 0; !between && i < len - 3; i++) {
                        if (line[i] == line[i+2])
                                between = 1;
                }

                if (pair && between) {
                        printf("nice    %s", line);
                        num_nice++;
                } else {
                        printf("naughty %s", line);
                }
        }

        printf("%d were nice\n", num_nice);

        return 0;
}
