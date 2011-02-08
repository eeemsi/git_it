#include <stdlib.h>
#include <string.h>

struct node {
 int data;
 struct node * next;
};

struct node * node_new (struct node * list, int data) {
 struct node * ret = malloc(sizeof(struct node));
 struct node * prev = NULL;

 if ( ret == NULL )
  return NULL;

 memset(ret, 0, sizeof(*ret));
 ret->data = data;

 if ( list == NULL )
  return ret;

 while (list != NULL) {
  prev = list;
  list = list->next;
 }

 prev->next = ret;

 return ret;
}

void node_delete (struct node ** list, struct node * node) {
 struct node * cur  = NULL;
 struct node * prev = NULL;

 if ( node == NULL )
  return;

 // no list, free only the given node.
 if ( list == NULL || *list == NULL ) {
  free(node);
  return;
 }

 if ( *list == node ) {
  *list = node->next;
  free(node);
  return;
 }

 cur = *list;

 while (cur != NULL && cur != node) {
  prev = cur;
  cur  = cur->next;
 }

 // test if found at all.
 if ( cur != node )
  return;

 prev->next = node->next;

 free(node);
}
