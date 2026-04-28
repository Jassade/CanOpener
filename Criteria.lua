local _, CanOpenerGlobal = ...

local function createStrategy(filterFn)
    return { shouldFilter = filterFn }
end

local CriteriaContext = {}
CriteriaContext.__index = CriteriaContext

function CriteriaContext:evaluateAll(itemID, cacheDetails, count)
    for _, strategy in ipairs(self.strategies) do
        if strategy.shouldFilter(itemID, cacheDetails, count) then
            return false
        end
    end
    return true
end

-- Define filter strategies
local skipRousing = createStrategy(function(itemID, cacheDetails, count)
    return not CanOpenerSavedVars.showRousing and cacheDetails.isRousing
end)

local threshold = createStrategy(function(itemID, cacheDetails, count)
    return (cacheDetails.threshold or 1) > count
end)

local levelRequirement = createStrategy(function(itemID, cacheDetails, count)
    local _,_,_,_,itemMinLevel = C_Item.GetItemInfo(itemID)
    if not itemMinLevel then
        return false
    end
    CanOpenerGlobal.DebugLog("LevelRequirement - itemMinLevel: " .. tostring(itemMinLevel) .. ", playerLevel: " .. tostring(UnitLevel("player")))
    return not CanOpenerSavedVars.showLevelRestrictedItems and itemMinLevel > UnitLevel("player")
end)

local questTimeGate = createStrategy(function(itemID, cacheDetails, count)
    return cacheDetails.questId and C_QuestLog.IsQuestFlaggedCompleted(cacheDetails.questId)
end)

-- 1804 = Pick Lock (Rogue), 312916 = Skeleton Pinkie (Mechagnome)
local lockbox = createStrategy(function(itemID, cacheDetails, count)
    if not cacheDetails.lockbox then return false end
    if CanOpenerSavedVars.showLockboxes then return false end
    return not (IsSpellKnown(1804) or IsSpellKnown(312916))
end)

-- Build strategy list
local strategies = { skipRousing, threshold, levelRequirement, questTimeGate, lockbox }

-- Drain event-registered strategies
for _, entry in ipairs(CanOpenerGlobal._eventStrategies) do
    table.insert(strategies, createStrategy(entry.filterFn))
end

CanOpenerGlobal.CriteriaContext = setmetatable({ strategies = strategies }, CriteriaContext)
