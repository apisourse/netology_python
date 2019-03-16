
day_cost = 20 #стоимость дня путешествий
trips_count = 3 #количество путешествий

trip_langht_1 = 10 #Turkey
trip_langht_2 = 3 #France
trip_langht_3 = 5 #Germany

flight_cost = 50 #стоимость перелета
flight_per_trip = 2 #количество перелетов

cost_limit = int(input('Введите лимит поездки в ЕВРО: ')) #euro

euro_rate = 74.5
print('Курс EURO:', euro_rate)

flighting_cost = flight_cost * flight_per_trip * trips_count
print('Сумма перелетов:', flighting_cost, 'EURO', '/', flighting_cost * euro_rate, 'RUB')

trip_cost = (trip_langht_1 + trip_langht_2 + trip_langht_3) * day_cost
print('Сумма проживания:', trip_cost, 'EURO', '/', trip_cost * euro_rate, 'RUB')

trip_cost += trips_count * flight_cost * flight_per_trip
print('Сумма проживания с перелетом:', trip_cost, 'EURO', '/', trip_cost * euro_rate, 'RUB')

if trip_cost > cost_limit:
    print('Не вариант. В деревню к теще :(')
else:
    print('Ништяк,... оторвемся!!!')