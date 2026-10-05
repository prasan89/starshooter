#!/usr/bin/env python3
"""
Rewrites existing levels 11-50 worldMeta in level_catalog.dart to match
the new 40-levels-per-world structure:
  World 1 (Nebula Nursery): levels 1-40
  World 2 (Asteroid Fields): levels 41-80
  World 3 (Solar Winds): levels 81-120
  World 4 (Event Horizon): levels 121-160
  World 5 (Frozen Nebula): levels 161-200

Only worldId, levelNumber, worldName, and unlockRequirement change.
Level IDs, gameplay parameters, and board layouts are untouched.
"""
import re, sys

WORLD_NAMES = {
    1: 'Nebula Nursery',
    2: 'Asteroid Fields',
    3: 'Solar Winds',
    4: 'Event Horizon',
    5: 'Frozen Nebula',
}

def new_world_for_level(lid):
    if lid <= 40:   return 1, lid
    if lid <= 80:   return 2, lid - 40
    if lid <= 120:  return 3, lid - 80
    if lid <= 160:  return 4, lid - 120
    return 5, lid - 160

with open('lib/game/level/level_catalog.dart') as f:
    content = f.read()

# Find each level block and rewrite its worldMeta
# Pattern: worldMeta: LevelWorldMeta(\n        worldId: X,\n        levelNumber: Y,\n        worldName: 'Z',
def rewrite_block(m):
    level_id = int(m.group(1))
    new_wid, new_ln = new_world_for_level(level_id)
    new_name = WORLD_NAMES[new_wid]

    # Only update levels 11-50 (levels 1-10 are already correct)
    if level_id <= 10:
        return m.group(0)

    old = m.group(0)
    new = old
    # Replace worldId
    new = re.sub(r'worldId: \d+,', f'worldId: {new_wid},', new)
    # Replace levelNumber
    new = re.sub(r'levelNumber: \d+,', f'levelNumber: {new_ln},', new)
    # Replace worldName
    new = re.sub(r"worldName: '[^']*',", f"worldName: '{new_name}',", new)

    if old != new:
        print(f'  Level {level_id}: worldId->{new_wid}, levelNumber->{new_ln}, worldName->{new_name}')
    return new

# Pattern that captures: level comment, then the LevelDefinition up to worldMeta block
pattern = re.compile(
    r'(// Level (\d+).*?worldMeta: LevelWorldMeta\(\n'
    r'\s+worldId: \d+,\n'
    r'\s+levelNumber: \d+,\n'
    r'\s+worldName: \'[^\']*\',)',
    re.DOTALL
)

print('Updating world assignments for levels 11-50...')

def replacer(m):
    level_id = int(m.group(2))
    if level_id <= 10 or level_id > 50:
        return m.group(0)

    new_wid, new_ln = new_world_for_level(level_id)
    new_name = WORLD_NAMES[new_wid]

    text = m.group(0)
    text = re.sub(r'worldId: \d+,', f'worldId: {new_wid},', text)
    text = re.sub(r'levelNumber: \d+,', f'levelNumber: {new_ln},', text)
    text = re.sub(r"worldName: '[^']*',", f"worldName: '{new_name}',", text)

    old_wid = int(re.search(r'worldId: (\d+)', m.group(0)).group(1))
    old_ln = int(re.search(r'levelNumber: (\d+)', m.group(0)).group(1))
    if old_wid != new_wid or old_ln != new_ln:
        print(f'  Level {level_id}: World{old_wid}#{old_ln} -> World{new_wid}#{new_ln} ({new_name})')
    return text

new_content = pattern.sub(replacer, content)

with open('lib/game/level/level_catalog.dart', 'w') as f:
    f.write(new_content)

print('Done.')
