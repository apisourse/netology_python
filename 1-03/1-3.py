
my_integer = 10
my_float = 5.5
my_string = 'Hellow World'
my_string = "Hellow World"
My_bool = True
My_bool = False

#type - узнать/вывести тип данных
print(type(my_integer))
print(type(my_float))
print(type(my_string_1))
print(type(my_string_2))
print(type(my_bool_1))
print(type(my_bool_2))

#типы данных существуют:
int() #integer - целые числа 
float() #float - числа с плавающей точкой
str() #string - строка/текст
bool() #boolean - булевый/логический тип

print(type(my_float)) #type - узнать/вывести тип данных

################ Строка ################
#Преобразование значения строки методы/функции
print(my_string.upper()) #привести к верхнему регистру
print(my_string.lower()) #привести к нижнему регистру
print(my_string.capitalize()) #заглавная только первая буква
print(my_string.replace('Hellow', 'Goodbye')) #заменить первое значение на второе



################ Списки [] ################
month_list = [
    'Jan', 
    'Feb', 
    'Mar', 
    'Apr'
]
income_list = [
    1000, 
    2000, 
    3000, 
    4000,
]
income_by_month = [
    ['Jan', 1000], 
    ['Feb', 2000], 
    ['Mar', 3000], 
    ['Apr', 4000]
]

#Манипуляции со списками
del(list_name[index]) #удаляет элемент из списка по индексу. Это функция и она требует аргумента

.remove(el) #удаляет указанный элемент из списка по вхождению #это метод и он применяется к переменной
month_list.remove('Mar')

.append(el) #позволяет добавить элемент в список #это метод и он применяется к переменной
month_list.append('Des')

.count(el) #считает количество вхождений элемента в список #это метод и он применяется к переменной
month_list.count('Jan')

.index(el) #позволяет узнать индекс элемента в списке по вхождению #это метод и он применяется к переменной
month_list.index('Mar')

.reverse() #разворачивает список в обратную сторону #это метод и он применяется к переменной
month_list.reverse()

#[Индексация элементов в списках]
""" 
Индексация элементов начинается с нуля.
Получить значение элемента по индексу можно при помощи [ ], например: numbers[0] и numbers[-5] вернет 2.
Можно “доставать” из списка сразу несколько значений при помощи “срезов” (slicing). Для указания интервала среза
"""
# пример срезов (slice)
print(var[0:]) # верни значение от 0го до последнего
print(var[:3]) # верни значение с самого начало до 3го



################ Словари {} ################
# все ключи уникальные, иначе ошибка
# запись в {}, а вывод в []
# запись как ключ:занчение {key:value} #только не изменяемые типы данных
# ключами могу быть все типы данных

#одноуровневый словарь
month_list_dict = {
    'Artem': 1200,
    'Lise': 1400,
    'Miles': 1600,
    'Lusi': 1800
}
#многоуровневый словарь
month_list_dict_in_dict = {
    'Artem_P': {'age': 32, 'cost': 2000},
    'Artem_G': {'age': 30, 'cost': 2200},
    'Artem_S': {'age': 31, 'cost': 1500},
}

#Обращаемся к словарю
print(month_list_dict['Artem']) #получаем значение по ключу в одноуровневом словаре
print(month_list_dict_in_dict['Artem']['cost']) #получаем значение по ключу в многоуровневом словаре

month_list_dict['Oleg'] = 2000 #добавляем/изменяе значение в одноуровневый словарь
month_list_dict_in_dict['Artem']['cost'] = 3000 #добавляем/изменяе значение в многоуровневый словарь
#!!!Важно. Если ключа найден в словаре, то перезапишет. Если не найден, то добавит.

#Манипуляции со словарями
del(dict[key]) #удаляет элемент из списка по ключу
.keys() #позволяет получить все ключи словаря
print(month_list_dict_in_dict.keys())

.values() #позволяет получить все значения словаря
print(month_list_dict_in_dict.values())

.items() #позволяет получить ключи и значения словаря
print(month_list_dict_in_dict.items())

.get(key) #“безопасно” возвращает значение по ключу (при отсутствии ключа ошибка не возникает) #при ошибке(отсутсвии) значения возвращает none
print(month_list_dict_in_dict.get('Artem_P'))


################ Кортежи () - неизменяемые списки ################
#поддерживаются все операции(функции) как и со списками, кроме добавления и удаления элементов из картежа

#Особая функция
.zip(list_01, list_02)
#берёт на вход несколько списков и создаёт из них специальный zip-объект, состоящий из кортежей, такой, что первый элемент полученного объекта содержит кортеж из первых элементов всех списков-аргументов.

# пример
month_list = [
    'Jan', 
    'Feb', 
    'Mar', 
    'Apr'
]
income_list = [
    1000, 
    2000, 
    3000, 
    4000,
]
var = zip(month_list, income_list) #другими словами, архивируем
print(var)
#Получим:
<zip object at 0x7f3626d74e88>
# а если:
print(list(var)) #разархивируем
#То получим: список из картежей
[('Jan', 1000), ('Feb', 2000), ('Mar', 3000), ('Apr', 4000)] - #кортежи внутри списка ;)


################ Множества (set)(контейнер) - случайный порядок не повторяющихся элементов ################
# выводятся из списков
# инициализируется при помощи set()

#пример
data_scientists_skills = set(['Python', 'R', 'SQL', 'Tableau', 'SAS', 'Git']) #при помощи set превращаем списки в множество
data_engineer_skills = set(['Python', 'Java', 'Scala', 'Git', 'SQL', 'Hadoop']) #при помощи set превращаем списки в множество

#Манипуляции над множествами
.add(el) #добавляет элемент в множество
data_scientists_skills.add('HTML')
print(data_scientists_skills)

.update(set) #соединяет множество с другим множеством/списком


.discard(el) #удаляет элемент из множества по его значению
data_scientists_skills.discard('Python')
print(data_scientists_skills)

.union(set) #объединяет множества (логическое “ИЛИ”)
print(data_scientists_skills.union(data_engineer_skills))
print(data_scientists_skills | data_engineer_skills)

.intersection(set) #пересечение множеств (логическое “И”)
print(data_scientists_skills.intersection(data_engineer_skills))
print(data_scientists_skills & data_engineer_skills)

.difference(set) #возвращает элементы одного множества, которые не принадлежат другому множеству (разность множеств)
print(data_scientists_skills.difference(data_engineer_skills))
print(data_scientists_skills - data_engineer_skills)

.symmetric_difference(set) #возвращает элементы, которые встречаются в одном множестве, но не встречаются в обоих
print(data_scientists_skills.symmetric_difference(data_engineer_skills))
print(data_scientists_skills ^ data_engineer_skills)



################ Циклы while ################
# Цикл будет повторяться до тех пор, пока значение условия выполнения цикла не достигнет False

#пример
# пока x не равен 0, выполнять операция x -= 1
x = 5
while x != 0:
    x -= 1
    print(x)

#пример 1
x = 7
while x != 0:
    if x % 2 == 0:
        print(x, '- четное число')
        x -= 1
    else:
        print(x, '- не четное число')
        x -= 1

#пример 1 или
x = 7
while x != 0:
    if x % 2 == 0:
        print(x, '- четное число')
    else:
        print(x, '- не четное число')
    x -= 1


################ Циклы for ################
#Цикл for проходится по элементам любого итерируемого объекта (строки, списка, словаря и т.д.) и во время каждого прохода выполняет заданную последовательность действий.

# можно расшифровать так: 
# для элемента el в списке list
    # применить действие
    # вывести
    
#пример
company = 'Apple'
for letter in company:
    letter = letter.capitalize()
    print(letter)

#Еще примеры в использовании:
salaries = {
    'Artem': 1200,
    'Lise': 1400,
    'Miles': 1600,
    'Lusi': 1800
}
print('Artem salaries: ', salaries['Artem'])
print('Lise salaries: ', salaries['Lise'])
print('Miles salaries: ', salaries['Miles'])
print('Lusi salaries: ', salaries['Lusi'])
# или можно сделать так
for person, salary in salaries.items():
    print(person, "'s salary: ", salary, sep='')