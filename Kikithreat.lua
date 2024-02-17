
local kt_id = 1

local config = {
  refresh_time = 1, -- 0 grey, 1 white and quest items, 2 green, 3 blue, ...
}

-- for debugging: DEFAULT_CHAT_FRAME:AddMessage("Test")
local function print(msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local window = CreateFrame("Frame", "KikiMeter", UIParent)

window:SetScript("OnUpdate", function()
  if not window.clock then window.clock = GetTime() end

  if GetTime() > window.clock + config.refresh_time then
    print("TWT_UDTSv4".."limit=10".."PARTY")
    SendAddonMessage("TWT_UDTSv4","limit=10","PARTY")

    window.clock = GetTime()
  end
end)