import json
import glob
import os

EN_PATH = "lib/l10n/app_en.arb"

def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def save_json(path, data):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

en = load_json(EN_PATH)

for path in glob.glob("lib/l10n/app_*.arb"):
    if os.path.normpath(path) == os.path.normpath(EN_PATH):
        continue

    loc = load_json(path)

    added = 0
    # Add missing keys from EN into this locale file.
    for k, v in en.items():
        if k not in loc:
            loc[k] = v
            added += 1

    # Keep @@locale if present (don’t overwrite)
    # But ensure it's present:
    if "@@locale" not in loc:
        # infer from filename app_xx.arb
        code = os.path.splitext(os.path.basename(path))[0].split("_", 1)[1]
        loc["@@locale"] = code

    save_json(path, loc)
    print(f"{path}: added {added} missing key(s)")