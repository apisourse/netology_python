import requests
from pprint import pprint
#requests.get(url [, params [, **kwargs ]])
#requests.post(url [, data [, json [, **kwargs ]]])
#requests.patch(url [, data [, **kwargs ]])


#Яндекс перевдчик

url = 'https://translate.yandex.net/api/v1/tr.json/translate'
params = 'id=03b9df39.5c026181.6513f822-0-0&srv=tr-text&lang=ru-en'
response = requests.post(url, data={'text':'Привет мир'}, params=params)
export = response.json()
print(export['text'])

print('----------')
print('Код статуса:', response.status_code) #Код статуса
print('----------')
print('Заголовок ответа:', response.headers) #Можно также просматривать заголовки ответа
print('----------')
print('Просмотреть отдельную куку:', response.headers.get('Set-Cookie')) #Если мы хотим просмотреть отдельный заголовок, к примеру Set-Cookie
print('----------')
print('Крнтент:', response.text) #Для получения возвращаемого контента
print('----------')
print('Все содержимое ответа:', response.content) #Для просмотра содержимого ответа

print('-----------------------------------------')

#text_for_translate = input('Введите текст для перевода:')

def translate(text_for_translate, lang):
	url = 'https://translate.yandex.net/api/v1/tr.json/translate'
	data = {
		'text' : text_for_translate,
		'lang' : lang,
	}
	params = 'id=03b9df39.5c026181.6513f822-0-0&srv=tr-text'
	response = requests.post(url, data=data, params=params, timeout=5)
	export = response.json()
	return export['text']


if __name__ == '__main__':
	lang = 'ru-en'
	text = input('Введите текст для перевода:')
	text_after_translate = translate(text, lang)
	print(text_after_translate)
 