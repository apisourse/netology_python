import csv

flats_list = list()

with open('output.csv', newline='') as csvfile:
	flats_csv = csv.reader(csvfile, delimiter=';')
	flats_list = list(flats_csv)

#можете посмотреть содержимое файла с квартирами через print, можете - на вкладке output.csv
#print (flats_list)

header = flats_list.pop(0)
#print(header)

## TO-DO 1:
## Напишите цикл, который проходит по всем квартирам, и показывает только новостройки и их порядковые номера в файле. 
## Подсказка - вам нужно изменить этот код:
for num, flat in enumerate(flats_list):
	id_new_building = int(flat[0])
	new_building = flat[2].lower()
	if new_building == 'новостройка' in flat:
		print('Num: {}. ID: {} - {}.'.format(num+1, id_new_building , new_building))

print('-------------------------')
##TO-DO 2:
## 1) Сделайте описание квартиры в виде словаря, а не списка. 
## Используйте следующие поля из файла output.csv: ID, Количество комнат;Новостройка/вторичка, Цена (руб). У вас должно получиться примерно так:
##	flat_info = {"id":flat[0], "rooms":flat[1], "type":flat[2], "price":flat[11]}
	
for flat_l in flats_list:
	flat_ld = [['id',flat_l[0]], ['rooms', flat_l[1]], ['type', flat_l[2]], ['price', flat_l[11]]]
	flat_d = dict(flat_ld)
	print('{}'.format(flat_d))

print('-------------------------')
## 2) Измените код, который создавал словарь для поиска квартир по метро так, чтобы значением словаря был не список ID квартир, а список описаний квартир в виде словаря, который вы сделали в п.1 
subway_dict = dict()
for flat in flats_list:
	flat_ld = [['id',flat[0]], ['rooms', flat[1]], ['type', flat[2]], ['price', flat[11]]]
	flat_d = dict(flat_ld)
	subway = flat[3].replace('м.', '')
	if subway not in subway_dict.keys():
		subway_dict[subway] = list()
	subway_dict[subway].append(flat_d)
print(subway_dict)

print('-------------------------')
### 3) Самостоятельно напишите код, который подсчитывает и выводит, сколько квартир нашлось у каждого метро.

subway_dict = dict()
for flat in flats_list:
	subway = flat[3].replace("м.", "")
	subway_dict.setdefault(subway, list())
	subway_dict[subway].append(flat[0])
for key, value in subway_dict.items():
	print('{} - {} квартир'.format(key ,len(value)))