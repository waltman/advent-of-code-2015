#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#define MAX_LEN 100

int hex2num(char *h);
int hexval(char c);

int main (int argc, char *argv[]) {
        FILE *fp;
        char line[MAX_LEN];
        char tmp[MAX_LEN];
        int num_nice = 0;

        if (argc != 2) {
                fprintf(stderr, "Usage: matchsticks <file>\n");
                return 1;
        }

        if ((fp = fopen(argv[1], "r")) == NULL) {
                perror(argv[1]);
                return 1;
        }

        int total_diff = 0;
        while (fgets(line, MAX_LEN, fp) != NULL) {
                int len = (int) strlen(line);
                int code_len = len - 1;
                int i, cnt;
                int diff;

                printf("%s", line);

                /* remove trailing newline */
                line[len-1] = '\0';
                len--;

                /* remove outer quotes */
                strncpy(tmp, line+1, len-2);
                tmp[len-2] = '\0';
                strcpy(line, tmp);
                len -= 2;
                /* printf("quotes removed: %s, len = %d\n", line, len); */

                /* escapes */
                cnt = 0;
                for (i = 0; i < len; i++) {
                        if (line[i] == '\\' && i < len-1) {
                                switch (line[i+1]) {
                                case '\\' :
                                case '"' :
                                        tmp[cnt++] = line[i+1];
                                        i++;
                                        break;
                                default :
                                        tmp[cnt++] = '\\';;
                                        break;
                                }
                        } else {
                                tmp[cnt++] = line[i];
                        }
                }
                tmp[cnt] = '\0';
                strcpy(line, tmp);
                len = cnt;
                /* printf("escapes removed: %s, len = %d\n", line, len); */

                /* hex escape */
                cnt = 0;
                for (i = 0; i < len; i++) {
                        if (i < len-3 && line[i] == '\\'
                            && line[i+1] == 'x'
                            && ishexnumber(line[i+2])
                            && ishexnumber(line[i+3])) {
                                int ascii = hex2num(line+i+2);
                                tmp[cnt++] = ascii;
                                i += 3;
                        } else {
                                tmp[cnt++] = line[i];
                        }
                }
                tmp[cnt] = '\0';
                strcpy(line, tmp);
                len = cnt;
                /* printf("hex removed: %s, len = %d\n", line, len); */

                diff = code_len - len;
                total_diff += diff;
                printf("diff = %d\n", diff);
        }

        printf("total diff = %d\n", total_diff);

        return 0;
}

int hexval(char c) {
        if (c >= '0' && c <= '9') {
                return c - '0';
        } else if (c >= 'a' && c <= 'f') {
                return c - 'a' + 10;
        } else if (c >= 'A' && c <= 'F') {
                return c - 'A' + 10;
        } else {
                fprintf(stderr, "bad hex char: %c\n", c);
                exit(1);
        }
}

int hex2num(char *h) {
        return hexval(h[0]) * 16 + hexval(h[1]);
}
