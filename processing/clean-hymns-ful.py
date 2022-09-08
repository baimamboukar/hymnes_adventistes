import json
import pprint

file = open("../assets/data/hymns-ful.json", "r")
out = open("../assets/data/hymns-ful-clean.json", "w")

data = json.loads(file.read())
# Iterating through the jsons
# list
cleaned = {"data": []}

for hymn in data["resources"]["string"]:
    pprint.pprint(hymn)
    cleaned["data"].append(hymn)
    # write content of clean in json file out
    with open("../assets/data/hymns-ful-clean.json", "w", encoding="utf-8") as f:
        json.dump(cleaned, f, ensure_ascii=False, indent=4)
