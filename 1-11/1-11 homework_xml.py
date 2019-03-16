from collections import Counter

import xml.etree.ElementTree as ET
parser = ET.XMLParser(encoding = 'utf-8')
tree = ET.parse('files/newsafr.xml', parser)
root = tree.getroot()


my_dict = dict()
word_list = list()

xml_desc = root.findall("channel/item/description")
for xml_description in xml_desc:
	word_list.extend(xml_description.text.split())
counter_world = Counter(word_list)

for k, v in counter_world.items():
	if len(k) > 6:
		my_dict[k] = v
s = sorted(my_dict.items(), key=lambda x: x[1], reverse=True)
for i in s[0:10]:
	print(i[0], i[1])