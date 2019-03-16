documents = [
				{"type": "passport", "number": "2207 876234", "name": "Василий Гупкин"},
				{"type": "invoice", "number": "11-2", "name": "Геннадий Покемонов"},
				{"type": "insurance", "number": "10006", "name": "Аристарх Павлов"}
			]

directories = {
				'1': ['2207 876234', '11-2'],
				'2': ['10006'],
				'3': ['']
			}

print('p – узнать владельца по номеру документа.')
print('l – список всех документов.')
print('s – узнать номер полки хранения по номеру документа.')
print('a – добавить новый документ в каталог и в перечень полок.')

print('d – команда удалит документ из каталога и из перечня полок.')
#print('m – команда переместит документ на другую полку.')
#print('as – команда добавит новую полку.')
print('-----------------')

commands = str(input('Введите команду: '))

#p – people – команда, которая спросит номер документа и выведет имя человека, которому он принадлежит;
def people(commands):
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
				
#l– list – команда, которая выведет список всех документов в формате passport "2207 876234" "Василий Гупкин";
def list_ex(commands, default='Отработало'):
	for data in documents:
		data_tuple = data['type'], data['number'], data['name']
		print(data_tuple[0], data_tuple[1], data_tuple[2])
	return default

#s – shelf – команда, которая спросит номер документа и выведет номер полки, на которой он находится;
def shelf(commands):
	num_doc = str(input('Введите номер документа, чтобы узнать на какой полке он находится: '))
	for k, v in directories.items():
		if num_doc in v:
			continue
		else:
			export = 'Номер не найден'
	for k, v in directories.items():
		if num_doc in v:
			export = 'Возьмите документ на полке №: {}'.format(k)
	return export
#a – add – команда, которая добавит новый документ в каталог и в перечень полок, спросив его номер, тип, имя владельца и номер полки, на котором он будет храниться.
def add(commands):
	num_doc = str(input('Введите номер документа: '))
	type_doc = str(input('Введите тип документа: '))
	name_doc = str(input('Введите имя владельца: '))
	num_shelf = str(int(input('Введите номер полки хранения: ')))
	documents.append({"type": type_doc, "number": num_doc, "name": name_doc})
	if num_shelf not in directories.keys():
		directories.setdefault(num_shelf, list())
		directories[num_shelf].append(num_doc)
	else:
		directories[num_shelf].append(num_doc)
	print(documents)
	print(directories)
	return 'Новая запись добавлена в каталог'

#d – delete – команда, которая спросит номер документа и удалит его из каталога и из перечня полок;
def delete(commands):
	num_doc = str(input('Введите номер документа: '))
	for dict_doc in documents:
		if num_doc in dict_doc['number']:
			continue
		else:
			export = 'Номер не найден'
		if num_doc == dict_doc['number']:
			del dict_doc
			continue
		print(dict_doc)
	for v in directories.values():
		if num_doc in v:
			v.remove(num_doc)
			export = 'Документ удален'
		print(v)
	return export
		
###m – move – команда, которая спросит номер документа и целевую полку и переместит его с текущей полки на целевую;
#def move(commands):
#	num_doc = str(input('Введите номер документа: '))
#	num_shelf = str(int(input('Введите номер полки для перемещения: ')))
#	for k, v in directories.items():
#		if num_doc in v:
#			v.remove(num_doc)
#		elif num_shelf not in k:
#			print('not in k')
#			directories.setdefault(num_shelf, list())
#			directories[num_shelf].append(num_doc)
#	print(directories)
##	for item in documents:

##as – add shelf – команда, которая спросит номер новой полки и добавит ее в перечень;
#def add_shelf (commands):
	
if commands.lower() == 'p':
	print(people(commands))
elif commands.lower() == 'l':
	print(list_ex(commands))
elif commands.lower() == 's':
	print(shelf(commands))
elif commands.lower() == 'a':
	print(add(commands))
elif commands.lower() == 'd':
	print(delete(commands))
else:
	print('error')
