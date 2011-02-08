struct nodes {
	int data;
	struct node_list *next;
};

node insert_node(node list, int data){
	node new_node = (node) malloc(sizeof(struct nodes));
	new_node->data = data;
	new_node->next = list->next;
	list->next     = new_node;
	return new_node;
}

node delete_node(node list){
	node tmp   = list->next;
	list->next = list->next->next;
	free(tmp);
	return list;
}
