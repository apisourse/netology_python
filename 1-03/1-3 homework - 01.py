countries = {
	'Thailand': {
		'country_sea': True, 
		'country_schengen': False, 
		'exchange_rate': 2, 
		'temperature': 28, 
		'living_cost': 900
		},
	'Germany': {
		'country_sea': True, 
		'country_schengen': True, 
		'exchange_rate': 74, 
		'temperature': 10, 
		'living_cost': 50
		},
	'Poland': {
		'country_sea': True, 
		'country_schengen': True, 
		'exchange_rate': 18, 
		'temperature': 8, 
		'living_cost': 150
		},
	'Russia': {
		'country_sea': True, 
		'country_schengen': False, 
		'exchange_rate': 1, 
		'temperature': 5, 
		'living_cost': 2000
		}
	}
#Необходимо добавить в словарь countries еще минимум три элемента (страны). 

countries ['England'] = {
		'country_sea': True, 
		'country_schengen': False, 
		'exchange_rate': 4, 
		'temperature': 10, 
		'living_cost': 300
		}
countries ['Spain'] = {
		'country_sea': True, 
		'country_schengen': False, 
		'exchange_rate': 1, 
		'temperature': 23, 
		'living_cost': 600
		}
countries ['France'] = {
		'country_sea': True, 
		'country_schengen': True, 
		'exchange_rate': 7, 
		'temperature': 11, 
		'living_cost': 1000
		}

budget = 20000

for countries_key, countries_values in countries.items():
	living_cost = countries_values['living_cost']
	exchange_rate = countries_values['exchange_rate']
	if (living_cost / exchange_rate * 7) < budget and countries_values['country_schengen'] == True:
		print(countries_key, '-', 'Хватит бюджета на неделю проживания И находятся в Шенгенской зоне')
	elif (living_cost  / exchange_rate * 10) < budget and countries_values['temperature'] > 20 and countries_values['country_sea'] == True:
		print(countries_key, '-', 'Хватит бюджета на 10 дней проживания И есть выход к морю И средняя температура больше 20')