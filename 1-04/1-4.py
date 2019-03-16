	import csv

	flats_list = list()

	with open('output.csv', newline='') as csvfile:
		flats_csv = csv.reader(csvfile, delimiter=';')
		flats_list = list(flats_csv)

	# del flats_list[0]
	header = flats_list.pop(0)

	# print("Всего квартир: " + len(flats_list))
	print("Всего квартир: {}\n\nДоступные нам поля: {}".format(len(flats_list), header))
	# print(flats_list[0][11])

	# собираем станции метро из списка квартир
	subway_set = set()
	for i, flat in enumerate(flats_list):
		subway = flat[3].replace("м.", "")
		subway_set.add(subway)
		print("Обрабатываем квартиру №{}".format(i+1))
	print(subway_set)

	flats_dict = dict()
	for flat in flats_list:
		subway = flat[3].replace("м.", "")
		flats_dict.setdefault(subway, list())
		# if subway not in flats_dict.keys():
		#   flats_dict[subway] = list()
		flats_dict[subway].append(flat[0])
	print("Наши квартиры у всех метро:\n{}".format(flats_dict))
	print(len(flats_dict))

	# while True:
	#   user_input = input("Введите ваш бюджет. Если хотите выйти, введите Выход")
	#   if user_input.lower() == "выход":
	#     break
	#   # print(type(flats_list[0][11]))
	#   budget = int(user_input)
	#   count = 0
	#   for flat in flats_list:
	#     try:
	#       int(flat[1])
	#     except Exception as e:
	#       print("Ошибка в данных: {}".format(e))
	#       continue

	#     if int(flat[11]) <= budget and int(flat[1]) >=2:
	#       print("Идентификатор квартиры: {}, стоимость: {}".format(flat[0], flat[11]))
	#       count += 1
	#   print("Нам подходит {} квартир(ы)".format(count))