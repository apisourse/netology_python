import requests
import time
import json
import os


print('Скрипт обработает всех друзей пользователя, просканирует сообщества его друзей и выведет те сообщества в которых состоит пользователь 171691064б, но в которых не состоят его друзься.\n\nНо для начала нужно получить токен VK.\n\nhttps://oauth.vk.com/authorize?client_id=6772446&display=page&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&scope=friends&response_type=token&v=5.92\n')

token = input('Введите токен:\n')
user_id = input(str('Введите id пользователя:\n'))
# user_id = '171691064'


class Users:
	def __init__(self, token, user_id):
		self.token = token
		self.user_id = user_id


class UsersList(Users):
	def get_friends_id_list(self, token, user_id):
		friends_id_list_export = list()
		url_response = 'https://api.vk.com/method/'
		method = 'friends.search' + '?'
		params = {
			'access_token': token,
			'user_id': user_id,
			'count': '1000',
			'v': 5.92,
		}
		response = requests.get(url_response + method, params=params)
		for i in response.json()['response']['items']:
			friends_id_list_export.append(i['id'])
		return friends_id_list_export

	def get_group_id_list(self, token):
		url_response = 'https://api.vk.com/method/'
		method = 'groups.get' + '?'
		params = {
			'access_token': token,
			'extended': 0,
			'fields': 'members_count',
			'user_id': self.user_id,
			'count': '1000',
			'v': 5.92,
		}
		response = requests.get(url_response + method, params=params)
		try:
			get_group_id_list_export = response.json()['response']['items']
		except KeyError:
			get_group_id_list_export = []
		return get_group_id_list_export


def friends_scanner():
	all_users_export = list()
	for friend in main_user.get_friends_id_list(token, user_id):
		friend = UsersList(token, friend)
		for i in friend.get_group_id_list(token):
			all_users_export.append(i)
		print(friend.user_id, '- обработано')
		time.sleep(0.2)
	return all_users_export


def get_filter_group_dicts(token, user_id, scanner_catalog):
	url_response = 'https://api.vk.com/method/'
	method = 'groups.get' + '?'
	params = {
		'access_token': token,
		'extended': 1,
		'fields': 'members_count',
		'user_id': user_id,
		'count': '1000',
		'v': 5.92,}
	response = requests.get(url_response + method, params=params)
	try:
		get_groups_dict_export = response.json()['response']['items']
	except KeyError:
		get_groups_dict_export = []

	form_list_for_write_export = list()
	for i in get_groups_dict_export:
		if i['id'] not in scanner_catalog:
			print('{} - not list'.format(i['id']))
			g_export = {'name' : i['name'], 'gid' : i['id'], 'members_count' : i['members_count']}
			form_list_for_write_export.append(g_export)
	return form_list_for_write_export


def write_json(json_data):
	file_name = 'groups.json'
	with open(file_name, 'w') as datafile:
		json.dump(json_data, datafile, ensure_ascii=False, indent=4)
	return 'Файл записан:' + os.getcwd() + '/' + file_name


if __name__ == '__main__':
	main_user = UsersList(token, user_id)
	scanner_catalog = friends_scanner()
	print('-----------------------------')
	main_user.get_group_id_list(token)
	json_data = get_filter_group_dicts(token, user_id, scanner_catalog)
	print(write_json(json_data))
