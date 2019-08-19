local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local ped = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","Réparation", nil, nil, "shopui_title_supermod", "shopui_title_supermod")
_menuPool:Add(mainMenu)

function AddRepairMenu(menu)

    local kitmenu = _menuPool:AddSubMenu(menu, "Kit de Réparation", nil, nil, "shopui_title_supermod", "shopui_title_supermod")

    local kitcaromenu = _menuPool:AddSubMenu(menu, "Kit de Carosserie", nil, nil, "shopui_title_supermod", "shopui_title_supermod")

    local kit = NativeUI.CreateItem("Achetez", "")
    kitmenu.SubMenu:AddItem(kit)
    kit:RightLabel("3000$")

    local caro = NativeUI.CreateItem("Achetez", "")
    kitcaromenu.SubMenu:AddItem(caro)
    caro:RightLabel("2500$")

    kitmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == kit then
        TriggerServerEvent("BuyKit")
        ESX.ShowAdvancedNotification("Mécano", "Préparation...", "", "CHAR_CARSITE3", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("Mécano", "~g~Kit de Réparation", "", "CHAR_CARSITE3", 1)
        _menuPool:CloseAllMenus(true)
        end
    end

    kitcaromenu.SubMenu.OnItemSelect = function(menu, item)
    if item == caro then
        TriggerServerEvent("BuyCaro")
        ESX.ShowAdvancedNotification("Mécano", "Préparation...", "", "CHAR_CARSITE3", 1)
        Citizen.Wait(0)
        ESX.ShowNotification("3")
        Citizen.Wait(3)
        ESX.ShowNotification("2")
        Citizen.Wait(2)
        ESX.ShowNotification("1")
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("Mécano", "~g~Kit de Carosserie", "", "CHAR_CARSITE3", 1)
        _menuPool:CloseAllMenus(true)
        end
    end
end

AddRepairMenu(mainMenu)
_menuPool:RefreshIndex()

local blips = {
    {title="~b~Station de Réparation Sud", colour=17, id=473, x = 538.44665527344, y = -176.42123413086, z = 54.487968444824},
    {title="~b~Station de Réparation Grand Desert", colour=17, id=473, x = 1188.0888671875, y = 2641.0961914063, z = 38.441184997559},
    {title="~b~Station de Réparation Sandy Shores", colour=17, id=473, x = 1954.830078125, y = 3838.2878417969, z = 32.177833557129},
    {title="~b~Station de Réparation GrapeSeed", colour=17, id=473, x = 1666.5975341797, y = 4969.1127929688, z = 42.255146026611},
    {title="~b~Station de Réparation Paleto Bay", colour=17, id=473, x = 102.11338806152, y = 6616.9047851563, z = 32.474632263184},

}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

local zikoz = {
    {x = 538.44665527344, y = -176.42123413086, z = 54.487968444824},
    {x = 1188.0888671875, y = 2641.0961914063, z = 38.441184997559},
    {x = 1954.830078125, y = 3838.2878417969, z = 32.177833557129},
    {x = 1666.5975341797, y = 4969.1127929688, z = 42.255146026611},
    {x = 102.11338806152, y = 6616.9047851563, z = 32.474632263184},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(zikoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, zikoz[k].x, zikoz[k].y, zikoz[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parlez avec le ~b~garagiste")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

local ped = vector3(538.44665527344, -176.42123413086, 54.487968444824)
local ped = vector3(1188.0888671875, 2641.0961914063, 38.441184997559)
local ped = vector3(1954.830078125, 3838.2878417969, 32.177833557129)
local ped = vector3(1666.5975341797, 4969.1127929688, 42.255146026611)
local ped = vector3(102.11338806152, 6616.9047851563, 32.474632263184)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 20

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), ped) < distance then
            Draw3DText(ped.x,ped.y,ped.z, "François")
		end
	end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_dockwork_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 538.44665527344, -176.42123413086, 53.487968444824, 100.591, true, true)
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 1188.0888671875, 2641.0961914063, 37.441184997559, 25.591, true, true)
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 1954.830078125, 3838.2878417969, 31.177833557129, 300.591, true, true)
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 1666.5975341797, 4969.1127929688, 41.255146026611, 400.591, true, true)
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_dockwork_01", 102.11338806152, 6616.9047851563, 31.474632263184, 600.591, true, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
end)
