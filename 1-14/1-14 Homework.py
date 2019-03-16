from urllib.parse import urlencode
import requests

app_id = 6772446
url_auth = 'https://oauth.vk.com/authorize?'
auth_data = {
	'client_id' : app_id,
	'display' : 'page',
	'redirect_uri' : 'https://oauth.vk.com/blank.html',
	'scope' : 'friends',
	'response_type' : 'token',
	'v' : 5.92
}
print('Получить токен:\n' + url_auth + (urlencode(auth_data)))
print('------------------------------------')
token = input('Введите токен:\n')

class Users:
	def __init__(self, token):
		self.token = token
	
class GetMutual(Users):
	def get_mutul(self):
		insert_users = input('Введите идетификаторы пользователей (Пример: 9764801 & 14926654):\n')
		i = insert_users.strip().split(' & ')
		user1 = i[0]
		user2 = i[1]
		
		url_response = 'https://api.vk.com/method/'
		method = 'friends.getMutual' + '?'
		params = {
			'access_token' : self.token, 
			'source_uid' : user1,
			'target_uid' : user2,
			'v' : 5.92,
			}
		response = requests.get(url_response + method, params=params)
		return response.json()['response']
#'------------------------------------'
class GetDomain(Users):
	def get_domain(self):
		insert_user = input('Введите идетификаторы пользователя (Пример: 9764801):\n')
		url_response = 'https://api.vk.com/method/'
		method = 'users.get' + '?'
		params = {
			'access_token' : self.token, 
			'user_id' : insert_user,
			'fields' : 'domain',
			'v' : 5.92,
			}
		response = requests.get(url_response + method, params=params)
		link = 'Ссылка на профиль: ' + 'https://vk.com/' + response.json()['response'][0]['domain']
		return link
#'------------------------------------'
#Выводим список общих друзей
u = GetMutual(token)
mutual = u.get_mutul()
print(mutual)

#Выводим ссылку на профиль пользователя по запросу
u = GetDomain(token)
user = u.get_domain()
print(user)