import json
import pprint

ful2fr = {
    320: 8,
    243: 10,
    224: 12,
    272: 14,
    368: 19,
    257: 21,
    505: 23,
    565: 29,
    197: 30,
    290: 33,
    337: 34,
    282: 35,
    347: 38,
    446: 41,
    215: 42,
    163: 43,
    215: 45,
    585: 47,
    199: 48,
    254: 50,
    271: 52,
    21: 53,
    1: 54,
    135: 55,
    242: 56,
    531: 57,
    403: 58,
    432: 59,
    500: 60,
    128: 61,
    342: 63,
    560: 65,
    347: 66,
    566: 67,
    465: 68,
    514: 70,
    508: 72,
    561: 73,
    248: 74,
    237: 75,
    259: 76,
    277: 77,
    352: 78,
    413: 80,
    407: 81,
    249: 82,
    495: 83,
    556: 85,
    142: 86,
    359: 87,
    201: 88,
    394: 89,
    380: 90,
    340: 91,
    186: 92,
    321: 93,
    449: 94,
    195: 95,
    354: 97,
    386: 98,
    558: 99,
    557: 100,
    252: 101,
    527: 102,
    602: 103,
    260: 104,
    476: 105,
    334: 106,
    489: 107,
}
file = open("../assets/data/hymns-full.json", "r")
data = json.loads(file.read())
cleaned = []
for cantique in data["data"]:
    model = {"slides": [], "parts": [], "title": "", "number": int(cantique["number"])}
    # adding refs
    model["references"] = {"ful": int(cantique["number"]), "en": 0, "fr": 0}
    if (int(cantique["number"])) in {v: k for k, v in ful2fr.items()}.keys():
        full = {v: k for k, v in ful2fr.items()}[int(cantique["number"])]
        model["references"] = {"fr": full, "en": 0, "ful": int(cantique["number"])}
    # adding slides

    model["parts"] = list(cantique["data"].keys())
    model["slides"] = list(cantique["data"].keys())
    model["title"] = cantique["title"]
    if cantique["refrain"] != []:
        temp = []
        for item in model["parts"]:
            temp.append(item)
            temp.append("refrain")
        model["slides"] = temp
        model["parts"].insert(1, "refrain")
    if "refrain" in model["parts"]:
        model["refrain"] = cantique["refrain"]
    for index in model["parts"]:
        if index != "refrain":
            model[str(index)] = cantique["data"][index]
    cleaned.append(model)
with open("../assets/data/hymns-fulfulde.json", "w", encoding="utf-8") as f:
    json.dump(cleaned, f, ensure_ascii=False, indent=4)
