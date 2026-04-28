# CanOpener
Adds buttons for items that can be opened, learned, etc. Very small and responsive.

# Features
- Movable button (hold right click and drag)
- Automatically adds items as they get looted
- Hides in combat
- Per-character settings
- Lightweight, low memory footprint
- Suppresses items the character can't yet use (level-gated, quest-gated)
- Auto-hides lockboxes for characters without Pick Lock (Rogue) or Skeleton Pinkie (Mechagnome)
- Shift + right click a button to add that item to the ignore list
- In-game settings panel (Escape → Options → AddOns → CanOpener) with an Ignore List sub-panel

# Chat Commands
Use `/co` or `/canopener` followed by a command:
- `rousing` - Toggle showing Rousing elements
- `levelrestricted` - Toggle showing level-restricted items
- `lockbox` - Toggle showing lockboxes regardless of class (enable this if you open them another way, e.g. Blacksmithing skeleton keys)
- `ignore <itemID>` - Add an item to the ignore list
- `unignore <itemID>` - Remove an item from the ignore list
- `list` - Show all ignored items
- `reset` - Reset the addon to the default settings

# Missing Items
To request adding any missing items, open an issue or make a Pull Request.

# Planned Upgrades
- Localizations
