import json

with open('edi_dbt_project/target/manifest.json') as file:
    manifest = json.load(file)

base_violations = []

source_violations = []

for node in manifest['nodes'].values():
    if node['resource_type'] != 'model':
        continue

    if not node['original_file_path'].startswith('models/mart/'):
        continue

    for dep in node['depends_on']['nodes']:
        if dep.split(".")[-1].startswith('base__'):
            base_violations.append((node['name'], dep))
        if dep.startswith('source'):
            source_violations.append((node['name'], dep))

if base_violations or source_violations:
    if base_violations:
        print("❌ Mart models should not reference base models directly:")
        for mart, base in base_violations:
            print(f"  - {mart} → {base}")
    if source_violations:
        print("❌ Mart models should not reference source models directly:")
        for mart, source in source_violations:
            print(f"  - {mart} → {source}")
    exit(1)
else:
    print("✅ No mart → base or source model violations found.")
