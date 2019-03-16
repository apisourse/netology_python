age = int(input('Возраст '))
count_children = int(input('Количество детей '))
p1 = 'Иди в военковат'
p2 = 'Иди работай'
p3 = 'Иди учись'


if (age >= 18 and age <= 27) and (count_children >= 2):
  print('Результат опроса: ', p1)
elif age > 27:
  print('Результат опроса: ', p2)
else:
  print('Результат опроса: ', p3)

## простое условное выражение
x = int(input('Введите число: '))
if x % 2 == 0:
  print('четное')
else:
  
  print('нечетное')