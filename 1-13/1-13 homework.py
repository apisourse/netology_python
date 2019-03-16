#Логика:
# - Понять сколько и с каким названием и расширением есть файлов в папке для перевода (подготовить к циклу
# - Обработать в цикле отфильтрованную заданную дирректорию:
#	-- Открыть каждый файл на чтение
#	-- Получить текст
#	-- Получить язык для записи в ключ переводчика
#	-- Прогнать через функцию переводчика
#	-- Записать переведенный текст в файл

import os
import requests
from langdetect import detect
import shutil

lang_translate_ru = 'ru' #Переводим только на русский язык
prefix_to_file = 'translate_' #Префикс переведенного файла на выходе
migrations_directory = 'files' #Входная дирректория для перевода.
result_directory = input('Введите название папки с результатом переводов: ') #Дирректория для вывода перевода.

def main():
	for files_translations in searchfiles(): # Прокатимся по списку файлов отфильтрованных в функции searchfiles
		with open(files_translations) as f:
			text_for_translate = f.read() #Открываем весь файл и забираем все как есть
	#		print(text_for_translate) #ПРОВЕРЯЕМ что забрали
			lang = detect(text_for_translate) #Определяем язык перевода
	#		print(lang) #ПРОВЕРЯЕМ какой язык определился
			export = translate(text_for_translate, lang)
	#		print(export) #ПРОВЕРЯЕМ что перевелось
		print('Найден файл для перевода:', files_translations)
		with open(prefix_to_file + files_translations, 'w') as fr:
			fr.write(export)
		print('Перевод записан в:', os.getcwd() + '/' + shutil.move(prefix_to_file + files_translations, result_directory))
		print('---------------------')
#
def searchfiles(): # Определяем какие фйлы из папки будем переводить
	search_files = list()
	s_expansion = 'txt' #Переводим только txt файлы
	os.chdir(migrations_directory) #полная дирректория для перевода
	print('Ищем в директрии: ' + os.getcwd()) #ПРОВЕРЯЕМ откуда берем
	print('---------------------')
	file_name = os.listdir(path=".")
	os.mkdir(result_directory) #Создаем дирректорию для результата
	for line_file_name in file_name: # Прокатимся по списку файлов
		if s_expansion in line_file_name:
			search_files.append(line_file_name) # Запишем в список, если расширение txt
#	print(search_files) #ПРОВЕРЯЕМ список и вернем его
	return search_files

def translate(text_for_translate, lang):
	url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
	key = 'trnsl.1.1.20161025T233221Z.47834a66fd7895d0.a95fd4bfde5c1794fa433453956bd261eae80152'
	
	params = {
		'key': key,
		'lang' : lang + '-' + lang_translate_ru,
		'text' : text_for_translate,
	}
	response = requests.post(url, params=params, timeout=30).json()
	return ' '.join(response.get('text', [])) #Раскрашиваем вывод

if __name__ == '__main__':
	main()
	print('Отработало')