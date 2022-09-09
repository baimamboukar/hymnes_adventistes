import json
import pprint as printer

file = open("../assets/data/hymns-en.json")
data = json.loads(file.read())
cleaned = []
for index in range(0, 695):
    model = {}
    cantique = data["songs"][str(index)]
    model["number"] = int(cantique["id"])
    model["parts"] = list(cantique["stanzas"].keys())
    model["slides"] = list(cantique["stanzas"].keys())
    model["title"] = cantique["title"]
    for x in model["parts"]:
        model[x] = cantique["stanzas"][x]
    if model["1"].__contains__("Refrain"):
        tmp = []
        for x in model["parts"]:
            tmp.append(x)
            tmp.append("refrain")
        model["slides"] = tmp
        model["parts"].insert(1, "refrain")
        model["refrain"] = model["1"].split("Refrain")[1]
        model["1"] = model["1"].split("Refrain")[0]
    model["references"] = {"en": int(cantique["id"]), "fr": 0, "ful": 0}
    for key in model["parts"]:
        model[key] = [clean for clean in model[key].split(";")]
    cleaned.append(model)
with open("../assets/data/hymns_en.json", "w", encoding="utf-8") as f:
    json.dump(cleaned, f, ensure_ascii=False, indent=4)
