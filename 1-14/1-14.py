from urllib.parse import urlencode
import requests

app_id = 6772446

#Пример: https://oauth.vk.com/authorize?client_id=5490057&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52

url_auth = 'https://oauth.vk.com/authorize?'
auth_data = {
	'client_id' : app_id,
	'display' : 'page',
	'redirect_uri' : 'https://oauth.vk.com/blank.html',
	'scope' : 'friends, status',
	'response_type' : 'token',
	'v' : 5.92
}
#Проверяем склейку адреса
#print(url_auth + (urlencode(auth_data)))

print('---------------------------')

token = '3439b84e2c6ccbb9021865eb1ae4e479c75bc5685db07f30e00fab7451b3c7e7f5bb19f4611f2a8a16cd7'

def get_status(token):
	url_response = 'https://api.vk.com/method/'
	method = 'status.get' + '?'
	params = {'access_token' : token, 'v' : 5.92,}
	response = requests.get(url_response + method, params=params)
	return response.json()['response']['text']

print('Def:' + get_status(token))

print('---------------------------')

class User:
	def __init__(self, token):
		self.token = token
		
	def get_status(self):
		url_response = 'https://api.vk.com/method/'
		method = 'status.get' + '?'
		params = {'access_token' : self.token, 'v' : 5.92,}
		response = requests.get(url_response + method, params=params)
		return response.json()['response']['text']
		
Artem = User(token)
status = Artem.get_status()
print('Class:' + status)