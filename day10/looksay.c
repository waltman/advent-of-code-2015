#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct node {
        int val;
        struct node *next;
};

void append_node(struct node *np, int val);
void free_list(struct node *head);
int print_list(struct node *head);

int main(int argc, char *argv[]) {
        char *input;
        int iterations;
        int i;
        struct node *in_head, *in_tail;
        int len;

        if (argc != 3) {
                fprintf(stderr, "Usage: looksay input iterations\n");
                return 1;
        }

        input = argv[1];
        iterations = atoi(argv[2]);
        printf("0\t%s\n", input);

        /* set up input list for the initial value */
        in_head = (struct node *) malloc(sizeof(struct node));
        in_head->val = -1;
        in_tail = in_head;
        for (i = 0; i < strlen(input); i++) {
                append_node(in_tail, input[i] - '0');
                in_tail = in_tail->next;
        }

        for (i = 1; i <= iterations; i++) {
                struct node *out_head = (struct node *) malloc(sizeof(struct node));
                out_head->val = -1;
                out_head->next = NULL;
                struct node *out_tail = out_head;

                in_tail = in_head->next;
                int last = in_tail->val;
                int cnt = 0;
                in_tail = in_head->next;
                while (in_tail != NULL) {
                        int c = in_tail->val;

                        if (c == last) {
                                cnt++;
                        } else {
                                append_node(out_tail, cnt);
                                out_tail = out_tail->next;
                                append_node(out_tail, last);
                                out_tail = out_tail->next;

                                last = c;
                                cnt = 1;
                        }
                        in_tail = in_tail->next;
                }
                append_node(out_tail, cnt);
                out_tail = out_tail->next;
                append_node(out_tail, last);
                out_tail = out_tail->next;

                printf("%d\t", i);
                len = print_list(out_head);

                free_list(in_head);
                in_head = out_head;
        }

        printf("\nfinal length = %d\n", len);
        free_list(in_head);
}

void append_node(struct node *np, int val) {
        struct node *new_node = (struct node *) malloc(sizeof(struct node));
        new_node->val = val;
        new_node->next = NULL;
        np->next = new_node;
}

void free_list(struct node *head) {
        while (head != NULL) {
                struct node *np = head->next;
                free(head);
                head = np;
        }
}

int print_list(struct node *head) {
        int len = 0;
        while (head != NULL) {
                if (head->val != -1) {
                        printf("%d", head->val);
                        len++;
                }
                head = head->next;
        }
        printf("\n");
        return len;
}
