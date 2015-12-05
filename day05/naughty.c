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
                int vowels;
                int doub;
                int special;
                int i, j, k;
                size_t len = strlen(line);

                /* look for 3 vowels */
                int num_vowels = 0;
                for (i = 0; i < len; i++) {
                        char c = line[i];
                        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                                num_vowels++;
                                if (num_vowels >= 3)
                                        break;
                        }
                }
                vowels = (num_vowels >= 3) ? 1 : 0;

                /* look for double letters */
                doub = 0;
                for (i = 0; !doub && i < len - 1; i++) {
                        if (line[i] == line[i+1])
                                doub = 1;
                }

                /* look for special strings */
                special = 0;
                for (i = 0; !special && i < len - 1; i++) {
                        if (strncmp(line+i, "ab", 2) == 0 ||
                            strncmp(line+i, "cd", 2) == 0 ||
                            strncmp(line+i, "pq", 2) == 0 ||
                            strncmp(line+i, "xy", 2) == 0) 
                                special = 1;
                }

                if (vowels && doub && !special) {
                        printf("nice    %s", line);
                        num_nice++;
                } else {
                        printf("naughty %s", line);
                }
        }

        printf("%d were nice\n", num_nice);

        return 0;
}
