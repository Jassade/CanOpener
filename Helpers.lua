local _, CanOpenerGlobal = ...
local playerEnteredWorld = false;
local shouldUpdateBags = false;
local addonName = "Can Opener";

------------------------------------------------
-- Debug Methods
------------------------------------------------
local canOut;
local canOutTable;

canOut = function(msg, premsg)
	premsg = premsg or "[Can Opener]";
	if type(msg) == "table" then
		canOutTable(msg, nil, premsg);
	else
		print("|cC0FFEE69" .. premsg .. "|r " .. msg);
	end
end
CanOpenerGlobal.CanOut = canOut;

canOutTable = function(table, indent, premsg)
	indent = indent or 0
	for key, value in pairs(table) do
		-- Format the indentation
		local formatting = string.rep("  ", indent) .. tostring(key) .. ": "

		-- If the value is a table, recursively call canOutTable
		if type(value) == "table" then
			canOut(formatting, premsg)
			canOutTable(value, indent + 1, premsg)
		else
			-- Otherwise, just print the value
			canOut(formatting .. tostring(value), premsg)
		end
	end
end

local function debugLog(...)
	if CanOpenerSavedVars and CanOpenerSavedVars.debugMode and DLAPI then DLAPI.DebugLog(addonName, ...) end
end
CanOpenerGlobal.DebugLog = debugLog;

local colorName = {
	LIGHTBLUE = 1,
	LIGHTRED = 2,
	SPRINGGREEN = 3,
	GREENYELLOW = 4,
	BLUE = 5,
	PURPLE = 6,
	GREEN = 7,
	RED = 8,
	GOLD = 9,
	GOLD2 = 10,
	GREY = 11,
	WHITE = 12,
	SUBWHITE = 13,
	MAGENTA = 14,
	YELLOW = 15,
	ORANGEY = 16,
	CHOCOLATE = 17,
	CYAN = 18,
	IVORY = 19,
	LIGHTYELLOW = 20,
	SEXGREEN = 21,
	SEXTEAL = 22,
	SEXPINK = 23,
	SEXBLUE = 24,
	SEXHOTPINK = 25,
	CANOPENERBUMBER = 26
};
CanOpenerGlobal.ColorName = colorName;

local colors = {
	[colorName.LIGHTBLUE] = 'ff00ccff',
	[colorName.LIGHTRED] = 'ffff6060',
	[colorName.SPRINGGREEN] = 'ff00FF7F',
	[colorName.GREENYELLOW] = 'ffADFF2F',
	[colorName.BLUE] = 'ff0000ff',
	[colorName.PURPLE] = 'ffDA70D6',
	[colorName.GREEN] = 'ff00ff00',
	[colorName.RED] = 'ffff0000',
	[colorName.GOLD] = 'ffffcc00',
	[colorName.GOLD2] = 'ffFFC125',
	[colorName.GREY] = 'ff888888',
	[colorName.WHITE] = 'ffffffff',
	[colorName.SUBWHITE] = 'ffbbbbbb',
	[colorName.MAGENTA] = 'ffff00ff',
	[colorName.YELLOW] = 'ffffff00',
	[colorName.ORANGEY] = 'ffFF4500',
	[colorName.CHOCOLATE] = 'ffCD661D',
	[colorName.CYAN] = 'ff00ffff',
	[colorName.IVORY] = 'ff8B8B83',
	[colorName.LIGHTYELLOW] = 'ffFFFFE0',
	[colorName.SEXGREEN] = 'ff71C671',
	[colorName.SEXTEAL] = 'ff388E8E',
	[colorName.SEXPINK] = 'ffC67171',
	[colorName.SEXBLUE] = 'ff00E5EE',
	[colorName.SEXHOTPINK] = 'ffFF6EB4',
	[colorName.CANOPENERBUMBER] = 'c0ffee69'
};

local function colorizeText(text, color)
	return "|c" .. colors[color] .. text .. "|r";
end
CanOpenerGlobal.ColorizeText = colorizeText;

local function posOrNegColor(test, positiveText, negativeText)
    local color = test and CanOpenerGlobal.ColorName.SPRINGGREEN or CanOpenerGlobal.ColorName.LIGHTRED
    local text = test and positiveText or negativeText
    return colorizeText(text, color)
end
CanOpenerGlobal.PosOrNegColor = posOrNegColor;

------------------------------------------------
-- Saved Variable Management
------------------------------------------------
local function initSavedVariables()
	CanOpenerSavedVars = {
		enable = true,
		showRousing = true,
		isRemixActive = false,
		showRemixGems = true,
		remixEpicGems = true,
		debugMode = false,
		position = { "CENTER", "CENTER", 0, 0 },
	};
end
local function resetSavedVariables()
	debugLog(CanOpenerGlobal.Frame);
	CanOpenerGlobal.DebugLog("resetSavedVariables - Start");
	initSavedVariables();
	CanOpenerGlobal.DebugLog(CanOpenerSavedVars);
	CanOpenerGlobal.Frame:Hide();
	CanOpenerGlobal.Frame:Show();
	CanOpenerGlobal.ForceButtonRefresh();
	CanOpenerGlobal.DebugLog("resetSavedVariables - End");
end
CanOpenerGlobal.ResetSavedVariables = resetSavedVariables;

------------------------------------------------
-- Event actions
------------------------------------------------
local function addon_Loaded(addOnName)
	CanOpenerGlobal.DebugLog("resetSavedVariables - Start");
	if addOnName == "CanOpener" then
		CanOpenerGlobal.DebugLog("0 - Addon Loaded");
		CanOpenerGlobal.Frame:UnregisterEvent("ADDON_LOADED");
		CanOpenerGlobal.SavedVars = CanOpenerSavedVars or initSavedVariables();
	end
	CanOpenerGlobal.DebugLog("resetSavedVariables - End");
end

local function bag_update(bagID)
	CanOpenerGlobal.DebugLog("bag_update - Start");
	CanOpenerGlobal.DebugLog("bag_update - bagID " .. bagID);
	if (CanOpenerGlobal.BagIndicies.Backpack <= bagID and bagID <= CanOpenerGlobal.BagIndicies.ReagentBag) then
		shouldUpdateBags = true;
	end
	CanOpenerGlobal.DebugLog("bag_update - End");
end

local function bag_update_delayed()
	CanOpenerGlobal.DebugLog("bag_update_delayed - Start");
	if not CanOpenerGlobal.LockDown then
		if shouldUpdateBags then
			shouldUpdateBags = false;
			CanOpenerGlobal.UpdateButtons();
		end
		CanOpenerGlobal.DrawButtons()
	end
	CanOpenerGlobal.DebugLog("bag_update_delayed - End");
end

local function player_entering_world(isInitialLogin, isReloadingUi)
	CanOpenerGlobal.DebugLog("player_entering_world - Start");
	CanOpenerGlobal.DebugLog(
		"player_entering_world - isInitialLogin " ..
		tostring(isInitialLogin) .. " | isReloadingUi " .. tostring(isReloadingUi));

	CanOpenerGlobal.Frame:Show();
	playerEnteredWorld = true;
	CanOpenerGlobal.DebugLog("player_entering_world - End");
end

local function player_leaving_world()
	CanOpenerGlobal.DebugLog("player_leaving_world - Start");
	playerEnteredWorld = false;
	CanOpenerGlobal.DebugLog("player_leaving_world - End");
end

local function player_regen_disabled()
	CanOpenerGlobal.DebugLog("player_regen_disabled - Start");
	CanOpenerGlobal.Frame:Hide();
	CanOpenerGlobal.LockDown = true;
	CanOpenerGlobal.DebugLog("player_regen_disabled - End");
end

local function player_regen_enabled()
	CanOpenerGlobal.DebugLog("player_regen_enabled - Start");
	CanOpenerGlobal.LockDown = false;
	bag_update_delayed();
	CanOpenerGlobal.Frame:Show();
	CanOpenerGlobal.DebugLog("player_regen_enabled - End");
end

CanOpenerGlobal.Events = {
	["ADDON_LOADED"] = addon_Loaded,
	["BAG_UPDATE"] = bag_update,
	["BAG_UPDATE_DELAYED"] = bag_update_delayed,
	["PLAYER_ENTERING_WORLD"] = player_entering_world,
	["PLAYER_LEAVING_WORLD"] = player_leaving_world,
	["PLAYER_REGEN_DISABLED"] = player_regen_disabled,
	["PLAYER_REGEN_ENABLED"] = player_regen_enabled,
};

CanOpenerGlobal.ForceButtonRefresh = function()
	shouldUpdateBags = true;
	bag_update_delayed();
end
------------------------------------------------
-- Enums
------------------------------------------------
CanOpenerGlobal.BagIndicies = {
	["Backpack"] = 0,
	["Bag_1"] = 1,
	["Bag_2"] = 2,
	["Bag_3"] = 3,
	["Bag_4"] = 4,
	["ReagentBag"] = 5,
};
