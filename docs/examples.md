# Examples with BetterAPI

=== "Wireframe Molotov"
    ```lua title="Wireframe molotov.lua"
    local Wireframe, IgnoreZ = 
        Menu.Switch("Molotov particles", "Molotov Wireframe", false),
        Menu.Switch("Molotov particles", "Molotov Ignore-Z", false)
    
    local materials = {
        "particle/fire_burning_character/fire_env_fire_depthblend_oriented",
        "particle/fire_burning_character/fire_burning_character",
        "particle/fire_explosion_1/fire_explosion_1_oriented",
        "particle/fire_explosion_1/fire_explosion_1_bright",
        "particle/fire_burning_character/fire_burning_character_depthblend",
        "particle/fire_burning_character/fire_env_fire_depthblend",
    }
    
    Cheat.RegisterCallback("draw", function()
        for _, v in pairs(materials) do
            local material = MatSystem.FindMaterial(v, "")
            if material ~= nil then
                material:SetMaterialVarFlag(bit.lshift(1, 28), Wireframe:GetBool()) -- Wireframe
                material:SetMaterialVarFlag(bit.lshift(1, 15), IgnoreZ:GetBool()) -- IgnoreZ
            end
        end
    end)
    
    Cheat.RegisterCallback("destroy", function()
        for _, v in pairs(materials) do
            local material = MatSystem.FindMaterial(v, "")
            if material ~= nil then
                material:SetMaterialVarFlag(bit.lshift(1, 28), false) -- Wireframe
                material:SetMaterialVarFlag(bit.lshift(1, 15), false) -- IgnoreZ
            end
        end
    end)
    
    function Yes()
    
    end
    ```
=== "Table"

    | Method      | Description                          |
    | ----------- | ------------------------------------ |
    | `GET`       | :material-check:     Fetch resource  |
    | `PUT`       | :material-check-all: Update resource |
    | `DELETE`    | :material-close:     Delete resource |