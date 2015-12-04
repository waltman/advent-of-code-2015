#include <stdio.h>
#include <stdlib.h>

struct node {
        int x;
        int y;
        struct node *left;
        struct node *right;
};

void add_node(struct node **tree, int x, int y);
int num_nodes(struct node *tree);
int comp_node(struct node *n, int x, int y);
struct node *new_node(int x, int y);
void free_tree(struct node *tree);
int max(int a, int b);
int height(struct node *tree);

int main(int argc, char *argv[]) {
        int c;
        int x = 0;
        int y = 0;
        struct node *tree = NULL;

        printf("at beginning, num nodes = %d\n", num_nodes(tree));
        add_node(&tree, x, y);
        printf("after initialization, num nodes = %d\n", num_nodes(tree));
        while ((c = getchar()) != EOF) {
                if (c == '>') {
                        x++;
                } else if (c == '<') {
                        x--;
                } else if (c == '^') {
                        y++;
                } else if (c == 'v') {
                        y--;
                }
                add_node(&tree, x, y);
        }

        printf("at end, num nodes = %d\n", num_nodes(tree));
        printf("height = %d\n", height(tree));
        free_tree(tree);
        return 0;
}

void add_node(struct node **tree, int x, int y) {
        if (*tree == NULL) { /* empty tree */
                *tree = new_node(x, y);
        } else {
                struct node *n = *tree;
                while (1) {
                        int result = comp_node(n, x, y);
                        if (result == -1) {
                                if (n->left == NULL) {
                                        n->left = new_node(x, y);
                                        break;
                                } else {
                                        n = n->left;
                                }
                        } else if (result == 1) {
                                if (n->right == NULL) {
                                        n->right = new_node(x, y);
                                        break;
                                } else {
                                        n = n->right;
                                }
                        } else {
                                break;
                        }
                }
        }

}

int num_nodes(struct node *tree) {
        int n = 0;

        if (tree == NULL)
                return 0;
        else
                return 1 + num_nodes(tree->left) + num_nodes(tree->right);
}

int comp_node(struct node *n, int x, int y) {
        if (x < n->x) {
                return -1;
        } else if (x > n->x) {
                return 1;
        } else if (y < n->y) {
                return -1;
        } else if (y > n->y) {
                return 1;
        } else {
                return 0;
        }
}

struct node *new_node(int x, int y) {
        struct node *n = (struct node*) malloc(sizeof(struct node));
        n->x = x;
        n->y = y;
        n->left = NULL;
        n->right = NULL;

        return n;
}

void free_tree(struct node *tree) {
        if (tree != NULL) {
                free_tree(tree->left);
                free_tree(tree->right);
                free(tree);
        }
}

int max(int a, int b) {
        return (a > b) ? a : b;
}

int height(struct node *tree) {
        if (tree == NULL)
                return 0;
        else
                return 1 + max(height(tree->left), height(tree->right));
}
