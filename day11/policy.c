#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void increment(char *pw, size_t pw_len);

int main(int argc, char *argv[]) {
        if (argc != 2) {
                fprintf(stderr, "Usage: policy pw\n");
                return 1;
        }

        size_t pw_len = strlen(argv[1]);
        char *pw = (char *) malloc(pw_len + 1);
        strcpy(pw, argv[1]);
        int n = 0;

        while (1) {
                int i, j;
                int found;

                n++;

                /* invalid letters */
                found = 0;
                for (i = 0; !found && i < pw_len; i++) {
                        if (pw[i] == 'i' || pw[i] == 'l' || pw[i] == 'o') {
                                found = 1;
                        }
                }
                if (found) {
                        increment(pw, pw_len);
                        continue;
                }

                /* triplets */
                found = 0;
                for (i = 0; !found && i < pw_len-2; i++) {
                        if (pw[i] + 1 == pw[i+1] && pw[i] + 2 == pw[i+2]) {
                                found = 1;
                        }
                }
                if (!found) {
                        increment(pw, pw_len);
                        continue;
                }

                /* pairs */
                found = 0;
                for (i = 0; !found && i < pw_len - 3; i++) {
                        if (pw[i] == pw[i+1]) {
                                for (j = i+2; !found && j < pw_len - 1; j++) {
                                        if (pw[j] != pw[i] && pw[j] == pw[j+1]) {
                                                found = 1;
                                        }
                                }
                        }
                }
                if (!found) {
                        increment(pw, pw_len);
                        continue;
                }

                /* if we make it here, we found the next pw! */
                break;
        }

        printf("next password is %s found after %d iterations\n", pw, n);
        return 0;
}

void increment(char *pw, size_t pw_len) {
        int i = pw_len - 1;
        int done = 0;

        while (!done) {
                if (i < 0) {
                        fprintf(stderr, "Uh oh, I can't increment pw anymore!\n");
                        exit(1);
                }

                switch(pw[i]) {
                case 'h':
                case 'k':
                case 'n':
                        pw[i] += 2;
                        done = 1;
                        break;
                case 'z':
                        pw[i] = 'a';
                        i--;
                        break;
                default:
                        pw[i]++;
                        done = 1;
                        break;
                }
        }
}
