local _, CanOpenerGlobal = ...
-- WoW: Forever only. Vanilla-era items that also exist on Forever (same item IDs) live in
-- Classic.lua, which loads on both flavors; this file is for items that only exist on Forever.
if not CanOpenerGlobal.IsForever then return end
local openables = CanOpenerGlobal.openables

local foreverIDs = {
}
for _, id in ipairs(foreverIDs) do openables[id] = {} end
