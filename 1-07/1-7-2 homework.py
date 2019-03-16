documents = [
				{"type": "passport", "number": "2207 876234", "name": "Василий Гупкин"},
				{"type": "invoice", "number": "11-2"},
				{"type": "insurance", "number": "10006", "name": "Аристарх Павлов"}
			]

directories = {
				'1': ['2207 876234', '11-2'],
				'2': ['10006'],
				'3': ['']
			}

print('n – выводит имена всех владельцев документов и производит поиск по документам.')
print('-----------------')

commands = str(input('Введите команду: '))

def names(commands):
	for number in documents:
		try:
			number['name']
		except KeyError:
			print('Warning: Имя отсутсвует')
			continue
		print(number['name'])
	try:
		num_doc = str(input('Введите номер документа, чтобы получить имя человека, которому он принадлежит: '))
		for number in documents:
			if num_doc in number['number']:
				continue
			else:
				export = 'Номер не найден'
		for number in documents:
			if num_doc == number['number']:
				export = 'Владелец номера: {}'.format(number['name'])
		return export
	except KeyError:
		export = 'Warning: {} не обнаружил владельца документа'.format(num_doc)
		return export

if commands.lower() == 'n':
	print(names(commands))
else:
	print('error')