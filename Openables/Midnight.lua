local _, CanOpenerGlobal = ...
if not CanOpenerGlobal.IsRetail then return end -- Retail-only content; never registered on WoW: Forever
local openables = CanOpenerGlobal.openables

local midnightIDs = {
    237496,  -- Igneous Rock Specimen
    237506,  -- Septarian Nodule
    237507,  -- Cloudy Quartz
    237753,  -- Cache of Timerunning Gear
    238465,  -- Thalassian Phoenix Plume
    238466,  -- Thalassian Phoenix Tail
    238467,  -- Thalassian Phoenix Ember
    238468,  -- Bloomed Bud
    238469,  -- Sweeping Harvester's Scythe
    238470,  -- Simple Leaf Pruners
    238471,  -- Lightbloom Root
    238472,  -- A Spade
    238473,  -- Harvester's Sickle
    238474,  -- Peculiar Lotus
    238475,  -- Planting Shovel
    238531,  -- Radiant Stomach
    238532,  -- Vial of Eversong Oddities
    238533,  -- Vial of Voidstorm Oddities
    238534,  -- Vial of Rootlands Oddities
    238535,  -- Vial of Zul'Aman Oddities
    238536,  -- Freshly Plucked Peacebloom
    238537,  -- Measured Ladle
    238538,  -- Pristine Potion
    238539,  -- Failed Experiment
    238540,  -- Deconstructed Forge Techniques
    238541,  -- Silvermoon Smithing Kit
    238542,  -- Carefully Racked Spear
    238543,  -- Metalworking Cheat Sheet
    238544,  -- Voidstorm Defense Spear
    238545,  -- Rutaani Floratender's Sword
    238546,  -- Sin'dorei Master's Forgemace
    238547,  -- Silvermoon Blacksmith's Hammer
    238548,  -- Enchanted Amani Mask
    238549,  -- Enchanted Sunfire Silk
    238550,  -- Pure Void Crystal
    238551,  -- Everblazing Sunmote
    238552,  -- Entropic Shard
    238553,  -- Primal Essence Orb
    238554,  -- Loa-Blessed Dust
    238555,  -- Sin'dorei Enchanting Rod
    238556,  -- One Engineer's Junk
    238557,  -- Miniaturized Transport Skiff
    238558,  -- Manual of Mistakes and Mishaps
    238559,  -- Expeditious Pylon
    238560,  -- Ethereal Stormwrench
    238561,  -- Offline Helper Bot
    238562,  -- What To Do When Nothing Works
    238563,  -- Handy Wrench
    238564,  -- Ancient Flower
    238565,  -- Dornogal Gardening Scythe
    238566,  -- Earthen Digging Fork
    238567,  -- Fungarian Slicer's Knife
    238568,  -- Arathi Garden Trowel
    238569,  -- Arathi Herb Pruner
    238570,  -- Web-Entangled Lotus
    238571,  -- Tunneler's Shovel
    238572,  -- Void-Touched Quill
    238573,  -- Leather-Bound Techniques
    238574,  -- Spare Ink
    238575,  -- Intrepid Explorer's Marker
    238576,  -- Leftover Sanguithorn Pigment
    238577,  -- Half-Baked Techniques
    238578,  -- Songwriter's Pen
    238579,  -- Songwriter's Quill
    238580,  -- Sin'dorei Masterwork Chisel
    238581,  -- Speculative Voidstorm Crystal
    238582,  -- Dual-Function Magnifiers
    238583,  -- Poorly Rounded Vial
    238584,  -- Shattered Glass
    238585,  -- Vintage Soul Gem
    238586,  -- Ethereal Gem Pliers
    238587,  -- Sin'dorei Gem Faceters
    238588,  -- Amani Leatherworker's Tool
    238589,  -- Ethereal Leatherworking Knife
    238590,  -- Prestigiously Racked Hide
    238591,  -- Bundle of Tanner's Trinkets
    238592,  -- Patterns: Beyond the Void
    238593,  -- Haranir Leatherworking Mallet
    238594,  -- Haranir Leatherworking Knife
    238595,  -- Artisan's Considered Order
    238596,  -- Miner's Guide to Voidstorm
    238597,  -- Spelunker's Lucky Charm
    238598,  -- Lost Voidstorm Satchel
    238599,  -- Solid Ore Punchers
    238600,  -- Glimmering Void Pearl
    238601,  -- Amani Expert's Chisel
    238602,  -- Star Metal Deposit
    238603,  -- Spare Expedition Torch
    238604,  -- Dornogal Carving Knife
    238605,  -- Earthen Worker's Beams
    238606,  -- Artisan's Drawing Knife
    238607,  -- Fungarian's Rich Tannin
    238608,  -- Arathi Tanning Agent
    238609,  -- Arathi Craftsman's Spokeshave
    238610,  -- Nerubian's Slicking Iron
    238611,  -- Carapace Shiner
    238612,  -- A Child's Stuffy
    238613,  -- A Really Nice Curtain
    238614,  -- Sin'dorei Outfitter's Ruler
    238615,  -- Wooden Weaving Sword
    238616,  -- Book of Sin'dorei Stitches
    238617,  -- Satin Throw Pillow
    238618,  -- Particularly Enchanting Tablecloth
    238619,  -- Artisan's Cover Comb
    238625,  -- Fine Void-Tempered Hide
    238626,  -- Mana-Infused Bone
    238627,  -- Manafused Sample
    238628,  -- Lightbloom Afflicted Hide
    238629,  -- Cadre Skinning Knife
    238630,  -- Primal Hide
    238631,  -- Voidstorm Leather Sample
    238632,  -- Amani Tanning Oil
    238633,  -- Sin'dorei Tanning Oil
    238634,  -- Amani Skinning Knife
    238635,  -- Thalassian Skinning Knife
    239077,  -- Mound of Mildly-Meaningful Meat
    241131,  -- Amani Lapis Prism
    241132,  -- Amani Lapis Prism
    241133,  -- Tenebrous Amethyst Prism
    241134,  -- Tenebrous Amethyst Prism
    241135,  -- Sanguine Garnet Prism
    241136,  -- Sanguine Garnet Prism
    241137,  -- Harandar Peridot Prism
    241138,  -- Harandar Peridot Prism
    242650,  -- Box of Rocks
    245644,  -- Box of Rocks
    245647,  -- School of Gems
    245648,  -- School of Gems
    245650,  -- Bouquet of Herbs
    245651,  -- Bouquet of Herbs
    246320,  -- Flicker of Midnight Alchemy Knowledge
    246321,  -- Glimmer of Midnight Alchemy Knowledge
    246322,  -- Flicker of Midnight Blacksmithing Knowledge
    246323,  -- Glimmer of Midnight Blacksmithing Knowledge
    246324,  -- Flicker of Midnight Enchanting Knowledge
    246325,  -- Glimmer of Midnight Enchanting Knowledge
    246326,  -- Flicker of Midnight Engineering Knowledge
    246327,  -- Glimmer of Midnight Engineering Knowledge
    246328,  -- Flicker of Midnight Inscription Knowledge
    246329,  -- Glimmer of Midnight Inscription Knowledge
    246330,  -- Flicker of Midnight Jewelcrafting Knowledge
    246331,  -- Glimmer of Midnight Jewelcrafting Knowledge
    246332,  -- Flicker of Midnight Leatherworking Knowledge
    246333,  -- Glimmer of Midnight Leatherworking Knowledge
    246334,  -- Flicker of Midnight Tailoring Knowledge
    246335,  -- Glimmer of Midnight Tailoring Knowledge
    246585,  -- Artisan's Consortium Payout
    246751,  -- Triumphant Satchel of Champion Dawncrests
    246752,  -- Celebratory Pack of Hero Dawncrests
    246753,  -- Glorious Cluster of Myth Dawncrests
    246754,  -- Pouch of Veteran Dawncrests
    246755,  -- Satchel of Champion Dawncrests
    246756,  -- Pack of Hero Dawncrests
    246805,  -- Package of Remix Rings
    246806,  -- Package of Remix Trinkets
    246807,  -- Package of Remix Necklaces
    250116,  -- Cache of Quel'Thalas Treasures
    250117,  -- Cache of Quel'Thalas Treasures
    250360,  -- Echo of Abundance: Skinning
    250443,  -- Echo of Abundance: Herbalism
    250444,  -- Echo of Abundance: Mining
    250445,  -- Echo of Abundance: Enchanting
    250750,  -- Pouch of Sprouted Clippings
    250753,  -- Bag of Cracked Orebits
    250754,  -- Bag of Wild Skinnings
    250755,  -- Pouch of Mystic Grindings
    250922,  -- Whisper of the Loa: Leatherworking
    250923,  -- Whisper of the Loa: Skinning
    250924,  -- Whisper of the Loa: Mining
    251286,  -- Bundle of Petrified Roots
    251287,  -- Generous Bundle of Petrified Roots
    251321,  -- Collection of Eversong Minerals
    251322,  -- Thalassian Leatherworker's Duffel
    251324,  -- Basket of Eversong Herbs
    251326,  -- Thalassian Enchanter's Purse
    251327,  -- Thalassian Tailor's Tote Bag
    251970,  -- Overflowing Amani Trove
    254677,  -- Apex Cache
    255157,  -- Abyss Angler's Fish Log
    255428,  -- Tolbani's Medicine Satchel
    255666,  -- Huge Bag of Midnight General Goods
    255678,  -- Huge Bag of Midnight Herbs
    255679,  -- Huge Bag of Midnight Minerals
    255682,  -- Huge Bag of Midnight Skins
    255683,  -- Huge Bag of Midnight Jewelcrafting Goods
    255684,  -- Huge Bag of Midnight Leatherworking Goods
    255686,  -- Huge Bag of Midnight Alchemy Goods
    255687,  -- Huge Bag of Midnight Optional Goods
    255689,  -- Huge Bag of Midnight Engineering Goods
    255690,  -- Huge Bag of Midnight Enchanting Goods
    255691,  -- Huge Bag of Midnight Tailoring Goods
    255703,  -- Huge Bag of Midnight Blacksmithing Goods
    255704,  -- Huge Bag of Midnight Inscription Goods
    256055,  -- Overflowing Hara'ti Trove
    257023,  -- Preyseeker's Adventurer Chest
    257026,  -- Preyseeker's Veteran Chest
    257599,  -- Skill Issue: Jewelcrafting
    257600,  -- Skill Issue: Enchanting
    257601,  -- Skill Issue: Tailoring
    257603,  -- Primalist Weapon
    258279,  -- [DNT] Big Pouch of Supplies
    258410,  -- Traditions of the Haranir: Herbalism
    258411,  -- Traditions of the Haranir: Inscription
    258534,  -- Illustrious Contender's Strongbox
    258620,  -- Field Medic's Hazard Payout
    258839,  -- Concealed Catalogue
    259086,  -- Void-Touched Satchel of Cooperation
    259188,  -- Lightbloomed Spore Sample
    259189,  -- Aged Cruor
    259190,  -- Thalassian Whestone
    259191,  -- Infused Quenching Oil
    259192,  -- Voidstorm Ashes
    259193,  -- Lost Thalassian Vellum
    259194,  -- Dance Gear
    259195,  -- Dawn Capacitor
    259196,  -- Brilliant Phoenix Ink
    259197,  -- Loa-Blessed Rune
    259198,  -- Void-Touched Eversong Diamond Fragments
    259199,  -- Harandar Stone Sample
    259200,  -- Amani Tanning Oil
    259201,  -- Thalassian Mana Oil
    259202,  -- Embroidered Memento
    259203,  -- Finely Woven Lynx Collar
    259334,  -- Overflowing Singularity Trove
    260173,  -- Crystallized Dawnlight Manaflux
    260193,  -- Fabled Veteran's Cache
    260534,  -- Master Alchemist's Surplus Reagents
    260536,  -- Master Smith's Surplus Reagents
    260537,  -- Master Enchanter's Surplus Reagents
    260538,  -- Master Engineer's Surplus Reagents
    260539,  -- Master Herbalist's Surplus Reagents
    260540,  -- Master Scribe's Surplus Reagents
    260541,  -- Master Jewelcrafter's Surplus Reagents
    260542,  -- Master Leatherworker's Surplus Reagents
    260543,  -- Master Miner's Surplus Reagents
    260544,  -- Master Skinner's Surplus Reagents
    260545,  -- Master Tailor's Surplus Reagents
    260940,  -- Victorious Stormarion Pinnacle Cache
    260979,  -- Victorious Stormarion Cache
    262346,  -- Preyseeker's Champion Chest
    262349,  -- Satchel of Compensation
    262432,  -- Weathered Lockbox
    262596,  -- Preyseeker's Satchel of Voidlight Marl
    262622,  -- Preyseeker's Satchel of Coffer Key Shards
    262623,  -- Preyseeker's Satchel of Adventurer Dawncrests
    262624,  -- Preyseeker's Satchel of Anguish
    262626,  -- Preyseeker's Box of Anguish
    262627,  -- Preyseeker's Box of Coffer Key Shards
    262629,  -- Preyseeker's Box of Veteran Dawncrests
    262630,  -- Preyseeker's Box of Voidlight Marl
    262631,  -- Preyseeker's Cache of Anguish
    262632,  -- Preyseeker's Cache of Coffer Key Shards
    262633,  -- Preyseeker's Cache of Champion Dawncrests
    262634,  -- Preyseeker's Cache of Voidlight Marl
    262635,  -- Cache of Delver's Spoils
    262644,  -- Beyond the Event Horizon: Blacksmithing
    262645,  -- Beyond the Event Horizon: Alchemy
    262646,  -- Beyond the Event Horizon: Engineering
    262658,  -- Nebulous Voidcache: Midnight Falls
    262662,  -- Thalassian Distinguishment
    262928,  -- Preyseeker's Adventurer Sack
    262936,  -- Preyseeker's Veteran Sack
    262938,  -- Preyseeker's Champion Sack
    263178,  -- Delver's Starter Kit
    263179,  -- Delver's Cosmetic Surprise Bag
    263400,  -- Cache of Delver's Spoils
    263433,  -- Overflowing Silvermoon Trove
    263454,  -- Thalassian Alchemist's Notebook
    263455,  -- Thalassian Blacksmith's Journal
    263456,  -- Thalassian Engineer's Notepad
    263457,  -- Thalassian Scribe's Journal
    263458,  -- Thalassian Jewelcrafter's Notebook
    263459,  -- Thalassian Leatherworker's Journal
    263460,  -- Thalassian Tailor's Notebook
    263461,  -- Thalassian Skinner's Notes
    263462,  -- Thalassian Herbalist's Notes
    263463,  -- Thalassian Miner's Notes
    263464,  -- Thalassian Enchanter's Folio
    263465,  -- Surplus Bag of Party Favors
    263466,  -- Overflowing Abundant Satchel
    263467,  -- Avid Learner's Supply Pack
    263468,  -- Stormarion Spoils
    263710,  -- Primalist Plate Helm
    263711,  -- Primalist Cloth Helm
    263712,  -- Primalist Mail Helm
    263713,  -- Primalist Leather Helm
    263714,  -- Primalist Trinket
    263715,  -- Primalist Plate Chestpiece
    263716,  -- Primalist Cloth Chestpiece
    263717,  -- Primalist Mail Chestpiece
    263718,  -- Primalist Leather Chestpiece
    263719,  -- Primalist Leather Leggings
    263720,  -- Primalist Mail Leggings
    263721,  -- Primalist Cloth Leggings
    263722,  -- Primalist Plate Leggings
    263724,  -- Primalist Plate Spaulders
    263725,  -- Primalist Cloth Spaulders
    263726,  -- Primalist Mail Spaulders
    263727,  -- Primalist Leather Spaulders
    263728,  -- Primalist Leather Bracers
    263729,  -- Primalist Mail Bracers
    263730,  -- Primalist Cloth Bracers
    263731,  -- Primalist Plate Bracers
    263732,  -- Primalist Plate Belt
    263733,  -- Primalist Cloth Belt
    263740,  -- Primalist Mail Belt
    263776,  -- Primalist Leather Belt
    263822,  -- Primalist Leather Boots
    263859,  -- Primalist Mail Boots
    263861,  -- Primalist Plate Boots
    263862,  -- Primalist Cloth Boots
    263863,  -- Primalist Cloth Gloves
    263864,  -- Primalist Plate Gloves
    263865,  -- Primalist Mail Gloves
    263866,  -- Primalist Leather Gloves
    263867,  -- Primalist Cloak
    263868,  -- Primalist Ring
    263869,  -- Primalist Necklace
    263928,  -- Cache of Void-Touched Armaments
    263929,  -- Cache of Void-Touched Armaments
    263934,  -- Chest of Gold
    263976,  -- Bundle of Adventurer Dawncrests
    263977,  -- Venerable Satchel of Veteran Dawncrests
    264274,  -- Fabled Adventurer's Cache
    264314,  -- Cache of Void-Touched Headgear
    264315,  -- Cache of Void-Touched Shoulderwear
    264316,  -- Cache of Void-Touched Cloaks
    264317,  -- Cache of Void-Touched Chestpieces
    264318,  -- Cache of Void-Touched Bracers
    264319,  -- Cache of Void-Touched Gloves
    264320,  -- Cache of Void-Touched Belts
    264321,  -- Cache of Void-Touched Legwear
    264322,  -- Cache of Void-Touched Boots
    264323,  -- Cache of Void-Touched Weapons
    264470,  -- Ash-Tied Offering
    264475,  -- Umbral Tin Lockbox
    264587,  -- Ani's Trinket Bag
    264652,  -- Delver's Pouch of Voidlight Marl
    264914,  -- Ranger's Cache
    264972,  -- Voidstorm Victuals
    264988,  -- Endgame Essentials
    265995,  -- Quel'Thalas Adventurer's Cache
    267299,  -- Slayer's Duellum Trove
    267653,  -- Glimmering Powder
    267654,  -- Swirling Arcane Essence
    267655,  -- Brimming Mana Shard
    268297,  -- Rattling Bag o' Gold
    268485,  -- Victorious Stormarion Pinnacle Cache
    268487,  -- Avid Learner's Supply Pack
    268488,  -- Overflowing Abundant Satchel
    268489,  -- Surplus Bag of Party Favors
    268490,  -- Apex Cache
    268545,  -- Aspiring Preyseeker's Chest
    269005,  -- Preyseeker's Glinting Coin Pouch
    269006,  -- Preyseeker's Gleaming Coin Pouch
    269007,  -- Preyseeker's Glittering Coin Pouch
    269029,  -- Bag of Totally Legitimate Amani Goods
    269234,  -- Overflowing Ritual Site Cache
    269701,  -- Surplus Bag of Party Favors
    269702,  -- Overflowing Abundant Satchel
    269703,  -- Avid Learner's Supply Pack
    269704,  -- Victorious Stormarion Cache
    269768,  -- Nebulous Voidcache: Prey
    269856,  -- Bundle of Adventurer Mistcrests
    269857,  -- Satchel of Champion Mistcrests
    269858,  -- Pack of Hero Mistcrests
    269859,  -- Pouch of Veteran Mistcrests
    269864,  -- Triumphant Satchel of Champion Mistcrests
    269865,  -- Celebratory Pack of Hero Mistcrests
    269866,  -- Glorious Cluster of Myth Mistcrests
    269867,  -- Venerable Satchel of Veteran Mistcrests
    270244,  -- Field Pouch
    270247,  -- Field Satchel
    270431,  -- Haranir Footlocker
    270932,  -- Wriggling Field Pouch
    270933,  -- Bulging Field Pouch
    270934,  -- Recruit's Field Pouch
    270987,  -- Recruit's Field Satchel
    271221,  -- Wriggling Recruit's Field Pouch
    271222,  -- Bulging Recruit's Field Pouch
    272125,  -- Recruit's Cache
    273152,  -- Delve Gearbox
    273153,  -- Delve Gearbox
    273154,  -- Delve Gearbox
    273155,  -- Delve Gearbox
    273156,  -- Delve Gearbox
    274069,  -- Warbound Pack of Hero Dawncrests
    274070,  -- Warbound Pack of Champion Dawncrests
    274071,  -- Warbound Pack of Veteran Dawncrests
    274372,  -- Big ol' Bag of Polished Pet Charms
    274421,  -- Crate of Community Coupons
    274465,  -- Aggitated Crate of Zandalari Fury
    274578,  -- Offering of Unalloyed Abundance
    274707,  -- Crystallized Venomblight Manaflux
    274708,  -- Nebulous Voidcache: Nymrissa Wavecaller
    274713,  -- Cache of Amani Treasures
    274714,  -- Cache of Amani Treasures
    275228,  -- Nebulous Voidcache: Rotmire
    275690,  -- Riftstalker's Cache
    275691,  -- Riftstalker's Overflowing Cache
    275726,  -- Preyhunter's Champion Chest
    275728,  -- Preyhunter's Champion Sack
    275822,  -- Preyhunter's Veteran Chest
    275899,  -- Venom-Soaked Satchel
    275911,  -- Venom-Covered Chest
    275917,  -- Preyhunter's Veteran Sack
    275918,  -- Preyhunter's Adventurer Chest
    275919,  -- Preyhunter's Adventurer Sack
    275978,  -- Delver's Starter Kit
    275986,  -- Delver's Cosmetic Surprise Bag
    276104,  -- Aspiring Preyhunter's Chest
    276378,  -- Cache of Void-Touched Armaments: Boots
    276379,  -- Cache of Void-Touched Armaments: Legs
    276380,  -- Cache of Void-Touched Armaments: Belts
    276381,  -- Cache of Void-Touched Armaments: Gloves
    276382,  -- Cache of Void-Touched Armaments: Bracers
    276383,  -- Cache of Void-Touched Armaments: Chest
    276384,  -- Cache of Void-Touched Armaments: Cloak
    276385,  -- Cache of Void-Touched Armaments: Shoulder
    276386,  -- Cache of Void-Touched Armaments: Head
    276387,  -- Riftstalker's Favor
    276388,  -- Riftstalker's Overflowing Favor
    276389,  -- Riftstalker's Prize
    276390,  -- Riftstalker's Overflowing Prize
    276536,  -- Corrosive Reticule
    276624,  -- Overflowing Hash'ura Trove
    277124,  -- Warbound Cache of Void-Touched Armaments
    277125,  -- Cache of Void-Touched Armaments: Weapons
    277126,  -- Cache of Void-Touched Armaments: Necklaces
    277127,  -- Cache of Void-Touched Armaments: Rings
    277137,  -- Wriggling Venom-Soaked Satchel
    277157,  -- Barnacle-Encrusted Chest
    277937,  -- Balanced Offering
    277938,  -- Virulent Offering
    277939,  -- Volatile Offering
    277940,  -- Fragile Offering
    277941,  -- Eerie Offering
    277942,  -- Odious Offering
    277943,  -- Pestilent Offering
    277944,  -- Phlegmatic Offering
    277945,  -- Melancholic Offering
    277946,  -- Choleric Offering
    277975,  -- Arcanostorage Sphere
    278004,  -- Warbound Cache of Void-Touched Armaments: Boots
    278005,  -- Warbound Cache of Void-Touched Armaments: Legs
    278006,  -- Warbound Cache of Void-Touched Armaments: Belts
    278007,  -- Warbound Cache of Void-Touched Armaments: Gloves
    278008,  -- Warbound Cache of Void-Touched Armaments: Bracers
    278009,  -- Warbound Cache of Void-Touched Armaments: Chest
    278010,  -- Warbound Cache of Void-Touched Armaments: Cloak
    278011,  -- Warbound Cache of Void-Touched Armaments: Shoulder
    278012,  -- Warbound Cache of Void-Touched Armaments: Head
    278013,  -- Warbound Cache of Void-Touched Armaments: Weapons
    278014,  -- Warbound Cache of Void-Touched Armaments: Necklaces
    278015,  -- Warbound Cache of Void-Touched Armaments: Rings
    278021,  -- Bulging Elven Field Pouch
    278022,  -- Bulging Amani Field Pouch
    278024,  -- Bulging Naga Field Pouch
    278025,  -- Bulging Twilight Field Pouch
    278026,  -- Bulging Ethereal Pack
    278027,  -- Bulging Winter Pack
    278035,  -- Ornate Healing Potion
    278084,  -- Handful of Esoteric Ingredients
    278283,  -- Nebulous Voidcache: Entombed Sentinels
    278284,  -- Nebulous Voidcache: Ula'tek
    278285,  -- Nebulous Voidcache: Soulcoiler Nek'zali
    278286,  -- Nebulous Voidcache: Tortollan Explorers
    278287,  -- Nebulous Voidcache: Vashnik
    278288,  -- Nebulous Voidcache: Sszorak
    278289,  -- Nebulous Voidcache: The Twin Fangs
    278290,  -- Nebulous Voidcache: The Coiled Altar
    278329,  -- Thalassian Recipe in a Bottle
    279092,  -- Anguish-Touched Pouch
    279284,  -- Nebulous Voidcache: Delver's Trove
    279287,  -- Corroded Pouch
    279288,  -- Corroded Satchel
    279345,  -- Venom-Drenched Sack
    279520,  -- Fabled Veteran's Cache
    279522,  -- Surplus Bag of Party Favors
    279523,  -- Overflowing Abundant Satchel
    279525,  -- Avid Learner's Supply Pack
    279526,  -- Victorious Stormarion Pinnacle Cache
    279527,  -- Apex Cache
    279574,  -- Preyhunter's Hero Chest
    279618,  -- Nebulous Voidcache: Altar of Fangs
    279619,  -- Nebulous Voidcache: The Blinding Vale
    279620,  -- Nebulous Voidcache: Den of Nalorakk
    279621,  -- Nebulous Voidcache: Kings' Rest
    279622,  -- Nebulous Voidcache: Ruby Life Pools
    279623,  -- Nebulous Voidcache: Murder Row
    279624,  -- Nebulous Voidcache:Temple of Sethraliss
    279625,  -- Nebulous Voidcache: Voidscar Arena
    280131,  -- Nebulous Voidcache: Prey
    280136,  -- Gift of the Soulmates
    280458,  -- Delver's Corroded Pouch of Undercoin
    280732,  -- Warbound Pack of Hero Mistcrests
    280734,  -- Warbound Pack of Champion Mistcrests
    280737,  -- Warbound Pack of Veteran Mistcrests
    280781,  -- Cache of Void-Touched Armaments
    280782,  -- Cache of Void-Touched Armaments: Boots
    280783,  -- Cache of Void-Touched Armaments: Legs
    280784,  -- Cache of Void-Touched Armaments: Belts
    280785,  -- Cache of Void-Touched Armaments: Gloves
    280786,  -- Cache of Void-Touched Armaments: Bracers
    280787,  -- Cache of Void-Touched Armaments: Chest
    280788,  -- Cache of Void-Touched Armaments: Cloak
    280789,  -- Cache of Void-Touched Armaments: Shoulder
    280790,  -- Cache of Void-Touched Armaments: Head
    280791,  -- Cache of Void-Touched Armaments: Weapons
    280792,  -- Cache of Void-Touched Armaments: Necklaces
    280793,  -- Cache of Void-Touched Armaments: Rings
    281223,  -- Satchel of Corrosive Coins
    281405,  -- Cache of Void-Touched Armaments: Boots
    281406,  -- Cache of Void-Touched Armaments: Legs
    281407,  -- Cache of Void-Touched Armaments: Belts
    281408,  -- Cache of Void-Touched Armaments: Gloves
    281409,  -- Cache of Void-Touched Armaments: Bracers
    281410,  -- Cache of Void-Touched Armaments: Chest
    281411,  -- Cache of Void-Touched Armaments: Cloak
    281412,  -- Cache of Void-Touched Armaments: Shoulder
    281413,  -- Cache of Void-Touched Armaments: Head
    281414,  -- Cache of Void-Touched Armaments: Weapons
    281415,  -- Cache of Void-Touched Armaments: Necklaces
    281416,  -- Cache of Void-Touched Armaments: Rings
    281417,  -- Cache of Void-Touched Armaments: Boots
    281418,  -- Cache of Void-Touched Armaments: Legs
    281419,  -- Cache of Void-Touched Armaments: Belts
    281420,  -- Cache of Void-Touched Armaments: Gloves
    281421,  -- Cache of Void-Touched Armaments: Bracers
    281422,  -- Cache of Void-Touched Armaments: Chest
    281423,  -- Cache of Void-Touched Armaments: Cloak
    281424,  -- Cache of Void-Touched Armaments: Shoulder
    281425,  -- Cache of Void-Touched Armaments: Head
    281426,  -- Cache of Void-Touched Armaments: Weapons
    281427,  -- Cache of Void-Touched Armaments: Necklaces
    281428,  -- Cache of Void-Touched Armaments: Rings
    281429,  -- Cache of Void-Touched Armaments
    282183,  -- Fabled Coiled Isle Veteran's Cache
}
for _, id in ipairs(midnightIDs) do openables[id] = {} end

openables[245755] = {questId = 95127 } -- Thalassian Treatise on Alchemy
openables[245756] = {questId = 95137 } -- Thalassian Treatise on Tailoring
openables[245757] = {questId = 95131 } -- Thalassian Treatise on Inscription
openables[245758] = {questId = 95134 } -- Thalassian Treatise on Leatherworking
openables[245759] = {questId = 95129 } -- Thalassian Treatise on Enchanting
openables[245760] = {questId = 95133 } -- Thalassian Treatise on Jewelcrafting
openables[245761] = {questId = 95130 } -- Thalassian Treatise on Herbalism
openables[245762] = {questId = 95135 } -- Thalassian Treatise on Mining
openables[245763] = {questId = 95128 } -- Thalassian Treatise on Blacksmithing
openables[245809] = {questId = 95138 } -- Thalassian Treatise on Engineering
openables[245828] = {questId = 95136 } -- Thalassian Treatise on Skinning
openables[246447] = { threshold = 5 }  -- Apprentice's Scribbles
openables[246448] = { threshold = 5 }  -- Artisan's Ledger
openables[246449] = { threshold = 5 }  -- Mentor's Helpful Handiwork
openables[247719] = { threshold = 5 }  -- Multicraft Matrix
openables[247725] = { threshold = 5 }  -- Resourceful Rebar
openables[260630] = { threshold = 5 }  -- Ingenious Identifier
openables[268650] = { threshold = 5 }  -- Ascendant Voidshard
openables[262798] = { threshold = 20 }  -- Stranded Glimmerline
openables[264506] = { threshold = 5 }  -- Stormarion Fragment
openables[279576] = { threshold = 4 }  -- Void Vestige
openables[274500] = { questId = 96459 }  -- Demystifyin': Alchemy
openables[274507] = { questId = 96517 }  -- Demystifyin': Leatherworking
openables[274508] = { questId = 96519 }  -- Demystifyin': Skinning
openables[274509] = { questId = 96518 }  -- Demystifyin': Mining
openables[274510] = { questId = 96516 }  -- Demystifyin': Jewelcrafting
openables[274511] = { questId = 96512 }  -- Demystifyin': Enchanting
openables[274512] = { questId = 96520 }  -- Demystifyin': Tailoring
openables[274513] = { questId = 96514 }  -- Demystifyin': Herbalism
openables[274514] = { questId = 96515 }  -- Demystifyin': Inscription
openables[274515] = { questId = 96511 }  -- Demystifyin': Blacksmithing
openables[274516] = { questId = 96513 }  -- Demystifyin': Engineering
