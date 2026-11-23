import json, random, sys
from pathlib import Path

# usage: convert_realiad.py <realiad_root> <out_eval> <out_ft> [max_per_cls]
# <realiad_root> holds realiad_jsons_sv/<object>.json and the 1024px images at <object>/...
root, out_eval, out_ft = Path(sys.argv[1]), Path(sys.argv[2]), Path(sys.argv[3])
max_per_cls = int(sys.argv[4]) if len(sys.argv) > 4 else 400
random.seed(0)


def resolve(rel, cls, prefix):
    """Return the first existing candidate path for an image/mask path from the json."""
    rel = str(rel).lstrip("/")
    for p in (root / rel, root / cls / rel, root / prefix / rel if prefix else None, root / cls / Path(rel).name):
        if p is not None and p.exists():
            return str(p)
    return str(root / rel)


ev, ft = {}, {}
for jf in sorted((root / "realiad_jsons_sv").glob("*.json")):
    d = json.load(open(jf))
    cls = jf.stem
    prefix = d.get("meta", {}).get("prefix", "") if isinstance(d.get("meta"), dict) else ""
    items = list(d["test"])
    random.shuffle(items)
    recs = []
    for it in items[:max_per_cls]:
        ok = it["anomaly_class"] == "OK"
        mask = it.get("mask_path") or ""
        recs.append(dict(
            img_path=resolve(it["image_path"], cls, prefix),
            mask_path="" if (ok or not mask) else resolve(mask, cls, prefix),
            cls_name=cls, specie_name="" if ok else it["anomaly_class"], anomaly=0 if ok else 1))
    h = len(recs) // 2
    ft[cls], ev[cls] = recs[:h], recs[h:]
for out, test in ((out_eval, ev), (out_ft, ft)):
    out.mkdir(parents=True, exist_ok=True)
    json.dump({"train": {}, "test": test}, open(out / "meta.json", "w"))
    print(out, {k: len(v) for k, v in test.items()})
