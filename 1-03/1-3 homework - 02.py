#Имеется структура данных cook_book, где ключами являются блюда, а значениями - списки, содержащие информацию об ингридиентах блюда и их количестве в граммах в расчете на одну порцию:
cook_book = {
	'салат':  
			[
				['картофель', 100],
				['морковь ', 50],
				['огурцы', 50],
				['горошек', 30],
				['майонез', 70],
			],
	'пицца':  
			[
				['сыр', 50],
				['томаты', 50],
				['тесто', 100],
				['бекон', 30],
				['колбаса', 30],  
			],
	'фруктовый десерт':
			[
				['хурма', 60],
				['киви', 60],
				['творог', 60],
				['сахар', 10],
				['мед', 50],  
			]
}

person = 3

#Необходимо вывести пользователю список покупок необходимого количества ингридиентов для приготовления блюд на определенное число персон.
for i_key, i_value in cook_book.items():
	print('----------')
	print('>>> Блюдо :', i_key)
	for j_key, j_value in i_value:
		j_value_3 = j_value * person
		print(j_key, '-', j_value_3, 'гр.')
print('----------')
print('Вперед за покупками!')