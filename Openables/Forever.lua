local _, CanOpenerGlobal = ...
-- WoW: Forever only. Vanilla-era items that also exist on Forever (same item IDs) live in
-- Classic.lua, which loads on both flavors; this file is for items that only exist on Forever.
if not CanOpenerGlobal.IsForever then return end
local openables = CanOpenerGlobal.openables

local foreverIDs = {
    11442,  -- Stormwind Deputy Kit
    191656,  -- Death's Essence
    205364,  -- Acolyte's Knapsack
    208223,  -- Acolyte's Knapsack
    208766,  -- Helping Hand
    208848,  -- Cracked Skull-Shaped Geode
    209031,  -- Discreet Envelope
    210330,  -- Hot Tip
    211799,  -- Sack of Stolen Goods
    213565,  -- Entomology Starter Kit
    216618,  -- Captain Aransas' Reward
    217014,  -- Supply Bag
    219526,  -- Mission Brief: Duskwood
    219773,  -- Mission Brief: Ashenvale
    219774,  -- Mission Brief: Hinterlands
    219775,  -- Mission Brief: Feralas
    220446,  -- Otherworldly Treasure
    220914,  -- Broken Geode Hammer
    221371,  -- Kidnapper's Coin Purse
    221471,  -- Emerald Wardens Chest
    221491,  -- Shadowtooth Bag
    223148,  -- Otherworldly Treasure
    223149,  -- Otherworldly Treasure
    223150,  -- Otherworldly Treasure
    223151,  -- Otherworldly Treasure
    224836,  -- Otherworldly Treasure
    224848,  -- Otherworldly Treasure
    224849,  -- Otherworldly Treasure
    224850,  -- Otherworldly Treasure
    224851,  -- Otherworldly Treasure
    226405,  -- Damaged Undermine Supply Crate
    227337,  -- Feline Gloves and Belt Set
    227338,  -- Astral Gloves and Belt Set
    227339,  -- Guardian's Gloves and Belt Set
    227340,  -- Mender's Gloves and Belt Set
    227341,  -- Pursuer's Gloves and Belt Set
    227343,  -- Merciful Gloves and Belt Set
    227344,  -- Radiant Gloves and Belt Set
    227345,  -- Divine Will Gloves and Belt Set
    227346,  -- Dawn Gloves and Belt Set
    227347,  -- Twilight Gloves and Belt Set
    227348,  -- Thrill's Gloves and Belt Set
    227350,  -- Relief's Gloves and Belt Set
    227351,  -- Eruption's Gloves and Belt Set
    227352,  -- Impact's Gloves and Belt Set
    227354,  -- Corrupted Gloves and Belt Set
    227356,  -- Immoveable Gloves and Belt Set
    227357,  -- Unstoppable Gloves and Belt Set
    227359,  -- Feline Boots, Legs, and Shoulders Set
    227360,  -- Astral Boots, Legs, and Shoulders Set
    227361,  -- Guardian's Boots, Legs, and Shoulders Set
    227365,  -- Mender's Boots, Legs, and Shoulders Set
    227366,  -- Pursuer's Boots, Legs, and Shoulders Set
    227368,  -- Merciful Boots, Legs, and Shoulders Set
    227369,  -- Radiant Boots, Legs, and Shoulders Set
    227370,  -- Divine Will Boots, Legs, and Shoulders Set
    227371,  -- Dawn Boots, Legs, and Shoulders Set
    227372,  -- Twilight Boots, Legs, and Shoulders Set
    227373,  -- Thrill's Boots, Legs, and Shoulders Set
    227375,  -- Relief's Boots, Legs, and Shoulders Set
    227376,  -- Eruption's Boots, Legs, and Shoulders Set
    227377,  -- Impact's Boots, Legs, and Shoulders Set
    227379,  -- Corrupted Boots, Legs, and Shoulders Set
    227381,  -- Immoveable Boots, Legs, and Shoulders Set
    227382,  -- Unstoppable Boots, Legs, and Shoulders Set
    227383,  -- Feline Helm and Chestpiece Set
    227384,  -- Astral Helm and Chestpiece Set
    227385,  -- Guardian's Helm and Chestpiece Set
    227387,  -- Mender's Helm and Chestpiece Set
    227388,  -- Pursuer's Helm and Chestpiece Set
    227390,  -- Merciful Helm and Chestpiece Set
    227391,  -- Radiant Helm and Chestpiece Set
    227392,  -- Divine Will Helm and Chestpiece Set
    227393,  -- Dawn Helm and Chestpiece Set
    227394,  -- Twilight Helm and Chestpiece Set
    227395,  -- Thrill's Helm and Chestpiece Set
    227397,  -- Relief's Helm and Chestpiece Set
    227398,  -- Eruption's Helm and Chestpiece Set
    227399,  -- Impact's Helm and Chestpiece Set
    227401,  -- Corrupted Helm and Chestpiece Set
    227403,  -- Immoveable Helm and Chestpiece Set
    227404,  -- Unstoppable Helm and Chestpiece Set
    227931,  -- Hidden Bundle
    228327,  -- Satchel of Silver Slaughter Coins
    228615,  -- Otherworldly Treasure
    231642,  -- Warden's Herb Bag
    231644,  -- Warden's Enchanting Bag
    236414,  -- Damaged Undermine Supply Crate
    237263,  -- Supply Bag
    238681,  -- Dusty Bag
    243299,  -- Big Bag o' Gold
    249900,  -- Regurgitated Seed Pod
    270257,  -- Captain Sander's Locker
    271994,  -- Undermine Satchel
    272151,  -- Damaged Undermine Supply Crate
    273318,  -- Pack of Journeyman Supplies
    273319,  -- Pack of Apprentice Supplies
    273320,  -- Pack of Expert Supplies
    273321,  -- Pack of Artisan Supplies
    274974,  -- Message in a Bottle
    276278,  -- Handful of Coins
    276279,  -- Small Bag of Coins
    276280,  -- Hefty Sack of Coins
    276785,  -- Danitha's Satchel
    277534,  -- Arena Spoils
    277651,  -- Bundle of Scrolls
    280567,  -- Small Sack of Gems
    280943,  -- Tome of Tremayne Family Blacksmithing Techniques
    281680,  -- Customer Service Care Package
    284271,  -- Emergency Cache
    284583,  -- Coin Pouch
    284584,  -- Coin Pouch
    284585,  -- Coin Pouch
    284586,  -- Coin Pouch
    285168,  -- Theramore Basic Care Package
    285169,  -- Theramore Standard Care Package
    285170,  -- Theramore Advanced Care Package
    285171,  -- Darkspear Basic Care Package
    285172,  -- Darkspear Standard Care Package
    285173,  -- Darkspear Advanced Care Package
    285366,  -- Whirleygig's Supply Stash
    286210,  -- A Winter Veil Gift
}
for _, id in ipairs(foreverIDs) do openables[id] = {} end

openables[5046] = { lockbox = true }  -- Locked Gift
openables[208838] = { lockbox = true }  -- Dark Iron Lockbox
openables[227937] = { lockbox = true }  -- Puzzle Box

-- These IDs also exist on retail, but only the Forever versions are lockboxes (retail's are plain
-- junk or unopenable), so they stay here rather than in the shared Classic.lua.
openables[6712] = { lockbox = true }  -- Practice Lock (retail: Clockwork Box)
openables[7869] = { lockbox = true }  -- Lucius's Lockbox
openables[24282] = { lockbox = true }  -- Rogue's Diary
