local items = {
    "panties",      -- 1
    "diamond_ring", -- 2
    "goldchain",    -- 3
    "rolex",        -- 4
    "10kgoldchain", -- 5
    "flowers",      -- 6
    "humanbone",    -- 7
    "humanbones",   -- 8
    "humanskull",   -- 9
    "humantooth",   -- 10
    "voodoodoll",   -- 11
    "pearlnecklace" -- 12
}

lib.callback.register('lonf_fruitpick:server:giveItem', function(source)
    local src = source
    local randomItem = math.random(1, #items)

    exports.ox_inventory:AddItem(src, items[randomItem], 1)
end)

lib.callback.register('lonf:server:getNumCops', function(source)
    return exports.qbx_core:GetDutyCountType('leo')
end)

RegisterNetEvent('lonf:sell', function (item, price, count)
    local src = source
    if not item or not price or not count then return end

    local countCheck = exports.ox_inventory:GetItemCount(src, item)
    if countCheck >= count then  

        exports.ox_inventory:RemoveItem(src, item, count)
        
        local profit = price * count
        exports.ox_inventory:AddItem(src, 'money', profit)
    else
        TriggerClientEvent('chat:addMessage', src, { args = { 'Sistema', 'Você não tem itens suficientes!' } })
    end
end)