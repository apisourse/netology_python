from pprint import pprint


def readingredients (dish_name, dish_count, cook_book, f):
	while dish_count > 0:
		cook_book.setdefault(dish_name, list())
		ingredients = f.readline().strip()
		if '|' in ingredients:
			ing = ingredients.split(' | ')
			cook_book[dish_name].append({'ingridient_name':ing[0], 'quantity':int(ing[1]), 'measure':ing[2]})
			dish_count -= 1

def readfile():
	cook_book = {}
	with open('cook_book.txt') as f:
		for line in f:
			dish_name = line.strip()
			dish_count = int(f.readline().strip())
			readingredients(dish_name, dish_count, cook_book, f)
			f.readline()
	pprint(cook_book) # проверяем массив
	return cook_book

#---------------------------------------------
# Вводные данные, любым путем попавшие в dishes
dishes = ['Запеченный картофель', 'Омлет', 'Фахитос', 'Утка по-пекински']
person_count = 2
#---------------------------------------------

def get_shop_list_by_dishes(dishes, person_count):
	var_cook_book = readfile()
	menu_ing_dict = {}
	for menu_list in dishes:
		if menu_list in var_cook_book:
			only_ingredients = var_cook_book[menu_list]
			for only_ingredients_str in only_ingredients:
				ifms_in = only_ingredients_str['ingridient_name']
				ifms_q = only_ingredients_str['quantity']
				ifms_m = only_ingredients_str['measure']				
				if ifms_in not in menu_ing_dict:
					menu_ing_dict[ifms_in] = {'measure': ifms_m, 'quantity': ifms_q * person_count}
				else:
					menu_ing_dict[ifms_in]['quantity'] += ifms_q * person_count
	return menu_ing_dict
	
if __name__ == '__main__':
	pprint(get_shop_list_by_dishes(dishes, person_count))