expression = input('Введите выражение:')
expression_list = expression.split()
print(expression_list)

assert int(expression_list[1]) > 0 and int(expression_list[2]) > 0, 'число должно быть положительным'
try:
	if expression_list[0] == '+':
		export = (int(expression_list[1]) + int(expression_list[2]))
	elif expression_list[0] == '-':
		export = (int(expression_list[1]) - int(expression_list[2]))
	elif expression_list[0] == '*':
		export = (int(expression_list[1]) * int(expression_list[2]))
	elif expression_list[0] == '/':
		export = (int(expression_list[1]) / int(expression_list[2]))
	print(export)
except NameError as error:
	print('Warning: {}'.format(error))
except ZeroDivisionError as error:
	print('Warning: {}'.format(error))

