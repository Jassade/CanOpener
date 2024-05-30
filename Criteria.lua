local _, CanOpenerGlobal = ...

CriteriaStrategy = {}
CriteriaStrategy.__index = CriteriaStrategy
CriteriaContext = {}
CriteriaContext.__index = CriteriaContext

function CriteriaStrategy:new()
    local instance = {}
    setmetatable(instance, self)
    return instance
end

function CriteriaStrategy:evaluate(cacheDetails, count)
    error("This method should be overridden in the derived class")
end

function CriteriaContext:new(strategies)
    local instance = {
        strategies = strategies or {}
    }
    setmetatable(instance, CriteriaContext)
    return instance
end

function CriteriaContext:evaluateAll(cacheDetails, count)
    for _, strategy in ipairs(self.strategies) do
        if strategy:evaluate(cacheDetails, count) then
            return false
        end
    end
    return true
end

SkipRousingStrategy = setmetatable({}, {__index = CriteriaStrategy})
SkipRousingStrategy.__index = SkipRousingStrategy

function SkipRousingStrategy:new()
    local instance = CriteriaStrategy.new(self)
    return instance
end

function SkipRousingStrategy:evaluate(cacheDetails, count)
    return not CanOpenerSavedVars.showRousing and cacheDetails.isRousing
end

SkipRemixGemsStrategy = setmetatable({}, {__index = CriteriaStrategy})
SkipRemixGemsStrategy.__index = SkipRemixGemsStrategy

function SkipRemixGemsStrategy:new()
    local instance = CriteriaStrategy.new(self)
    return instance
end

function SkipRemixGemsStrategy:evaluate(cacheDetails, count)
    return not CanOpenerSavedVars.showRemixGems and cacheDetails.mopRemixGem
end

SkipRemixEpicGemsStrategy = setmetatable({}, {__index = CriteriaStrategy})
SkipRemixEpicGemsStrategy.__index = SkipRemixEpicGemsStrategy

function SkipRemixEpicGemsStrategy:new()
    local instance = CriteriaStrategy.new(self)
    return instance
end

function SkipRemixEpicGemsStrategy:evaluate(cacheDetails, count)
    return not CanOpenerSavedVars.remixEpicGems and cacheDetails.mopRemixEpicGem
end

ThresholdStrategy = setmetatable({}, {__index = CriteriaStrategy})
ThresholdStrategy.__index = ThresholdStrategy

function ThresholdStrategy:new()
    local instance = CriteriaStrategy.new(self)
    return instance
end

function ThresholdStrategy:evaluate(cacheDetails, count)
    return (cacheDetails.threshold or 1) > count
end

-- Create instances of strategies
local skipRousingStrategy = SkipRousingStrategy:new()
local skipRemixGemsStrategy = SkipRemixGemsStrategy:new()
local skipRemixEpicGemsStrategy = SkipRemixEpicGemsStrategy:new()
local thresholdStrategy = ThresholdStrategy:new()

-- Add strategies to context
local strategies = {
    skipRousingStrategy,
    skipRemixGemsStrategy,
    skipRemixEpicGemsStrategy,
    thresholdStrategy
}

CanOpenerGlobal.CriteriaContext = CriteriaContext:new(strategies)