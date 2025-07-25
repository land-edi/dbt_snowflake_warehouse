import json

with open('target/manifest.json') as f:
    manifest = json.load(f)

violations = []

for node in manifest['nodes'].values():
    if node['resource_type'] != 'model':
        continue

    if not node['original_file_path'].startswith('marts/'):
        continue

    for dep in node['depends_on']['nodes']:
        if dep.startswith('model.base__'):
            violations.append((node['name'], dep))

if violations:
    print("❌ Mart models should not reference base models directly:")
    for mart, base in violations:
        print(f"  - {mart} → {base}")
    exit(1)
else:
    print("✅ No mart → base model violations found.")
