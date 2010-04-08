class EmptyStackException(Exception):
	pass

class Element:
	def __init__(self, value, next):
		self.value = value
		self.next = next

class Stack:
	def __init__(self):
		self.head = None

	def push(self, element):
		self.head = Element(element, self.head)

	def pop(self):
		if self.empty(): raise EmptyStackException
		result = self.head.value
		self.head = self.head.next
		return result

	def empty(self):
		return self.head == None


if __name__ == "__main__":
	
	stack = Stack()
	elements = ["map3", "map2", "map1", "map0"]
	for e in elements:
		stack.push(e)
		print e

	result = []
	while not stack.empty():
		result.append(stack.pop())
		print result
	assert result == ["map0", "map1", "map2", "map3"]	
