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

	def __init__(self, fuel, position):
		self.coords = [0, 0, 0]
		self.fuel = fuel
		self.position = position
		
Car_01 = Car(101, 102)
print(Car_01.__dict__)
print(Car_01.fuel)
print(Car_01.position)
print(Car_01.coords)
print(Car_01.__dict__)

Car_02 = Car(201, 202)
Car_02.coords[2] = 1
print(Car_02.fuel)
print(Car_02.position)
print(Car_02.coords)
print(Car_02.__dict__)

# ИТОГ: Если мы помещаем изменяемые функции в атрибуты, то с ними можно работать индивидуально в рамках объектах
