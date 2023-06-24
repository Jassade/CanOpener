local _, CanOpenerGlobal = ...;
local CanOpener = {};

------------------------------------------------
-- Slash Commands
------------------------------------------------
local function slashHandler(msg)
	msg = msg:lower() or "";
	if (msg == "rousing") then
		CanOpenerSavedVars.rousing = not CanOpenerSavedVars.rousing;
		CanOpener:updateButtons();
		if CanOpenerSavedVars.rousing then
			CanOpenerGlobal.CanOut(": Stacks of 10 rousing elements will be shown");
		else
			CanOpenerGlobal.CanOut(": Stacks of 10 rousing elements will not be shown");
		end
	
	elseif (msg == "reset") then
		CanOpenerGlobal.CanOut(": Resetting settings and position.");
		CanOpener:reset();
	else
		CanOpenerGlobal.CanOut(": Commands for |cffffa500/CanOpener|r :");
		CanOpenerGlobal.CanOut("  |cffffa500 rousing|r - Toggle including stacks of Rousing Elements");
		CanOpenerGlobal.CanOut("  |cffffa500 reset|r - Reset all settings!");
	end
end

SlashCmdList.CanOpener = function(msg) slashHandler(msg) end;
SLASH_CanOpener1 = "/CanOpener";
SLASH_CanOpener2 = "/CO";

------------------------------------------------
-- Main Frame
------------------------------------------------
local frame = CreateFrame("Frame", "CanOpener_Frame", UIParent);
CanOpenerGlobal.Frame = frame;

frame:Hide();
frame:SetWidth(120);
frame:SetHeight(38);
frame:SetClampedToScreen(true);
frame:SetFrameStrata("BACKGROUND");
frame:SetMovable(true);
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("PLAYER_REGEN_ENABLED");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("BAG_UPDATE");

frame:SetScript("OnEvent", function(self, event, ...)
	local eventAction = CanOpenerGlobal.Events[event];

	if(eventAction) then
		eventAction(...);
	end
end);

--[[
frame:SetScript("OnShow", function(self,event,...) 
	--Restore position
	self:ClearAllPoints();
	if CanOpenerSavedVars and CanOpenerSavedVars.position then
		self:SetPoint(CanOpenerSavedVars.position[1],UIParent,CanOpenerSavedVars.position[3],CanOpenerSavedVars.position[4],CanOpenerSavedVars.position[5]);
	else
		self:SetPoint('CENTER', UIParent, 'CENTER', 0, 0);
	end		
 end);
---Create button for each item
for i = 1, #CanOpener.items do
	CanOpener.items[i].button = CreateFrame("Button", CanOpener.items[i].name, frame, "SecureActionButtonTemplate");
	CanOpener:createButton(CanOpener.items[i].button,CanOpener.items[i].id);
end

function CanOpener:updateBag(bagID)
	print(tostring(bagID));
	for slot = 1, GetContainerNumSlots(bagID) do
        local itemID = GetContainerItemID(bagID, slot);
		local cacheDetails = test[itemID];
        if itemID and cacheDetails then
            print(format("--- %s",cacheDetails));
        end
    end
end

local shouldUpdateButtons = false;
local updatingButtons = false;

function CanOpener:updateButtons()
    CanOpener:DebugLog("4 - updateButtons Called");
	updatingButtons = true;
    self.previous = 0;
    for i = 1, #self.items do
        CanOpener:DebugLog("5 - self.items loop");
        CanOpener:updateButton(self.items[i].button,self.items[i].id,self.items[i].threshold or 1,i);
    end
	updatingButtons = false;
end

function CanOpener:updateButton(btn,id,threshold,num)
    local count = GetItemCount(id);
    local meetThreshold = count >= threshold;

    if (CanOpenerSavedVars.rousing and meetThreshold) or (not rousings[id] and meetThreshold) then
        btn:ClearAllPoints();
        
		local point = "LEFT"
		local relativePoint = "RIGHT"
		local xOffset = 2

		if self.previous == 0 then
			btn:SetPoint(point, self.frame, point, 0, 0)
		else
			btn:SetPoint(point, self.items[self.previous].button, relativePoint, xOffset, 0)
		end
        
        self.previous = num;
        btn.countString:SetText(tostring(count));
        btn.texture:SetDesaturated(false);
        CanOpener:DebugLog("ButtonShow");
        btn:Show();
    else 
        btn.countString:SetText("");
        btn.texture:SetDesaturated(true);
        CanOpener:DebugLog("ButtonHide");
        btn:Hide();
    end
end

function CanOpener:createButton(btn,id)
	CanOpener:DebugLog("7 - createButton Called");
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
			CanOpenerSavedVars.position = {point, nil, relativePoint, xOfs, yOfs};
			end);
	--Setup macro
	btn:SetAttribute("type", "macro");
	btn:SetAttribute("macrotext", format("/use item:%d",id));
	btn.countString = btn:CreateFontString(btn:GetName().."Count", "OVERLAY", "NumberFontNormal");
	btn.countString:SetPoint("BOTTOMRIGHT", btn, -0, 2);
	btn.countString:SetJustifyH("RIGHT");
	btn.icon = btn:CreateTexture(nil,"BACKGROUND");
	btn.icon:SetTexture(GetItemIcon(id));
	btn.texture = btn.icon;
	btn.texture:SetAllPoints(btn);
	btn:RegisterForClicks("LeftButtonUp", "LeftButtonDown");
	
	--Tooltip
	btn:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self,"ANCHOR_TOP");
		GameTooltip:SetItemByID(format("%d",id));
		GameTooltip:SetClampedToScreen(true);
		GameTooltip:Show();
	  end);
	btn:SetScript("OnLeave",GameTooltip_Hide);
 end

function CanOpener:TryUpdateButtons()
	if updatingButtons and not shouldUpdateButtons then
		shouldUpdateButtons = true;
		C_Timer.After(0.1, function() CanOpener:TryUpdateButtons() end);
	elseif not updatingButtons then
		CanOpener:AddButton();
		shouldUpdateButtons = false;
	end
end

function CanOpener:AddButton()
	CanOpener:DebugLog("2 - Add Button Called");
	self.frame:Show();
	CanOpener:DebugLog("3 - Frame Shown");
	CanOpener:updateButtons();
end
]]--
