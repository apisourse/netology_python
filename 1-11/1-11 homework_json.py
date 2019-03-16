import json
from pprint import pprint
from collections import Counter

with open("files/newsafr.json", encoding="utf-8") as datafile_load:
	json_data = json.load(datafile_load)
	
my_dict = dict()
word_list = list()

for level_one in json_data['rss']['channel']['items']:
	for_words_list = level_one['description'].split()
	word_list.extend(for_words_list)
counter_world = Counter(word_list)

for k, v in counter_world.items():
	if len(k) > 6:
		my_dict[k] = v
s = sorted(my_dict.items(), key=lambda x: x[1], reverse=True)
for i in s[0:10]:
	print(i[0], i[1])
