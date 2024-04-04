
local kt_id = 1

local config = {
  refresh_time = 1
}

-- for debugging: DEFAULT_CHAT_FRAME:AddMessage("Test")
local function print(msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local function AddDataThreat(data_threat, target_name, player_name, threat)
    if not data_threat[target_name] then
        data_threat[target_name] = {}
    end
    data_threat[target_name][player_name] = threat
end

local window = CreateFrame("Frame", "Kikithreat", UIParent)
local data_threat = {}

window:SetScript("OnUpdate", function()
  if not window.clock then window.clock = GetTime() end

  if GetTime() > window.clock + config.refresh_time then
    local unit_id = nil
    local name_list = {}
    for idx=1,40 do
        unit_id = "raid"..idx.."target"
        local target_name = UnitName(unit_id)
        
        if not name_list[target_name] then -- poop api cant distinict between units with same name, just use first name occurrence and call it a day
          TargetUnit(unit_id)
          name_list[target_name] = true
          print("TWT_UDTSv4".."limit=10".."RAID"..": "..name_list[idx])
          -- SendAddonMessage("TWT_UDTSv4_target",name_list[idx],"RAID")
          SendAddonMessage("TWT_UDTSv4","limit=10","RAID")
          TargetLastTarget()
        end
    end
    window.clock = GetTime()
  end
end)

window:RegisterEvent("CHAT_MSG_ADDON")
window:SetScript("OnEvent", function()
  -- arg1: Prefix (KMkm_id_dmg_attack
    -- KMkm_id_eheal_attack
    -- KMkm_id_oheal_attack)
  -- arg2: Message (number)
  -- arg3: distribution type (RAID)
  -- arg4: sender (Kikidora)
  print(arg1)
  print(arg2)
  print(arg3)
  print(arg4)
  AddDataThreat(data_threat, "Test", arg4, arg2)
end)