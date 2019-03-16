import os
import glob
import subprocess
import chardet

cwd = os.getcwd() #Возвращает текущий путь
print('cwd:', cwd)
pid = os.getpid()
print('pid:', pid)
sid = os.getsid(pid)
print('sid:', sid)
uid = os.getuid()
print('uid:', uid)
login = os.getlogin()
print('login:', login)
gid = os.getegid()
print('gid:', gid)
grooup = os.getgroups()
print('grooup:', grooup)
loadavg = os.getloadavg()
print('loadavg:', loadavg)
print('----------------------')
dir = os.getcwd()
print(os.listdir(path="."))
print('----------------------')
print(os.getcwd())
new_directory = '/etc/'
os.chdir(new_directory) #Новая директория /etc
print(os.getcwd())
os.chdir('cups') #Новая директория /etc/cups
print(os.getcwd())
os.chdir('..') #Переместиться на уровень вниз
print(os.getcwd())
print('----------------------')
#соединяем пути, что бы во всех ОС был одинаковый формат пути
join = os.path.join(os.getcwd(), 'dir1', 'dir2', 'dir3')
print(join)
print('----------------------')
f1 = __file__
print(f1) #файл, который сейчас работает
print('----------------------')
f2 = os.path.split(__file__) #разделяет путь на состоавляющие
print(f2)
print('----------------------')
f3 = os.path.splitext(__file__) #
print(f3)
print('----------------------')
f4 = os.path.realpath(__file__) #получаем текущую директорию
print(f4)
print('----------------------')

#subprocess
#subprocess.run(['ping', 'fizkult-nn.ru'], encoding='utf8 ') #Запускае команду

#f5 = subprocess.Popen() #Запускаем внешнюю программу и не ждем завершения