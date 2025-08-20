-- <мик>>else'(мяк>)=*

script_name('Learning')
script_author('morz1ck')

require "lib.moonloader"
local tag = '[KV-mark]: ', 0xFF1493
local sampev = require "lib.samp.events"
local imgui = require "imgui"


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	res, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)
	sampAddChatMessage(tag .. " {FFFFFF}You are welcome {FF69B4}" .. nick, 0xFF69B4)
	sampRegisterChatCommand("setmark", cmd_setmark)
  sampRegisterChatCommand('hel', cmd_hello)

	while true do
		wait(0)
  end
end

function cmd_setmark()
  if cordX ~= nil and cordY ~= nil then
    local cX, cY, cZ = getCharCoordinates(playerPed)
    cX = math.ceil(cx)
    cY = math.ceil(cy)
    sampAddChatMessage(tag .. "Waypoint "..kvadY.."-"..kvadX.." is ready."..math.ceil(getDistanceBetweenCoords2d(cordX, cordY, cx, cy)) .. ' i.', -1)
    placeWaypoint(cordX, cordY, 0)
  end
end


function cmd_hello(player_id)
  player_nickname = sampGetPlayerNickname(player_id)
  sampSendChat("Good evening, ".. player_nickname .. ".")
end

function sampev.onServerMessage(color, lcs)
	if string.find(lcs, "(%A)-[0-9][0-9]") or string.find(lcs, "(%A)-[0-9]") then
		kvadY, kvadX = string.match(lcs, '(%A)-(%d+)')
		if kvadrat(kvadY) ~= nil and kvadX ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
			last = lcs
			cordX = kvadX * 250 - 3125
			cordY = (kvadrat(kvadY) * 250 - 3125) * - 1
		end
	end
end

function kvadrat(param)
    local KV = {
        ["А"] = 1, ["Б"] = 2, ["В"] = 3, ["Г"] = 4, ["Д"] = 5, ["Е"] = 6, ["Ж"] = 7,
        ["З"] = 8, ["И"] = 9, ["Й"] = 10, ["К"] = 11, ["Л"] = 12, ["М"] = 13,
        ["Н"] = 14, ["О"] = 15, ["П"] = 16, ["Р"] = 17, ["С"] = 18, ["Т"] = 19,
        ["У"] = 20, ["Ф"] = 21, ["Х"] = 22, ["Ц"] = 23, ["Ч"] = 24,
        ["а"] = 1, ["б"] = 2, ["в"] = 3, ["г"] = 4, ["д"] = 5, ["е"] = 6, ["ж"] = 7,
        ["з"] = 8, ["и"] = 9, ["й"] = 10, ["к"] = 11, ["л"] = 12, ["м"] = 13,
        ["н"] = 14, ["о"] = 15, ["п"] = 16, ["р"] = 17, ["с"] = 18, ["т"] = 19,
        ["у"] = 20, ["ф"] = 21, ["х"] = 22, ["ц"] = 23, ["ч"] = 24,
    }
    return KV[param]
end
