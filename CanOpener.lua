local _, CanOpenerGlobal = ...;
local buttons = {};
local buttonQueue = {};
local itemIDsInQueue = {};

------------------------------------------------
-- Slash Commands
------------------------------------------------
local function slashHandler(msg)
	CanOpenerGlobal.DebugLog("slashHandler - Start");
	local command, rest = msg:match("^(%S*)%s*(.-)$") -- Extract the first word (command) and the rest of the string (parameters)
	command = command:lower()                      -- Convert the command to lowercase to make comparison case-insensitive
	CanOpenerGlobal.DebugLog("slashHandler - Command " .. command);

	if (command == "rousing") then
		CanOpenerGlobal.DebugLog("slashHandler - Start Rousing");
		CanOpenerSavedVars.showRousing = not CanOpenerSavedVars.showRousing;
		CanOpenerGlobal.ForceButtonRefresh();
		CanOpenerGlobal.CanOut(": Elemental Rousings " .. CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.showRousing, "will", "will not") .. " be shown");
		CanOpenerGlobal.DebugLog("slashHandler - End Rousing");
	elseif (CanOpenerGlobal.remixActive and command == "remixgem") then
		CanOpenerGlobal.DebugLog("slashHandler - Start Remix Gems");
		CanOpenerSavedVars.showRemixGems = not CanOpenerSavedVars.showRemixGems;
		CanOpenerGlobal.ForceButtonRefresh();
		CanOpenerGlobal.CanOut(": Remix Gems " .. CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.showRemixGems, "will", "will not") .. " be shown");
		CanOpenerGlobal.DebugLog("slashHandler - End Remix Gems");
	elseif (CanOpenerGlobal.remixActive and command == "remixepicgems") then
		CanOpenerGlobal.DebugLog("slashHandler - Start Remix Gem Level");
		CanOpenerSavedVars.remixEpicGems = not CanOpenerSavedVars.remixEpicGems;
		CanOpenerGlobal.ForceButtonRefresh();
		CanOpenerGlobal.CanOut(": Remix Gems " .. CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.remixEpicGems, "will", "will not") .. " be combined higher than Epic");
		CanOpenerGlobal.DebugLog("slashHandler - End Remix Gems Level");
	elseif (command == "reset") then
		CanOpenerGlobal.DebugLog("slashHandler - Start Reset");
		CanOpenerGlobal.CanOut(": Resetting settings and position.");
		CanOpenerGlobal.ResetSavedVariables();
		CanOpenerGlobal.DebugLog("slashHandler - End Reset");
	elseif (command == "debug") then
		CanOpenerGlobal.DebugLog("slashHandler - Start Debug");
		CanOpenerGlobal.CanOut(": Turning Debug Mode " .. (CanOpenerSavedVars.debugMode and "off" or "on") .. ".");
		CanOpenerSavedVars.debugMode = not CanOpenerSavedVars.debugMode;
		CanOpenerGlobal.ResetSavedVariables();
		CanOpenerGlobal.DebugLog("slashHandler - End Reset");
	else
		CanOpenerGlobal.DebugLog("slashHandler - Unknown command " .. (command or "<None>"));
		CanOpenerGlobal.CanOut("Commands for |cffffa500/CanOpener|r :");
		local rousingState = CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.showRousing, "On", "Off");
		CanOpenerGlobal.CanOut("  |cffffa500 rousing|r - Toggle showing Elemental Rousings (" .. rousingState .. ")");
		if(CanOpenerGlobal.remixActive) then
			local remixGemsState = CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.showRemixGems, "On", "Off");
			CanOpenerGlobal.CanOut("  |cffffa500 remixGem|r - Toggle showing Remix Gems (" .. remixGemsState .. ")");
			local remixEpicGemsState = CanOpenerGlobal.PosOrNegColor(CanOpenerSavedVars.remixEpicGems, "On", "Off");
			CanOpenerGlobal.CanOut("  |cffffa500 remixEpicGems|r - Toggle combining gems higher than Epic (" .. remixEpicGemsState .. ")");
		end
		CanOpenerGlobal.CanOut("  |cffffa500 reset|r - Reset all settings!");
	end
	CanOpenerGlobal.DebugLog("slashHandler - End");
end

SlashCmdList.CanOpener = function(msg) slashHandler(msg) end;
SLASH_CanOpener1 = "/CanOpener";
SLASH_CanOpener2 = "/CO";

------------------------------------------------
-- Main Frame
------------------------------------------------
local frame = CreateFrame("Frame", "CanOpener_Frame", UIParent);
frame.ButtonCount = 0;
CanOpenerGlobal.Frame = frame;

frame:Hide();
frame:SetWidth(120);
frame:SetHeight(38);
frame:SetClampedToScreen(true);
frame:SetFrameStrata("BACKGROUND");
frame:SetMovable(true);
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("BAG_UPDATE");
frame:RegisterEvent("BAG_UPDATE_DELAYED");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("PLAYER_LEAVING_WORLD");
frame:RegisterEvent("PLAYER_REGEN_DISABLED");
frame:RegisterEvent("PLAYER_REGEN_ENABLED");

frame:SetScript("OnEvent", function(self, event, ...)
	CanOpenerGlobal.DebugLog("OnEvent - Start");
	local eventAction = CanOpenerGlobal.Events[event];

	if (eventAction) then
		CanOpenerGlobal.DebugLog("OnEvent - Matched Event " .. event, ...);
		eventAction(...);
	end
	CanOpenerGlobal.DebugLog("OnEvent - End");
end);

frame:SetScript("OnShow", function(self, event, ...)
	CanOpenerGlobal.DebugLog("OnShow - Start");
	--Restore position
	self:ClearAllPoints();
	self:SetPoint(CanOpenerSavedVars.position[1], UIParent, CanOpenerSavedVars.position[2],
		CanOpenerSavedVars.position[3], CanOpenerSavedVars.position[4]);
	CanOpenerGlobal.DebugLog("OnShow - End");
end);

local function buttonOnLeave(btn)
	GameTooltip:Hide();
end

local function buttonOnEnter(btn)
	GameTooltip:SetOwner(btn, "ANCHOR_TOP");
	GameTooltip:SetItemByID(btn.itemID);
end

local function createButton(cacheDetails, id)
	CanOpenerGlobal.DebugLog("createButton - Start");
	CanOpenerGlobal.DebugLog("createButton - id " .. id);
	local btn = CreateFrame("Button", cacheDetails.name, frame, "SecureActionButtonTemplate");
	cacheDetails.button = btn;
	btn.itemID = id;

	btn:Hide();
	btn:SetWidth(38);
	btn:SetHeight(38);
	btn:SetClampedToScreen(true);
	--Right click to drag
	btn:EnableMouse(true);
	btn:RegisterForDrag("RightButton");
	btn:SetMovable(true);
	btn:SetScript("OnDragStart", function(self) self:GetParent():StartMoving(); end);
	btn:SetScript("OnDragStop", function(self)
		self:GetParent():StopMovingOrSizing();
		self:GetParent():SetUserPlaced(false);
		local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint();
		CanOpenerSavedVars.position = { point, relativePoint, xOfs, yOfs };
	end);
	--Setup macro
	btn:SetAttribute("type", "macro");
	-- if cacheDetails.lockbox and IsSpellKnown(1804) then -- 1804 is the ID for Pick Lock
	-- 	local localizedName = C_Spell.GetSpellInfo(1804).name;
	-- 	btn:SetAttribute("macrotext", format("/cast %s\n/use item:%d", localizedName, id));
	-- else
	-- 	btn:SetAttribute("macrotext", format("/use item:%d", id));
	-- end
	btn:SetAttribute("macrotext", format("/use item:%d", id));

	btn.countString = btn:CreateFontString(btn:GetName() .. "Count", "OVERLAY", "NumberFontNormal");
	btn.countString:SetPoint("BOTTOMRIGHT", btn, -0, 2);
	btn.countString:SetJustifyH("RIGHT");
	btn.icon = btn:CreateTexture(nil, "BACKGROUND");
	btn.icon:SetTexture(GetItemIcon(id));
	btn.texture = btn.icon;
	btn.texture:SetAllPoints(btn);
	btn:RegisterForClicks("LeftButtonUp", "LeftButtonDown");

	--Tooltip
	btn:SetScript("OnEnter", buttonOnEnter);
	btn:SetScript("OnLeave", buttonOnLeave);

	CanOpenerGlobal.DebugLog("createButton - End");
end

local UpdateButtons = function()
	CanOpenerGlobal.DebugLog("updateButton - Start");
	for bagID = CanOpenerGlobal.BagIndicies.Backpack, CanOpenerGlobal.BagIndicies.ReagentBag, 1 do
		CanOpenerGlobal.DebugLog(bagID);
		for slot = 1, C_Container.GetContainerNumSlots(bagID) do
			local itemID = C_Container.GetContainerItemID(bagID, slot);
			local cacheDetails = CanOpenerGlobal.openables[itemID];
			if itemID and cacheDetails and not cacheDetails.lockbox then -- Don't show lockboxes in the button bar
				local count = GetItemCount(itemID);

				if CanOpenerGlobal.CriteriaContext:evaluateAll(cacheDetails, count) and not itemIDsInQueue[itemID] then
					table.insert(buttonQueue, itemID)
					itemIDsInQueue[itemID] = true
				end
			end
		end
	end
	CanOpenerGlobal.DebugLog("updateButton - End");
end
CanOpenerGlobal.UpdateButtons = UpdateButtons;

local drawButtons = function()
	CanOpenerGlobal.DebugLog("drawButtons - Start");
	-- Don't do anything if we are in combat. Daddy Blizz says so.
	if (CanOpenerGlobal.LockDown) then
		CanOpenerGlobal.DebugLog("drawButtons - LOCK DOWN");
		return;
	end

	CanOpenerGlobal.DebugLog("drawButtons - Current Buttons");
	CanOpenerGlobal.DebugLog(buttons);

	local buttonIndex = 0;

	for _, tbl in ipairs(buttons) do
		local button = tbl.button;
		local itemID = tbl.itemID;

		if (buttonQueue[itemID]) then
			SetButton(button, buttonIndex, itemID);
			buttonQueue[itemID] = nil;
		else
			button:Hide();
		end
	end

	CanOpenerGlobal.DebugLog("drawButtons - Buttons in queue");
	CanOpenerGlobal.DebugLog(buttonQueue);

	for _, itemID in ipairs(buttonQueue) do
		local cacheDetails = CanOpenerGlobal.openables[itemID];

		if not cacheDetails.button then
			createButton(cacheDetails, itemID);
		end

		SetButton(cacheDetails.button, buttonIndex, itemID);
		table.insert(buttons, { button = cacheDetails.button, itemID });
		cacheDetails.button:Show();

		buttonIndex = buttonIndex + 1;
	end
	wipe(buttonQueue);
	wipe(itemIDsInQueue);
	CanOpenerGlobal.DebugLog("drawButtons - End");
end
CanOpenerGlobal.DrawButtons = drawButtons;

function SetButton(button, buttonIndex, itemID)
	button:SetPoint("LEFT", frame, "LEFT", buttonIndex * 38, 0);
	local count = GetItemCount(itemID) or 0;
	button.countString:SetText(tostring(count));
	button.texture:SetDesaturated(false);
	buttonIndex = buttonIndex + 1;
end
