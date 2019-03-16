class Car:
#	pass #просто заглушка, если класс пустой, если не пустой, то писать не нужно
# Создаем атрибуты класса
	color = 'black'
	engine_volume = 1500
	year = 2018
	fuel = 0 #l
	position = 0
	speed = 0 #km/h
	status = 'stopped'
	coords = [0, 0, 0]
	price = 600000

# Создаем функции класса	
# self - как принадлежность к объектам/сущностьям, которых пока еще нет.
	
	def start(self):
		self.status = 'started'
		
	def stop(self):
		self.status = 'stopped'
		
	def accelerate(self, value):
		self.speed += value

	def move(self, h):
		self.position += self.speed * h
		self.fuel -= 10 * h #10 l/h
		
	def brake(self, value):
		self.speed -= value
		
Car_00 = Car()
Car_01 = Car()
Car_02 = Car()
Car_03 = Car()
Car_04 = Car()
# это разные объекты
# убедимся в этом через print
print('Car_01:', Car_01)
print('Car_02:', Car_02)
print('Car_03:', Car_03)
print('Car_04:', Car_04)

print('--------------------')

# Обращение к атрибуту или методу
print(Car_00.color)
print(Car_00.engine_volume)
print(Car_00.year)
print(Car_00.fuel)
print(Car_00.position)
print(Car_00.speed)
print(Car_00.status)

print('----------Как присвоить атрибут----------') #Вызывается или назначается без ()
Car_00.color = 'red'
Car_00.engine_volume = 2000
Car_00.year = 2019

print(Car_00.color)
print(Car_00.engine_volume)
print(Car_00.year)

print('----------Как вызвать функцию----------') # Вызывается или назначается с ()
Car_00.start()
Car_00.accelerate(30)
Car_00.move(15)

print(Car_00.status)
print(Car_00.speed)
print(Car_00.position)


print('----------Куда записывается----------')

print(Car_03.color)
print(Car_04.year)
print(Car_03.__dict__)
print(Car_04.__dict__)

Car_03.color = 'red'
Car_04.year = 2019

print(Car_03.color)
print(Car_04.year)
print(Car_03.__dict__)
print(Car_04.__dict__)

# __dict__ - куда записывается.

print(Car.__dict__) # Можно обратиться к классу как к объекту и вывести его словарик
# При выводе атрибута или функции объекла, сначала Python смотрит в словаре __dict__ этого объека, если не находит, то образается к классу.

print('----------Добавим новый атрибут не в class, а объекту----------')

Car_03.accelerate(50)
Car_03.lololo = 'ha-ha-ha'
print(Car_03.__dict__)

print('----------Списки в атрибуте класса и объекте----------')

print(Car_03.coords)
Car_03.coords[2] = 2 #Поменял атрибуту координаты Car3
print(Car_03.coords)
print(Car_04.coords)
# Список раздублировался на все объекты в классе
print('id атрибута:', id(Car_03.coords)) # запросили id этого списка coords и видим что id этого списка одинаковый у всех объектов, а значит выводится один и тот же атрибут.
print('id атрибута:', id(Car_04.coords))

print(Car_03.__dict__)

# ВЫВОД: Все изменяемые атрибуты имеют один id для всех объектов. При изменения элемента изменяемого атрибута, мы меняем именно элемент, а не весь атрибут, поэтому он не записывается в __dict__ отдельно

print('----------Наследование и super()----------')

class Coupe(Car): #Coupe - наследник. (Car) - источник наследования
	color = 'red'
	
	def accelerate(self, value):
		super().accelerate(value * 2) # принцип. Super - обозначает, что берем метод accelerate у родителя класса и просто умножаем его на 2.
	
	
Coupe_01 = Coupe()

print(Coupe_01.color)
print(Coupe_01.engine_volume)
print(Coupe_01.year)
print(Coupe_01.fuel)
print(Coupe_01.position)
print(Coupe_01.speed)
print(Coupe_01.status)


print(Coupe_01)

print(Car())

print('----------Переназначение----------')
print(Car_01.__dict__)
print(Coupe_01.__dict__)
Car_01.accelerate(100)
Coupe_01.accelerate(100)
print(Car_01.__dict__)
print(Coupe_01.__dict__)
print(Car_01.speed)
print(Coupe_01.speed)


print('----------Множественное наследование----------')
class Expensive:
	price = 2000000

class Cabriolete(Expensive, Car): #Множественное наследование. В приоритете атрибуты первого родителя (слева), если название атрибутов одинаковые
	pass
	
Cabriolete_00 = Cabriolete()
print(Cabriolete_00.price)

#Чтобы узнать кто от кого наследуется есть метод .mro
print(Cabriolete.mro())
# Результат так же будет в порядке приоритета. Слева направо.

print('----------Дандерметоды----------') #Магические методы

