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

    Settings.RegisterAddOnCategory(category)
end
