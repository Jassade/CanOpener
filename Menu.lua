local _, CanOpenerGlobal = ...;

-- Initialize the settings for the addon
function InitSettingsMenu()
    local category = Settings.RegisterVerticalLayoutCategory("CanOpener")

    do
        local variable = "showRousing"
        local name = "Show Rousing Items"
        local tooltip = "If Checked, Rousing Elements will be shown."
        local defaultValue = true

        local function GetValue()
            return CanOpenerSavedVars.showRousing
        end

        local function SetValue(value)
            CanOpenerSavedVars.showRousing = value
        end

        local setting = Settings.RegisterProxySetting(
            category,
            "CanOpener_" .. variable,
            Settings.VarType.Boolean,
            name,
            defaultValue,
            GetValue,
            SetValue
        )

        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local variable = "showLevelRestrictedItems"
        local name = "Show Level-Restricted Items"
        local tooltip = "If Checked, items with a level requirement higher than your character's level will be shown."
        local defaultValue = true

        local function GetValue()
            return CanOpenerSavedVars.showLevelRestrictedItems
        end

        local function SetValue(value)
            CanOpenerSavedVars.showLevelRestrictedItems = value
        end

        local setting = Settings.RegisterProxySetting(
            category,
            "CanOpener_" .. variable,
            Settings.VarType.Boolean,
            name,
            defaultValue,
            GetValue,
            SetValue
        )

        Settings.CreateCheckbox(category, setting, tooltip)
    end

    if (CanOpenerGlobal.IsRemixActive) then
        do
            local variable = "showRemixGems"
            local name = "Show Remix Gems"
            local tooltip = "Display Remix Gems in the CanOpener UI."
            local defaultValue = true

            local function GetValue()
                return CanOpenerSavedVars.showRemixGems;
            end

            local function SetValue(value)
                CanOpenerSavedVars.showRemixGems = value
            end

            local setting = Settings.RegisterProxySetting(
                category,
                "CanOpener_" .. variable,
                Settings.VarType.Boolean,
                name,
                defaultValue,
                GetValue,
                SetValue
            )

            Settings.CreateCheckbox(category, setting, tooltip);
        end

        do
            local variable = "remixEpicGems"
            local name = "Include Epic Gems in Remix"
            local tooltip = "Show Epic Remix Gems."
            local defaultValue = true

            local function GetValue()
                return CanOpenerSavedVars.remixEpicGems;
            end

            local function SetValue(value)
                CanOpenerSavedVars.remixEpicGems = value
            end

            local setting = Settings.RegisterProxySetting(
                category,
                "CanOpener_" .. variable,
                Settings.VarType.Boolean,
                name,
                defaultValue,
                GetValue,
                SetValue
            )

            Settings.CreateCheckbox(category, setting, tooltip)
        end
    end

    -- do
    --     local variable = "position"
    --     local name = "Position"
    --     local tooltip = "Set the position of the CanOpener UI."
    --     local defaultValue = { "CENTER", "CENTER", 0, 0 }

    --     local function GetValue()
    --         return CanOpenerSavedVars.position
    --     end

    --     local function SetValue(value)
    --         CanOpenerSavedVars.position = value
    --     end

    --     local setting = Settings.RegisterProxySetting(
    --         category,
    --         "CanOpener_" .. variable,
    --         Settings.VarType.Table,
    --         name,
    --         defaultValue,
    --         GetValue,
    --         SetValue
    --     )

    --     Settings.CreateCheckbox(category, setting, tooltip)
    -- end

    -- do
    --     local variable = "debugMode"
    --     local name = "Enable Debug Mode (Resets on Reload)"
    --     local tooltip = "Enable debug logging for troubleshooting purposes."
    --     local defaultValue = false

    --     local function GetValue()
    --         return CanOpenerGlobal.DebugMode;
    --     end

    --     local function SetValue(value)
    --         CanOpenerGlobal.DebugMode = value
    --     end

    --     local setting = Settings.RegisterProxySetting(
    --         category,
    --         "CanOpener_" .. variable,
    --         Settings.VarType.Boolean,
    --         name,
    --         defaultValue,
    --         GetValue,
    --         SetValue
    --     )

    --     Settings.CreateCheckbox(category, setting, tooltip)
    -- end
    -- 2) Create a Frame for your subcategory’s custom UI
    local ignoreFrame = CreateFrame("Frame", "CanOpener_IgnoreFrame", UIParent)
    ignoreFrame:Hide()                -- so it’s invisible until shown in the settings
    ignoreFrame.name = "Ignore Lists" -- optional, mostly cosmetic

    -- 3) Register a CanvasLayoutSubcategory for that frame
    --    NOTE: this automatically associates ignoreFrame as a sub‐panel of `category`
    Settings.RegisterCanvasLayoutSubcategory(category, ignoreFrame, "Ignore Lists")


    -- 4) Build your custom UI on ignoreFrame
    do
        local title = ignoreFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 10, -10)
        title:SetText("Ignore Lists")
        --------------------------------------------------
        -- Example: "Character Ignore List"
        --------------------------------------------------
        local charHeader = ignoreFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        charHeader:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -15)
        charHeader:SetText("This Character’s Ignore List")

        local charScroll = CreateFrame("ScrollFrame", "CanOpener_CharacterIgnoreScroll", ignoreFrame,
            "UIPanelScrollFrameTemplate")
        charScroll:SetSize(300, 200)
        charScroll:SetPoint("TOPLEFT", charHeader, "BOTTOMLEFT", 0, -10)

        local charContent = CreateFrame("Frame", "CanOpener_CharacterIgnoreContent", charScroll)
        charContent:SetSize(300, 200)
        charScroll:SetScrollChild(charContent)

        local function RefreshCharIgnoreList()
            -- clear any previous lines
            for _, child in ipairs({ charContent:GetChildren() }) do
                child:Hide()
                child:SetParent(nil)
            end

            local y = -10
            for itemID in pairs(CanOpenerSavedVars.excludedItems or {}) do
                local row = CreateFrame("Frame", nil, charContent)
                row:SetSize(280, 30)
                row:SetPoint("TOPLEFT", 10, y)

                local icon = row:CreateTexture(nil, "ARTWORK")
                icon:SetSize(30, 30)
                icon:SetPoint("LEFT")
                icon:SetTexture(C_Item.GetItemIconByID(itemID) or "Interface\\Icons\\INV_Misc_QuestionMark")

                local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                label:SetPoint("LEFT", icon, "RIGHT", 10, 0)
                local itemName = C_Item.GetItemNameByID(itemID) or ("Item " .. itemID)
                label:SetText(itemName)

                local removeBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
                removeBtn:SetSize(60, 20)
                removeBtn:SetPoint("RIGHT")
                removeBtn:SetText("Remove")
                removeBtn:SetScript("OnClick", function()
                    CanOpenerSavedVars.excludedItems[itemID] = nil
                    RefreshCharIgnoreList()
                    CanOpenerGlobal.CanOut("Removed item " .. itemID .. " from your ignore list.")
                    CanOpenerGlobal.ForceButtonRefresh()
                end)

                y = y - 35
            end
        end
        RefreshCharIgnoreList()
    end
    Settings.RegisterAddOnCategory(category)
    -- InitIgnoreListSettings();
end
