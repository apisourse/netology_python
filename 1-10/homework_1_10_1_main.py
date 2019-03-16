import os

def searchfunc():
	migrations_directory = 'Migrations'
	os.chdir(migrations_directory)
	print('Ищем в директрии: ' + os.getcwd())
	count = 0
	quick_search = list()
	search = list()
	search_dir = list()
	search_dir.append(os.listdir(path="."))
	s_expansion = 'sql'

	while True:
		s_text = input('Введите чать текста в файле:')
		for line in search_dir[0]:
			try: 
				with open(line, "r", encoding="utf-8") as my_file:
					content = my_file.read()
			except UnicodeDecodeError:
				continue
			if s_expansion in line and s_text in content:
				search.append(line)
				count +=1
		quick_search.clear()
		for dir_list in search:
			print(dir_list)
			quick_search.append(dir_list)
		print('Всего:', count)
		search.clear()
		search_dir.clear()
		search_dir.append(quick_search)
		
		count = 0
		
print(searchfunc())