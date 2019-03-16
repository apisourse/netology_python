list_animal = []
sum_weight_all_Animals = list()
class Animals:
	count = 1
	feed = 3
	def __init__(self, value=feed):
		self.feed = value
	def __init__(self):
		self.weight_class = self.weight * self.count_class
		list_animal.append([self.name_class, self.weight_class])
	def collect_stuff(self):
		sum_weight_all_Animals.append(self.weight_class)
	def __str__(self):
		return self.name

class Goos(Animals):
	name_class = 'Овцы'
	count_class = 2
	weight = 15 #kg среднее в классе

class Cow(Animals):
	name_class = 'Коровы'
	count_class = 1
	weight = 150 #kg среднее в классе
	milk = 10
	def milk_m(self):
		self.milk += 5 #l/d предположим, что корова дает каждый день по 15 литров молока, но если постараться, может и еще пяток =))

class Sheep(Animals):
	name_class = 'Овцы'
	count_class = 2
	weight = 50 #kg среднее в классе
	tonsure = 1 # kg/w
	def tonsure_m(self):
		self.tonsure += 0.5 #kg/w предположим, что каждая овца дает 1 кг шерсти в неделю, но если постараться, может и еще пол килограмчика скинуть =))

class Chicken(Animals):
	name_class = 'Курицы'
	count_class = 2
	weight = 5 #kg среднее в классе
	eggs = 0 #egg/d
	def eggs_m(self, feed):
		self.eggs += feed #шт. предположим, что каждая курица дает 1 яйцо в день, но если кормить почаще, то может и больше =))

class Goat(Animals):
	name_class = 'Козы'
	count_class = 2
	weight = 10 #kg среднее в классе

class Duck(Animals):
	name_class = 'Утки'
	count_class = 1
	weight = 20 #kg среднее в классе


goos_white = Goos()
goos_white.name = 'Белый'
print(goos_white)
#
goos_grey = Goos()
goos_grey.name = 'Серый'
print(goos_grey)
#
cow_manka = Cow()
cow_manka.name = 'Манька'
cow_manka.milk_m() #постараться
print(cow_manka)
#
sheep_barashek = Sheep()
sheep_barashek.name = 'Барашек'
print(sheep_barashek)
sheep_kudryaviy = Sheep()
sheep_kudryaviy.name = 'Кудрявый'
sheep_kudryaviy.tonsure_m() #постараться
print(sheep_kudryaviy)
#
chicken_koko = Chicken()
chicken_koko.name = 'КоКо'
print(chicken_koko)
chicken_kukareku = Chicken()
chicken_kukareku.name = 'Кукареку'
chicken_kukareku.eggs_m(4)
print(chicken_kukareku)
print(chicken_kukareku.__dict__)
#
goat_roga = Goat()
goat_roga.name = 'Рога'
print(goat_roga)
#
goat_kopyta = Goat()
goat_kopyta.name = 'Копыта'
print(goat_kopyta)
#
duck_krykva = Duck()
duck_krykva.name = 'Кряква'
print(duck_krykva)
print('-------------------------')

goos_all = Goos()
goos_all.collect_stuff()
cow_all = Cow()
cow_all.collect_stuff()
sheep_all = Sheep()
sheep_all.collect_stuff()
chicken_all = Chicken()
chicken_all.collect_stuff()
goat_all = Goat()
goat_all.collect_stuff()
duck_all = Duck()
duck_all.collect_stuff()

dict_animal = dict(list_animal)


#for k, v in dict_animal.items():
#	print(k, ':', v, 'kg')
#	sum_weight_all_Animals.append(v)
print('Сумма веса всех животных:', sum(sum_weight_all_Animals), 'kg')

inverse = [(value, key) for key, value in dict_animal.items()]
print (max(inverse)[1], '- в сумме, самые тяжелые животные среди классов')