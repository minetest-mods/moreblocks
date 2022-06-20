import pathlib
import re

ourdir = pathlib.Path('./')

template = (ourdir / 'stairsplus.template.tr').open().readlines()

for tr in ourdir.glob('*.tr'):
  if str(tr) == 'stairsplus.template.tr':
    continue

  trs = {}
  for line in tr.open():
    m = re.fullmatch('([^=]+)=(.*)', line.rstrip('\n'))
    if m:
      trs[m.group(1)] = m.group(2)

  with tr.open('w') as fh:
    for line in template:
      m = re.fullmatch('([^=]+)=(.*)', line.rstrip())
      if m:
        key = m.group(1)
        value = trs.get(m.group(1), "")
        if value == "":
          if 'Microblock' in key:
            value = trs.get('@1 Microblock', "")
          elif 'Panel' in key:
            value = trs.get('@1 Panel', "")
          elif 'Slab' in key:
            value = trs.get('@1 Slab', "")
          elif 'Slope' in key:
            value = trs.get('@1 Slope', "")
          elif 'Stair' in key:
            value = trs.get('@1 Stairs', "")

        print(f'{key}={value}', file=fh)
      else:
        print(line, end='', file=fh)

