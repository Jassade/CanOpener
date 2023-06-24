local _, CanOpenerGlobal = ...

------------------------------------------------
-- Debug Methods
------------------------------------------------
local debug = true;
local function canOut(msg, premsg)
	if type(message) == "table" then
		canOutTable(message);
	else
		premsg = premsg or "[Can Opener]";
		print("|cC0FFEE69"..premsg.."|r "..msg);
	end
end
CanOpenerGlobal.CanOut = canOut;

local function canOutTable(table, indent, premsg)
    indent = indent or 0
    for key, value in pairs(t) do
        -- Format the indentation
        local formatting = string.rep("  ", indent) .. tostring(key) .. ": "
        
        -- If the value is a table, recursively call canOutTable
        if type(value) == "table" then
            canOut(formatting, premsg)
            printTable(value, indent + 1)
        else
            -- Otherwise, just print the value
            canOut(formatting .. tostring(value), premsg)
        end
    end
end

local function debugLog(message)
    if debug then
		if type(message) == "table" then
			canOutTable(message, nil, "[Can Opener DEBUG]");
		else
			canOut(message,"[Can Opener DEBUG]");
		end
    end
end
CanOpenerGlobal.DebugLog = debugLog;

------------------------------------------------
-- Saved Variable Management
------------------------------------------------
local function initSavedVariables()
	CanOpenerSavedVars = {
		["enable"] = true,
		["rousing"] = true
	};
end
local function resetSavedVariables()
	CanOpenerGlobal.DebugLog("8 - Reset Called");
	initSavedVariables();
	self.frame:SetPoint('CENTER', UIParent, 'CENTER', 0, 0);
	self:OnEvent("UPDATE");
end
CanOpenerGlobal.ResetSavedVariables = resetSavedVariables;

------------------------------------------------
-- Event actions
------------------------------------------------
local function addon_Loaded(addOnName)
	if addOnName == "CanOpener" then
		CanOpenerGlobal.DebugLog("0 - Addon Loaded");
		CanOpenerGlobal.Frame:UnregisterEvent("ADDON_LOADED");
		CanOpenerGlobal.SavedVars = CanOpenerSavedVars or initSavedVariables();
	end
end

local function bag_update()
--	CanOpener:updateBag(...);
end

local function player_entering_world()
	CanOpenerGlobal.DebugLog("Event Called PLAYER_ENTERING_WORLD");
	--CanOpener:TryUpdateButtons();
end

local function player_regen_disabled()
	CanOpenerGlobal.DebugLog("Event Called PLAYER_REGEN_DISABLED");
	CanOpenerGlobal.LockDown = true;
end

local function player_regen_enabled()
	CanOpenerGlobal.DebugLog("Event Called PLAYER_REGEN_ENABLED");
	CanOpenerGlobal.LockDown = false;
end

CanOpenerGlobal.Events = {
    ["ADDON_LOADED"] = addon_Loaded,
    ["BAG_UPDATE"] = bag_update,
    ["PLAYER_ENTERING_WORLD"] = player_entering_world,
    ["PLAYER_REGEN_DISABLED"] = player_regen_disabled,
    ["PLAYER_REGEN_ENABLED"] = player_regen_enabled,
};