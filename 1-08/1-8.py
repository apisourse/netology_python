f = open('text.txt', 'r')
#print(f.read()) #Читаем файл целиком
#print(f.readline(), end='') #Читаем файл построчно. end='' - говорит что печатать вконце строки
for line in f:
	print(line.strip())

print(f'Файл закрыт перед close? {f.closed}')
f.close()
print('Файл закрыт после close? {}' .format(f.closed))

print('------------------------------------------------------------------')

#Вариант без написания close
#Есть менеджер контекста

with open('text.txt', 'r') as f: # with сам закрывает файл как только отработает
	for line in f:
		print(line.strip())
	print(f'В контексте файл закрыт? {f.closed}')
print(f'Файл закрыт после менеджера контента? {f.closed}') 


print('------------------------------------------------------------------')

result = []
#item_list = []
with open('grades.txt', 'r') as f:
	for line in f:
		grade = line.strip()
		rating = f.readline().strip() #так как файл хранит состояние, эта строчка будет уже читать вторую строку
		f.readline() #Это пустая строка и помещать ее в объект не требуется
#		print(grade, rating)
		# помещаем результат цыкла второй стройки в raiting_list
		rating_list = rating.split()
		#переводим строки внутри списка в int'ы
		int_rating_list = []
		for value in rating_list:
			int_rating_list.append(int(value))
#		int_rating_list = [int(i) for i in rating_list] #Альтернативня конструкция for
#		int_rating_list = list(map(int, rating_list)) #Альтернативня конструкция map. Применяем функцию ко всем объектам в списке
		avg_rating = sum(int_rating_list) / len(int_rating_list)
		item = (avg_rating, grade)
		result.append(item)
	best_results = max(result)
	best_rating, best_grate = best_results
	print('Лучший класс: {} со средним баллом {}'.format(best_grate, round(best_rating, 2)))
	
print('------------------------------------------------------------------')

from datetime import datetime
current_time = datetime.now()
current_time_str = '{}\n'.format(current_time)
print(current_time_str) 

#with open('text_write_1_8 homework.txt', 'w') as fw:
#	fw.write(current_time_str)
	
with open('text_write_1_8 homework.txt', 'a') as fa:
	fa.write(current_time_str)
