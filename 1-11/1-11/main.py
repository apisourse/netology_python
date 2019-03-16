from pprint import pprint
import json

print('-----------------------------------')
with open("files/newsafr.json", encoding="utf-8") as datafile_load:
	json_data = json.load(datafile_load)
pprint(json_data)

test_dict = {"test1":"Просто данные"}
with open("files/newsafr2.json", "w", encoding="utf_8_sig") as datafile_dump:
	json.dump(json_data, datafile_dump, ensure_ascii=False)
print('-----------------------------------')





#КОДИРОВКИ
#encoding="utf_8_sig"
#encoding="utf_8"
#encoding="cp1251"





print('-----------------------------------')
import yaml
with open("files/newsafr.yml") as datafile_load:
	yml_data = yaml.load(datafile_load)
	print(yml_data)

with open("files/newsafr2.yml", "w") as datafile_dump:
	yaml.dump(yml_data, datafile_dump, allow_unicode=True, default_flow_style=True)
print('-----------------------------------')





print('-----------------------------------')
import xml.etree.ElementTree as ET
tree = ET.parse("files/newsafr.xml")
pprint(tree)
titles = []
# что такое корневой элемент xml
root = tree.getroot()
# print(root.tag)
# print(root.attrib)

title = root.find("channel/title")
print(title)
xml_items = root.findall("channel/item")
print(xml_items)
for item in xml_items:
	print(item.attrib["id"])
	print(item.find("title").text)
print('-----------------------------------')





print('-----------------------------------')
import csv
csv.register_dialect('customcsv', delimiter=';', quoting=csv.QUOTE_ALL, quotechar='"', escapechar='\\')

flats_list  = list()
with open("files/flats.csv") as datafile:
	csv_data = csv.reader(datafile, delimiter=";")
	flats_list = list(csv_data)
	for i, flat in enumerate(csv_data):
		print(flat)
		if i == 5:
			break

with open("files/flats2.csv", "w") as datafile:
	datafile_csv = csv.writer(datafile, 'customcsv')
	datafile_csv.writerow(["test", "test2"])
	datafile_csv.writerows(flats_list)
print('-----------------------------------')