script_name('Learning')
script_author('morz1ck')
 
require "lib.moonloader"
local tag = '[KV-mark]: ', 0xFF1493
local sampev = require("lib.samp.events");
local imgui = require("imgui");
local cordX = nil;
local cordY = nil;
 
function main()
    while not isSampAvailable() do wait(0) end
 
    res, id = sampGetPlayerIdByCharHandle(PLAYER_PED);
    nick = sampGetPlayerNickname(id);
    sampAddChatMessage(tag .. " {FFFFFF}You are welcome {FF69B4}" .. nick, 0xFF1493);
    sampRegisterChatCommand("setmark", cmd_setmark);
    sampRegisterChatCommand('hel', cmd_hello);
 
    wait(-1);
end
 
function cmd_setmark()
    if cordX ~= nil and cordY ~= nil then
        cX, cY, cZ = getCharCoordinates(playerPed)
        cX = math.ceil(cX)
        cY = math.ceil(cY)
        sampAddChatMessage(tag .. "{ffffff}Waypoint "..kvadY.."-"..kvadX.." is ready. ", 0xFF1493)
        placeWaypoint(cordX, cordY, 0);
    else
      sampAddChatMessage(tag .. '{ffffff}There is no sector', 0xFF1493)
    end
end
 
 
function cmd_hello(player_id)
    player_nickname = sampGetPlayerNickname(player_id)
    sampSendChat("Good evening, ".. player_nickname .. ".")
end
 
function sampev.onServerMessage(color, lcs)
  local pattern = "([A-РЇР°-СЏРђ-Za-z])%-(%d%d?)"
  local foundY, foundX = string.match(lcs, pattern)

  if foundY and foundX then
    kvadY = foundY
    kvadX = foundX
    local kvNum = kvadrat(kvadY)
    if kvNum ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
      cordX = tonumber(kvadX) * 250 - 3125
      cordY = 3125 - (kvNum * 250)
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
        ["у"] = 20, ["ф"] = 21, ["х"] = 22, ["ц"] = 23, ["ч"] = 24
    }
    return KV[param]
end
