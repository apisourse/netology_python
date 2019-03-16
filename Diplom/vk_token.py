from urllib.parse import urlencode
import requests
import webbrowser 
import time

def get_token():
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
	url = url_auth + (urlencode(auth_data))
	print('Через 5 секунд вы будете перенаправлены по адресу:', url, '\n')
	time.sleep(5)
	new = 2
	open_url_in_browser = webbrowser.get(using='macosx').open(url,new=new)