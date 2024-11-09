local config = lib.require 'config'

local function openMenu()
    local menu = {
        id = 'some_menu',
        title = 'Sell Items',
        options = {}
    }

    if not menu then
        print("Erro ao criar o menu!")
        return
    end

    local options = {}
    for item, data in pairs(config.ilegalItems) do
        local ilegalItem = exports.ox_inventory:Search('count', item)
        if ilegalItem >= 1 then
            options[#options + 1] = {
                title = exports.ox_inventory:Items(item).label,
                description = "Price: $" .. data.price, 
                event = 'lonf:input',
                args = {
                    item = item,
                    price = data.price,
                },
            }
        end
    end

    menu["options"] = options

    if #options == 0 then
        print("Nenhuma opção foi adicionada ao menu.")
    end

    lib.registerContext(menu)
    lib.showContext('some_menu')
end

RegisterNetEvent('lonf:input', function(data)
    local input = lib.inputDialog(data.item, {
        { type = 'input', label = 'Sell Amount', placeholder = 'Amount' },
    })

    if input == nil or input[1] == nil or input[1] == "" then return end

    local sellAmount = tonumber(input[1]) 

    TriggerServerEvent('lonf:sell', data.item, data.price, sellAmount)
end)
local function SpawnPed()
    local model = GetHashKey(config.modelShop)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    local pedModel = CreatePed(0, model, config.coordsShop.x, config.coordsShop.y, config.coordsShop.z,
        config.coordsShop.w, false, false)
    SetEntityInvincible(pedModel, true)
    FreezeEntityPosition(pedModel, true)
    SetBlockingOfNonTemporaryEvents(pedModel, true)
    SetModelAsNoLongerNeeded(pedModel)

    exports.ox_target:addModel(config.modelShop, {
        {
            icon = 'fa-solid fa-check',
            label = 'Sell Items',
            onSelect = function()
                openMenu()
            end,
            distance = 1.5,
        }
    })
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        SpawnPed()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SpawnPed()
end)
