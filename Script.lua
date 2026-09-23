--[[ ECLIPSE-STYLE MENU — версия без GunMod + Мои координаты + Телепорты + Ghost с вращением камеры + Точный Aimbot ]]

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")

local C = {
    bg = Color3.fromRGB(15,15,22), topbar = Color3.fromRGB(20,20,30),
    sidebar = Color3.fromRGB(18,18,26), row = Color3.fromRGB(22,22,32),
    accent = Color3.fromRGB(130,70,220), accentDk = Color3.fromRGB(90,40,160),
    text = Color3.fromRGB(220,220,230), textDim = Color3.fromRGB(140,140,160),
    badge = Color3.fromRGB(35,30,50), badgeText = Color3.fromRGB(150,130,180),
    toggleOff = Color3.fromRGB(50,50,65), knob = Color3.fromRGB(230,230,240),
    red = Color3.fromRGB(180,40,40), green = Color3.fromRGB(80,130,80),
}

local gui = Instance.new("ScreenGui")
gui.Name = "EclipseMenu"; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 540, 0, 460)
main.Position = UDim2.new(0.5, -270, 0.5, -230)
main.BackgroundColor3 = C.bg; main.BorderSizePixel = 0; main.Active = true; main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
local mStroke = Instance.new("UIStroke", main)
mStroke.Color = C.accentDk; mStroke.Thickness = 1; mStroke.Transparency = 0.4

local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 40); topbar.BackgroundColor3 = C.topbar
topbar.BorderSizePixel = 0; topbar.Parent = main; topbar.Active = true
Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 8)

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(0, 200, 1, 0); titleLbl.Position = UDim2.new(0, 18, 0, 0)
titleLbl.Text = "ECLIPSE"; titleLbl.TextColor3 = Color3.fromRGB(240,240,245)
titleLbl.BackgroundTransparency = 1; titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 16; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.Active = false; titleLbl.Parent = topbar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30); minBtn.Position = UDim2.new(1, -76, 0, 5)
minBtn.Text = "—"; minBtn.TextColor3 = C.textDim; minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.GothamBold; minBtn.TextSize = 16; minBtn.Parent = topbar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -42, 0, 5)
closeBtn.Text = "✕"; closeBtn.TextColor3 = C.textDim; closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 14; closeBtn.Parent = topbar

local dragging = false; local dragStart, startPos
local function beginDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = main.Position
    end
end
local function endDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end
topbar.InputBegan:Connect(beginDrag); topbar.InputEnded:Connect(endDrag)
titleLbl.InputBegan:Connect(beginDrag); titleLbl.InputEnded:Connect(endDrag)
uis.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -54); sidebar.Position = UDim2.new(0, 8, 0, 46)
sidebar.BackgroundColor3 = C.sidebar; sidebar.BorderSizePixel = 0; sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)

local function makeTabBtn(text, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -16, 0, 34); b.Position = UDim2.new(0, 8, 0, y)
    b.Text = text; b.TextColor3 = Color3.fromRGB(240,240,245)
    b.BackgroundColor3 = C.sidebar; b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12; b.BorderSizePixel = 0
    b.TextXAlignment = Enum.TextXAlignment.Left; b.Parent = sidebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 12)
    return b
end

local tabArmy = makeTabBtn("Армия РП", 8); tabArmy.BackgroundColor3 = C.accentDk
local tabTP = makeTabBtn("Телепорты", 46)
local tabAimbot = makeTabBtn("Aimbot", 84)
local tabSettings = makeTabBtn("Настройки", 122)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -156, 1, -54); content.Position = UDim2.new(0, 148, 0, 46)
content.BackgroundColor3 = C.bg; content.BorderSizePixel = 0; content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 6)

local function makePage()
    local p = Instance.new("ScrollingFrame")
    p.Size = UDim2.new(1, -16, 1, -16); p.Position = UDim2.new(0, 8, 0, 8)
    p.BackgroundTransparency = 1; p.BorderSizePixel = 0
    p.CanvasSize = UDim2.new(0, 0, 0, 0); p.ScrollBarThickness = 4
    p.ScrollBarImageColor3 = C.accent; p.Visible = false; p.Parent = content
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 6)
    return p
end

local armyPage = makePage(); armyPage.Visible = true
local tpPage = makePage()
local aimbotPage = makePage()
local settingsPage = makePage()

local function showTab(name)
    armyPage.Visible = false; tpPage.Visible = false
    aimbotPage.Visible = false; settingsPage.Visible = false
    tabArmy.BackgroundColor3 = C.sidebar; tabTP.BackgroundColor3 = C.sidebar
    tabAimbot.BackgroundColor3 = C.sidebar; tabSettings.BackgroundColor3 = C.sidebar
    if name == "army" then armyPage.Visible = true; tabArmy.BackgroundColor3 = C.accentDk
    elseif name == "tp" then tpPage.Visible = true; tabTP.BackgroundColor3 = C.accentDk
    elseif name == "aimbot" then aimbotPage.Visible = true; tabAimbot.BackgroundColor3 = C.accentDk
    else settingsPage.Visible = true; tabSettings.BackgroundColor3 = C.accentDk end
end
tabArmy.MouseButton1Click:Connect(function() showTab("army") end)
tabTP.MouseButton1Click:Connect(function() showTab("tp") end)
tabAimbot.MouseButton1Click:Connect(function() showTab("aimbot") end)
tabSettings.MouseButton1Click:Connect(function() showTab("settings") end)

local togglesData = {}

local function makeToggle(parent, text, hasBadge, onClick)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -12, 0, 42); row.BackgroundColor3 = C.row
    row.BorderSizePixel = 0; row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6); dot.Position = UDim2.new(0, 12, 0.5, -3)
    dot.BackgroundColor3 = C.textDim; dot.BorderSizePixel = 0; dot.Parent = row
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, 0, 1, 0); label.Position = UDim2.new(0, 26, 0, 0)
    label.Text = text; label.TextColor3 = C.text; label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium; label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = row
    if hasBadge then
        local badge = Instance.new("TextLabel")
        badge.Size = UDim2.new(0, 62, 0, 20); badge.Position = UDim2.new(1, -122, 0.5, -10)
        badge.Text = "[ NONE ]"; badge.TextColor3 = C.badgeText
        badge.BackgroundColor3 = C.badge; badge.Font = Enum.Font.GothamMedium
        badge.TextSize = 10; badge.BorderSizePixel = 0; badge.Parent = row
        Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 4)
    end
    local tBg = Instance.new("Frame")
    tBg.Size = UDim2.new(0, 34, 0, 18); tBg.Position = UDim2.new(1, -46, 0.5, -9)
    tBg.BackgroundColor3 = C.toggleOff; tBg.BorderSizePixel = 0; tBg.Parent = row
    Instance.new("UICorner", tBg).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14); knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = C.knob; knob.BorderSizePixel = 0; knob.Parent = tBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0); click.BackgroundTransparency = 1
    click.Text = ""; click.Parent = row
    local state = false
    local function render()
        if state then
            tBg.BackgroundColor3 = C.accent; knob.Position = UDim2.new(1, -16, 0.5, -7)
            dot.BackgroundColor3 = C.accent
        else
            tBg.BackgroundColor3 = C.toggleOff; knob.Position = UDim2.new(0, 2, 0.5, -7)
            dot.BackgroundColor3 = C.textDim
        end
    end
    local api = {set = function(v) state = v; render(); if onClick then onClick(state) end end,
                 get = function() return state end}
    click.MouseButton1Click:Connect(function()
        state = not state; render(); if onClick then onClick(state) end
    end)
    table.insert(togglesData, {api = api, tBg = tBg, dot = dot})
    return api
end

local function makeSlider(parent, label, minVal, maxVal, defaultVal, isFloat, onChange)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -12, 0, 58); row.BackgroundColor3 = C.row
    row.BorderSizePixel = 0; row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, -12, 0, 18); lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.TextColor3 = C.text; lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.3, -12, 0, 18); valLbl.Position = UDim2.new(0.7, 0, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = isFloat and string.format("%.2f", defaultVal) or tostring(defaultVal)
    valLbl.TextColor3 = C.accent; valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 12; valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.Parent = row
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -24, 0, 6); barBg.Position = UDim2.new(0, 12, 0, 34)
    barBg.BackgroundColor3 = C.toggleOff; barBg.BorderSizePixel = 0; barBg.Parent = row
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = C.accent
    barFill.BorderSizePixel = 0; barFill.Parent = barBg
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14); knob.Position = UDim2.new(0, 0, 0.5, -7)
    knob.BackgroundColor3 = C.knob; knob.BorderSizePixel = 0; knob.ZIndex = 2; knob.Parent = barBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local value = defaultVal
    local function setValue(v)
        v = math.clamp(v, minVal, maxVal)
        if not isFloat then v = math.floor(v) end
        value = v
        valLbl.Text = isFloat and string.format("%.2f", v) or tostring(v)
        local pct = (v - minVal) / (maxVal - minVal)
        barFill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, -7, 0.5, -7)
        if onChange then onChange(v) end
    end
    setValue(defaultVal)
    local dragging2 = false
    local function updateFromX(x)
        local relX = x - barBg.AbsolutePosition.X
        local pct = math.clamp(relX / barBg.AbsoluteSize.X, 0, 1)
        setValue(minVal + pct * (maxVal - minVal))
    end
    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging2 = true; updateFromX(input.Position.X)
        end
    end)
    uis.InputChanged:Connect(function(input)
        if dragging2 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging2 = false
        end
    end)
    return {set = setValue, get = function() return value end}
end

local function makeSectionLabel(parent, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 22); lbl.BackgroundTransparency = 1
    lbl.Text = text; lbl.TextColor3 = C.badgeText; lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = parent
    return lbl
end

local function makeButton(parent, text, color, onClick)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 42); b.BackgroundColor3 = color or C.accentDk
    b.Text = text; b.TextColor3 = C.text
    b.Font = Enum.Font.GothamBold; b.TextSize = 12
    b.BorderSizePixel = 0; b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(onClick)
    return b
end

local function getHum() local c = player.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function getHRP() local c = player.Character; return c and c:FindFirstChild("HumanoidRootPart") end

local function showNotif(text, color)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 500, 0, 50)
    notif.Position = UDim2.new(0.5, -250, 0.15, 0)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    notif.BackgroundTransparency = 0.15
    notif.Text = text; notif.TextColor3 = color or C.text
    notif.Font = Enum.Font.GothamBold; notif.TextSize = 14
    notif.BorderSizePixel = 0; notif.ZIndex = 999; notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    return notif
end

-- ═══ ESP ═══
local espList, espData, espConn = {}, {}, nil
local playerConns = {}
local function clearESP()
    for _, o in ipairs(espList) do pcall(function() o:Destroy() end) end
    espList, espData = {}, {}
end
local function getFactionColor(plr)
    if plr.Team and plr.Team.TeamColor then return plr.Team.TeamColor.Color end
    return Color3.fromRGB(200,200,200)
end
local function formatNum(n)
    if not n then return "—" end
    n = tonumber(n) or 0
    if n >= 1e6 then return string.format("%.1fM", n/1e6) end
    if n >= 1e3 then return string.format("%.1fK", n/1e3) end
    return tostring(math.floor(n))
end
local statCache = {}
local function updateStats()
    for _, d in ipairs(espData) do
        local plr = d.plr
        local cache = statCache[plr]
        if not cache then cache = {}; statCache[plr] = cache end
        local containers = {plr:FindFirstChild("leaderstats"), plr:FindFirstChild("Stats"), plr}
        local cash, minutes
        for _, c in ipairs(containers) do
            if c then
                local v = c:FindFirstChild("Cash") or c:FindFirstChild("Деньги") or c:FindFirstChild("Money") or c:FindFirstChild("Баланс")
                if v and (v:IsA("IntValue") or v:IsA("NumberValue")) then cash = v.Value; break end
            end
        end
        for _, c in ipairs(containers) do
            if c then
                local v = c:FindFirstChild("Minute") or c:FindFirstChild("Minutes") or c:FindFirstChild("Минуты") or c:FindFirstChild("Time")
                if v and (v:IsA("IntValue") or v:IsA("NumberValue")) then minutes = v.Value; break end
            end
        end
        cache.cash = cash; cache.minutes = minutes
        cache.faction = plr.Team and plr.Team.Name or nil
        cache.factionColor = getFactionColor(plr)
    end
end
local function createESP(plr)
    if plr == player then return end
    local ch = plr.Character; if not ch then return end
    local head = ch:FindFirstChild("Head"); if not head then return end
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 260, 0, 68); bb.StudsOffset = Vector3.new(0, 3.5, 0); bb.AlwaysOnTop = true; bb.Parent = head
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Color3.fromRGB(0,0,0); bg.BackgroundTransparency = 0.85
    bg.BorderSizePixel = 0; bg.Parent = bb
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 3)
    local function mt(pos, size, font, txtSize, color, align)
        local t = Instance.new("TextLabel")
        t.Size = size; t.Position = pos; t.BackgroundTransparency = 1; t.Font = font
        t.TextSize = txtSize; t.TextColor3 = color; t.TextXAlignment = align
        t.TextStrokeTransparency = 0; t.TextStrokeColor3 = Color3.fromRGB(0,0,0); t.Parent = bg; return t
    end
    local nameL = mt(UDim2.new(0,3,0,1), UDim2.new(0.45,-3,0,15), Enum.Font.GothamBold, 11, Color3.fromRGB(255,255,255), Enum.TextXAlignment.Left)
    local factionL = mt(UDim2.new(0.45,0,0,1), UDim2.new(0.4,-3,0,15), Enum.Font.GothamBold, 11, Color3.fromRGB(255,200,50), Enum.TextXAlignment.Left)
    local hpTextL = mt(UDim2.new(0.85,0,0,1), UDim2.new(0.15,-3,0,15), Enum.Font.GothamBold, 10, Color3.fromRGB(100,255,100), Enum.TextXAlignment.Right)
    local distL = mt(UDim2.new(0,3,0,18), UDim2.new(0.4,-3,0,13), Enum.Font.GothamBold, 10, Color3.fromRGB(255,200,50), Enum.TextXAlignment.Left)
    local cashL = mt(UDim2.new(0.4,0,0,18), UDim2.new(0.3,-3,0,13), Enum.Font.GothamBold, 10, Color3.fromRGB(100,255,100), Enum.TextXAlignment.Center)
    local minL = mt(UDim2.new(0.7,0,0,18), UDim2.new(0.3,-3,0,13), Enum.Font.GothamBold, 10, Color3.fromRGB(100,200,255), Enum.TextXAlignment.Right)
    local hpBg = Instance.new("Frame")
    hpBg.Size = UDim2.new(1,-6,0,4); hpBg.Position = UDim2.new(0,3,0,34)
    hpBg.BackgroundColor3 = Color3.fromRGB(40,15,15); hpBg.BackgroundTransparency = 0.4; hpBg.BorderSizePixel = 0; hpBg.Parent = bg
    Instance.new("UICorner", hpBg).CornerRadius = UDim.new(1,0)
    local hpF = Instance.new("Frame")
    hpF.Size = UDim2.new(1,0,1,0); hpF.BackgroundColor3 = Color3.fromRGB(0,200,0); hpF.BackgroundTransparency = 0.15
    hpF.BorderSizePixel = 0; hpF.Parent = hpBg
    Instance.new("UICorner", hpF).CornerRadius = UDim.new(1,0)
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255,0,0); hl.FillTransparency = 0.85
    hl.OutlineColor = Color3.fromRGB(255,255,0); hl.OutlineTransparency = 0.3; hl.Parent = ch
    table.insert(espList, hl)
    return {bb = bb, nameL = nameL, factionL = factionL, distL = distL, hpTextL = hpTextL, cashL = cashL, minL = minL, hpF = hpF, plr = plr}
end
local function refreshPlayerESP(plr)
    if plr == player or not plr.Character then return end
    for i = #espData, 1, -1 do if espData[i].plr == plr then pcall(function() espData[i].bb:Destroy() end); table.remove(espData, i) end end
    local d = createESP(plr)
    if d then table.insert(espList, d.bb); table.insert(espData, d) end
end
local function removePlayerESP(plr)
    statCache[plr] = nil
    for i = #espData, 1, -1 do if espData[i].plr == plr then pcall(function() espData[i].bb:Destroy() end); table.remove(espData, i) end end
end
local function hookPlayer(plr)
    if plr == player or playerConns[plr] then return end
    playerConns[plr] = true
    plr.CharacterAdded:Connect(function() task.wait(0.5); if espConn then refreshPlayerESP(plr) end end)
    plr.CharacterRemoving:Connect(function() task.wait(0.1); removePlayerESP(plr) end)
end
game.Players.PlayerAdded:Connect(function(plr) hookPlayer(plr); task.wait(1); if espConn then refreshPlayerESP(plr) end end)
game.Players.PlayerRemoving:Connect(function(plr) playerConns[plr] = nil; removePlayerESP(plr) end)
local function startESP()
    clearESP()
    for _, p in ipairs(game.Players:GetPlayers()) do
        hookPlayer(p)
        if p ~= player and p.Character then
            local d = createESP(p)
            if d then table.insert(espList, d.bb); table.insert(espData, d) end
        end
    end
    espConn = runService.RenderStepped:Connect(function()
        local myHRP = getHRP()
        for _, d in ipairs(espData) do
            local char = d.plr.Character
            if char and d.bb.Parent then
                local theirHRP = char:FindFirstChild("HumanoidRootPart")
                if myHRP and theirHRP then
                    local dist = (myHRP.Position - theirHRP.Position).Magnitude
                    d.distL.Text = string.format("📍%.0fм", dist)
                    if dist < 30 then d.distL.TextColor3 = Color3.fromRGB(255,80,80)
                    elseif dist < 100 then d.distL.TextColor3 = Color3.fromRGB(255,200,50)
                    else d.distL.TextColor3 = Color3.fromRGB(100,200,255) end
                else d.distL.Text = "📍—" end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    local pct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    d.hpF.Size = UDim2.new(pct, 0, 1, 0)
                    d.hpTextL.Text = string.format("❤%d", math.floor(hum.Health))
                    if pct > 0.6 then d.hpF.BackgroundColor3 = Color3.fromRGB(0,200,0); d.hpTextL.TextColor3 = Color3.fromRGB(100,255,100)
                    elseif pct > 0.3 then d.hpF.BackgroundColor3 = Color3.fromRGB(255,200,0); d.hpTextL.TextColor3 = Color3.fromRGB(255,200,50)
                    else d.hpF.BackgroundColor3 = Color3.fromRGB(255,0,0); d.hpTextL.TextColor3 = Color3.fromRGB(255,80,80) end
                end
            end
        end
    end)
    task.spawn(function()
        while espConn do
            updateStats()
            for _, d in ipairs(espData) do
                local cache = statCache[d.plr]
                if cache and d.bb.Parent then
                    d.nameL.Text = d.plr.Name
                    if cache.faction and cache.faction ~= "" then
                        d.factionL.Text = "| " .. cache.faction
                        d.factionL.TextColor3 = cache.factionColor
                    else
                        d.factionL.Text = "| Без фракции"
                        d.factionL.TextColor3 = Color3.fromRGB(140,140,140)
                    end
                    d.cashL.Text = "💰" .. formatNum(cache.cash)
                    d.minL.Text = "⏱" .. formatNum(cache.minutes)
                end
            end
            task.wait(0.5)
        end
    end)
end
local function stopESP()
    if espConn then espConn:Disconnect(); espConn = nil end
    clearESP(); playerConns = {}; statCache = {}
end

-- ═══ AIMBOT (ТОЧНЫЙ) ═══
local aimbotOn = false
local aimbotConn = nil
local aimbotFOV = 300
local aimbotSmooth = 0.35
local aimbotVisible = true
local aimbotButtonMode = "RMB"
local aimbotPrediction = true
local aimbotSticky = true
local aimbotTargetMode = "Auto" -- "Auto" | "Head" | "Body"
local currentTarget = nil

local function isAimbotActive()
    if aimbotButtonMode == "Always" then return true end
    if aimbotButtonMode == "RMB" then return uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end
    if aimbotButtonMode == "LMB" then return uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end
    return false
end

local function getPing(plr)
    local ok, p = pcall(function() return plr:GetNetworkPing() end)
    if ok and type(p) == "number" and p > 0 then return p end
    return 0.05
end

local function rayVisible(from, to, ignoreChar)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local filter = {}
    if player.Character then table.insert(filter, player.Character) end
    if ignoreChar then table.insert(filter, ignoreChar) end
    params.FilterDescendantsInstances = filter
    local ray = workspace:Raycast(from, to - from, params)
    return ray == nil -- ничего не задели => видно
end

local function getAimParts(char)
    local out = {}
    if aimbotTargetMode == "Head" then
        local h = char:FindFirstChild("Head")
        if h then table.insert(out, h) end
    elseif aimbotTargetMode == "Body" then
        local u = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if u then table.insert(out, u) end
    else -- Auto
        local h = char:FindFirstChild("Head")
        local u = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if h then table.insert(out, h) end
        if u and u ~= h then table.insert(out, u) end
    end
    return out
end

local function scoreTarget(part, scrCenter, myPos)
    local sp, onScreen = camera:WorldToViewportPoint(part.Position)
    if not onScreen then return nil end
    local d2d = (Vector2.new(sp.X, sp.Y) - scrCenter).Magnitude
    if d2d > aimbotFOV then return nil end
    if aimbotVisible and not rayVisible(myPos, part.Position, part.Parent) then return nil end
    local d3d = (myPos - part.Position).Magnitude
    return d2d + d3d * 0.05
end

local function findTarget()
    local myPos = camera.CFrame.Position
    local scrCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    local best, bestScore = nil, math.huge
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                for _, part in ipairs(getAimParts(plr.Character)) do
                    local score = scoreTarget(part, scrCenter, myPos)
                    if score and score < bestScore then
                        bestScore = score
                        best = {part = part, character = plr.Character, player = plr}
                    end
                end
            end
        end
    end
    return best
end

local function validateTarget(t)
    if not t or not t.player or not t.player.Parent then return false end
    if not t.character or not t.character.Parent then return false end
    if t.part.Parent ~= t.character then return false end
    local hum = t.character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local myPos = camera.CFrame.Position
    local scrCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    local score = scoreTarget(t.part, scrCenter, myPos)
    if not score or score > aimbotFOV * 1.5 then return false end
    return true
end

local function predictPos(target)
    if not aimbotPrediction then return target.part.Position end
    local vel = target.part.AssemblyLinearVelocity
    if not vel or vel.Magnitude < 1 then return target.part.Position end
    local ping = getPing(target.player)
    local lead = ping + 0.03 -- пинг + небольшой запас на "время пули"
    return target.part.Position + vel * lead
end

local function startAimbot()
    if aimbotConn then aimbotConn:Disconnect() end
    currentTarget = nil
    aimbotConn = runService.RenderStepped:Connect(function(dt)
        if not aimbotOn then return end
        if not isAimbotActive() then currentTarget = nil; return end
        if dt <= 0 then return end

        local target
        if aimbotSticky and currentTarget and validateTarget(currentTarget) then
            target = currentTarget
        else
            target = findTarget()
            currentTarget = target
        end

        if target then
            local aimPos = predictPos(target)
            local camPos = camera.CFrame.Position
            local desired = CFrame.new(camPos, aimPos)
            -- Фрейм-независимая плавность:
            -- smooth=0.05 → мгновенно, smooth=1 → медленно
            local alpha = math.clamp(dt / math.max(aimbotSmooth, 0.01) * 10, 0, 1)
            camera.CFrame = camera.CFrame:Lerp(desired, alpha)
        end
    end)
end

local function stopAimbot()
    if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
    currentTarget = nil
end

makeSectionLabel(aimbotPage, "🎯 УПРАВЛЕНИЕ")
makeToggle(aimbotPage, "Аимбот включён", true, function(on) aimbotOn = on; if on then startAimbot() else stopAimbot() end end)

local btnModeRow = Instance.new("Frame")
btnModeRow.Size = UDim2.new(1,-12,0,62); btnModeRow.BackgroundColor3 = C.row
btnModeRow.BorderSizePixel = 0; btnModeRow.Parent = aimbotPage
Instance.new("UICorner", btnModeRow).CornerRadius = UDim.new(0,6)
local btnModeLbl = Instance.new("TextLabel")
btnModeLbl.Size = UDim2.new(1,-20,0,18); btnModeLbl.Position = UDim2.new(0,12,0,4)
btnModeLbl.BackgroundTransparency = 1; btnModeLbl.Text = "Кнопка активации"
btnModeLbl.TextColor3 = C.text; btnModeLbl.Font = Enum.Font.GothamMedium
btnModeLbl.TextSize = 12; btnModeLbl.TextXAlignment = Enum.TextXAlignment.Left; btnModeLbl.Parent = btnModeRow
local function makeModeBtn(text, x, mode)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.31,-6,0,28); b.Position = UDim2.new(x,0,0,28)
    b.Text = text; b.TextColor3 = C.text
    b.BackgroundColor3 = (aimbotButtonMode == mode) and C.accent or C.badge
    b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.BorderSizePixel = 0; b.Parent = btnModeRow
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
    return b
end
local btnRMB = makeModeBtn("ПКМ", 0.02, "RMB")
local btnLMB = makeModeBtn("ЛКМ", 0.345, "LMB")
local btnAlways = makeModeBtn("Всегда", 0.67, "Always")
local modeBtns = {["RMB"]=btnRMB, ["LMB"]=btnLMB, ["Always"]=btnAlways}
local function setMode(m)
    aimbotButtonMode = m
    for k, b in pairs(modeBtns) do
        if k == m then b.BackgroundColor3 = C.accent else b.BackgroundColor3 = C.badge end
    end
end
btnRMB.MouseButton1Click:Connect(function() setMode("RMB") end)
btnLMB.MouseButton1Click:Connect(function() setMode("LMB") end)
btnAlways.MouseButton1Click:Connect(function() setMode("Always") end)

makeSectionLabel(aimbotPage, "🎯 ЦЕЛЬ")
makeToggle(aimbotPage, "Предсказание (упреждение)", true, function(on) aimbotPrediction = on end)
makeToggle(aimbotPage, "Держать цель (sticky)", true, function(on) aimbotSticky = on; if not on then currentTarget = nil end end)

local partRow = Instance.new("Frame")
partRow.Size = UDim2.new(1,-12,0,62); partRow.BackgroundColor3 = C.row
partRow.BorderSizePixel = 0; partRow.Parent = aimbotPage
Instance.new("UICorner", partRow).CornerRadius = UDim.new(0,6)
local partLbl = Instance.new("TextLabel")
partLbl.Size = UDim2.new(1,-20,0,18); partLbl.Position = UDim2.new(0,12,0,4)
partLbl.BackgroundTransparency = 1; partLbl.Text = "Точка прицеливания"
partLbl.TextColor3 = C.text; partLbl.Font = Enum.Font.GothamMedium
partLbl.TextSize = 12; partLbl.TextXAlignment = Enum.TextXAlignment.Left; partLbl.Parent = partRow

local function makePartBtn(text, x, mode)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.31,-6,0,28); b.Position = UDim2.new(x,0,0,28)
    b.Text = text; b.TextColor3 = C.text
    b.BackgroundColor3 = (aimbotTargetMode == mode) and C.accent or C.badge
    b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.BorderSizePixel = 0; b.Parent = partRow
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
    return b
end
local pBtnAuto = makePartBtn("Авто", 0.02, "Auto")
local pBtnHead = makePartBtn("Голова", 0.345, "Head")
local pBtnBody = makePartBtn("Тело", 0.67, "Body")
local partBtns = {Auto=pBtnAuto, Head=pBtnHead, Body=pBtnBody}
local function setTargetMode(m)
    aimbotTargetMode = m
    for k, b in pairs(partBtns) do
        if k == m then b.BackgroundColor3 = C.accent else b.BackgroundColor3 = C.badge end
    end
    currentTarget = nil
end
pBtnAuto.MouseButton1Click:Connect(function() setTargetMode("Auto") end)
pBtnHead.MouseButton1Click:Connect(function() setTargetMode("Head") end)
pBtnBody.MouseButton1Click:Connect(function() setTargetMode("Body") end)

makeSectionLabel(aimbotPage, "⚙️ ПАРАМЕТРЫ")
makeSlider(aimbotPage, "FOV (радиус)", 50, 800, 300, false, function(v) aimbotFOV = v end)
makeSlider(aimbotPage, "Плавность", 0.05, 1, 0.35, true, function(v) aimbotSmooth = v end)
makeToggle(aimbotPage, "Только видимые", true, function(on) aimbotVisible = on end)

-- ═══ ARMY TAB ═══
makeToggle(armyPage, "ESP Игроков", true, function(on) if on then startESP() else stopESP() end end)
makeToggle(armyPage, "FullBright", true, function(on)
    if on then
        lighting.Brightness = 3; lighting.Ambient = Color3.fromRGB(200,200,200)
        lighting.OutdoorAmbient = Color3.fromRGB(200,200,200); lighting.FogEnd = 1e6; lighting.GlobalShadows = false
    else
        lighting.Brightness = 1; lighting.Ambient = Color3.fromRGB(70,70,70); lighting.OutdoorAmbient = Color3.fromRGB(70,70,70)
    end
end)

local jumpOn = false
uis.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if jumpOn and input.KeyCode == Enum.KeyCode.Space then
        local hrp = getHRP()
        if hrp then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, 1e5, 0); bv.Velocity = Vector3.new(0, 60, 0)
            bv.Parent = hrp; game:GetService("Debris"):AddItem(bv, 0.15)
        end
    end
end)
makeToggle(armyPage, "Прыжок+", true, function(on) jumpOn = on end)

local flyBV, flyConn
local function startFly()
    local hrp, hum = getHRP(), getHum()
    if not hrp or not hum then return end
    hum.PlatformStand = true
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5); flyBV.Velocity = Vector3.new(0,0,0); flyBV.Parent = hrp
    flyConn = runService.RenderStepped:Connect(function()
        if not flyBV or not flyBV.Parent then return end
        local cam = camera.CFrame; local dir = Vector3.new()
        if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + cam.UpVector end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - cam.UpVector end
        if dir.Magnitude > 0 then dir = dir.Unit end
        flyBV.Velocity = dir * 70
    end)
end
local function stopFly()
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    local h = getHum(); if h then h.PlatformStand = false end
end
makeToggle(armyPage, "Fly", true, function(on) if on then startFly() else stopFly() end end)

-- 👻 GHOST с вращением камеры + слайдер скорости
local ghostOn = false
local ghostCamConn = nil
local ghostMouseConn = nil
local ghostCamPos = nil
local ghostYaw = 0
local ghostPitch = 0
local ghostSavedCamType = nil
local ghostSavedMouseBehavior = nil
local ghostSavedSpeed = 16
local ghostSpeed = 70
local GHOST_SENS = 0.25

local function startGhost()
    local hrp = getHRP()
    local hum = getHum()
    if not hrp or not hum then
        showNotif("❌ Нет персонажа", Color3.fromRGB(255,100,100))
        return
    end
    ghostSavedSpeed = hum.WalkSpeed
    -- Замораживаем тело
    for _, p in ipairs(player.Character:GetDescendants()) do
        if p:IsA("BasePart") then p.Anchored = true end
    end
    hum.PlatformStand = true
    hum.WalkSpeed = 0
    hum.JumpPower = 0
    -- Запоминаем ориентацию камеры
    local look = camera.CFrame.LookVector
    ghostYaw = math.atan2(-look.X, -look.Z)
    ghostPitch = math.asin(math.clamp(look.Y, -1, 1))
    ghostCamPos = camera.CFrame.Position
    -- Отцепляем камеру
    ghostSavedCamType = camera.CameraType
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CameraSubject = nil
    -- Фиксируем мышь
    ghostSavedMouseBehavior = uis.MouseBehavior
    uis.MouseBehavior = Enum.MouseBehavior.LockCenter
    -- Читаем движение мыши для поворота
    ghostMouseConn = uis.InputChanged:Connect(function(input)
        if not ghostOn then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            ghostYaw = ghostYaw - math.rad(input.Delta.X) * GHOST_SENS
            ghostPitch = math.clamp(ghostPitch - math.rad(input.Delta.Y) * GHOST_SENS, -math.rad(89), math.rad(89))
        end
    end)
    -- Обработчик полёта
    ghostCamConn = runService.RenderStepped:Connect(function(dt)
        if not ghostOn then return end
        -- Авто-разблокировка мыши при открытом меню
        if main.Visible then
            if uis.MouseBehavior ~= Enum.MouseBehavior.Default then
                uis.MouseBehavior = Enum.MouseBehavior.Default
            end
        else
            if uis.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                uis.MouseBehavior = Enum.MouseBehavior.LockCenter
            end
        end
        -- CFrame из yaw/pitch
        local rotation = CFrame.fromEulerAnglesYXZ(ghostPitch, ghostYaw, 0)
        local look = rotation.LookVector
        local right = rotation.RightVector
        local up = Vector3.new(0, 1, 0)
        local dir = Vector3.new()
        if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + look end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - look end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - right end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + right end
        if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + up end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - up end
        if dir.Magnitude > 0 then dir = dir.Unit end
        ghostCamPos = ghostCamPos + dir * ghostSpeed * dt
        camera.CFrame = CFrame.new(ghostCamPos) * rotation
    end)
    local n = showNotif("👻 Ghost ВКЛ — мышь=поворот, WASD=полёт, Space/Ctrl=высота", Color3.fromRGB(150,200,255))
    game:GetService("Debris"):AddItem(n, 5)
end

local function stopGhost()
    ghostOn = false
    if ghostCamConn then ghostCamConn:Disconnect(); ghostCamConn = nil end
    if ghostMouseConn then ghostMouseConn:Disconnect(); ghostMouseConn = nil end
    -- Возврат мыши
    if ghostSavedMouseBehavior then
        uis.MouseBehavior = ghostSavedMouseBehavior
    end
    -- Возврат камеры
    if ghostSavedCamType then
        camera.CameraType = ghostSavedCamType
    end
    local hum = getHum()
    if hum then camera.CameraSubject = hum end
    -- Разморозка тела
    if player.Character then
        for _, p in ipairs(player.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.Anchored = false end
        end
    end
    if hum then
        hum.PlatformStand = false
        hum.WalkSpeed = ghostSavedSpeed
        hum.JumpPower = 50
    end
    local n = showNotif("👻 Ghost ВЫКЛ — тело разморожено", Color3.fromRGB(255,200,80))
    game:GetService("Debris"):AddItem(n, 3)
end

makeToggle(armyPage, "👻 Ghost (стою, но летаю)", true, function(on)
    if on then ghostOn = true; startGhost() else stopGhost() end
end)
makeSlider(armyPage, "👻 Скорость Ghost", 10, 300, 70, false, function(v) ghostSpeed = v end)

local ncConn
local function startNC()
    if ncConn then return end
    ncConn = runService.RenderStepped:Connect(function()
        local c = player.Character; if not c then return end
        for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end)
end
local function stopNC()
    if ncConn then ncConn:Disconnect(); ncConn = nil end
    local c = player.Character
    if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
end
makeToggle(armyPage, "Noclip", true, function(on) if on then startNC() else stopNC() end end)

local defaultSpeed = 16
local function setSpeed(v) local h = getHum(); if h then h.WalkSpeed = v end end
makeToggle(armyPage, "Скорость бега x5", true, function(on) setSpeed(on and 80 or defaultSpeed) end)

local vehicleActive = false
local currentVehSpeed = 50
local vehConn = nil
local function getVeh() local h = getHum(); if h and h.SeatPart then return h.SeatPart.Parent end end
local function startVeh()
    if vehConn then vehConn:Disconnect() end
    vehConn = runService.RenderStepped:Connect(function()
        if vehicleActive then
            local v = getVeh()
            if v and currentVehSpeed > 0 then
                local r = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("PrimaryPart")
                if r then
                    local d = r.AssemblyLinearVelocity.Unit
                    if d.Magnitude < 0.1 then d = camera.CFrame.LookVector end
                    r.AssemblyLinearVelocity = r.AssemblyLinearVelocity:Lerp(d * currentVehSpeed, 0.3)
                end
            end
        end
    end)
end
local function stopVeh() if vehConn then vehConn:Disconnect(); vehConn = nil end end
makeToggle(armyPage, "Авто-скорость машины", true, function(on) vehicleActive = on; if on then startVeh() else stopVeh() end end)

local deathTPActive = false
local function doDeathTP()
    if deathTPActive then return end
    deathTPActive = true
    local hrp = getHRP()
    if not hrp then
        showNotif("❌ Не смог сохранить позицию", Color3.fromRGB(255,100,100))
        deathTPActive = false; return
    end
    local savedPos = hrp.CFrame
    local notif = showNotif("💀 Умираю... Возрождение через 11 сек", Color3.fromRGB(255,100,100))
    local respawned = false
    local respawnConn = player.CharacterAdded:Connect(function() respawned = true end)
    local hum = getHum()
    if hum then pcall(function() hum.Health = 0 end) end
    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < 11 do task.wait(0.1) end
        local waitStart = tick()
        while not respawned and tick() - waitStart < 10 do task.wait(0.1) end
        if respawnConn then respawnConn:Disconnect() end
        task.wait(0.5)
        local newHRP = getHRP()
        if newHRP and savedPos then
            newHRP.CFrame = savedPos + Vector3.new(0, 3, 0)
            task.wait(0.3); newHRP.CFrame = savedPos + Vector3.new(0, 3, 0)
            task.wait(0.3); newHRP.CFrame = savedPos + Vector3.new(0, 3, 0)
            if notif then notif:Destroy() end
            local done = showNotif("✅ Возрождён на месте смерти!", Color3.fromRGB(100,255,100))
            game:GetService("Debris"):AddItem(done, 3)
        else
            if notif then notif:Destroy() end
            showNotif("❌ Не смог телепортироваться", Color3.fromRGB(255,100,100))
        end
        deathTPActive = false
    end)
end
makeButton(armyPage, "💀 Смерть + ТП назад (11 сек)", Color3.fromRGB(80, 30, 30), doDeathTP)

-- 📍 МОИ КООРДИНАТЫ
local coordsWin = nil
local coordsConn = nil
local coordsLabel = nil
local coordsCopyBtn = nil
local lastCoordsText = ""

local function closeCoordsWin()
    if coordsConn then coordsConn:Disconnect(); coordsConn = nil end
    if coordsWin then coordsWin:Destroy(); coordsWin = nil end
    coordsLabel = nil
    coordsCopyBtn = nil
end

local function openCoordsWin()
    closeCoordsWin()
    coordsWin = Instance.new("ScreenGui")
    coordsWin.Name = "CoordsWin"; coordsWin.ResetOnSpawn = false; coordsWin.Parent = gui.Parent

    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 300, 0, 200); f.Position = UDim2.new(0.5, -150, 0.5, -100)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = coordsWin
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 32); title.Text = "📍 МОИ КООРДИНАТЫ"
    title.TextColor3 = Color3.fromRGB(240,240,245); title.BackgroundColor3 = C.topbar
    title.Font = Enum.Font.GothamBold; title.TextSize = 13; title.BorderSizePixel = 0; title.Parent = f
    title.Active = true
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)

    local dr, ds, sp = false, nil, nil
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dr = true; ds = input.Position; sp = f.Position
        end
    end)
    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dr = false end
    end)
    uis.InputChanged:Connect(function(input)
        if dr and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - ds
            f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)

    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 26, 0, 26); xb.Position = UDim2.new(1, -30, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0; xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closeCoordsWin)

    coordsLabel = Instance.new("TextLabel")
    coordsLabel.Size = UDim2.new(0.92, 0, 0, 80); coordsLabel.Position = UDim2.new(0.04, 0, 0.25, 0)
    coordsLabel.BackgroundColor3 = C.row; coordsLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    coordsLabel.Font = Enum.Font.Code; coordsLabel.TextSize = 16
    coordsLabel.Text = "X: —\nY: —\nZ: —"
    coordsLabel.BorderSizePixel = 0; coordsLabel.Parent = f
    Instance.new("UICorner", coordsLabel).CornerRadius = UDim.new(0, 6)

    coordsCopyBtn = Instance.new("TextButton")
    coordsCopyBtn.Size = UDim2.new(0.92, 0, 0, 36); coordsCopyBtn.Position = UDim2.new(0.04, 0, 0.75, 0)
    coordsCopyBtn.Text = "📋 Скопировать координаты"
    coordsCopyBtn.TextColor3 = C.text
    coordsCopyBtn.BackgroundColor3 = C.accent
    coordsCopyBtn.Font = Enum.Font.GothamBold; coordsCopyBtn.TextSize = 12
    coordsCopyBtn.BorderSizePixel = 0; coordsCopyBtn.Parent = f
    Instance.new("UICorner", coordsCopyBtn).CornerRadius = UDim.new(0, 6)

    coordsCopyBtn.MouseButton1Click:Connect(function()
        if lastCoordsText == "" then
            local n = showNotif("❌ Координаты недоступны", Color3.fromRGB(255,100,100))
            game:GetService("Debris"):AddItem(n, 2); return
        end
        if setclipboard then
            local ok = pcall(function() setclipboard(lastCoordsText) end)
            if ok then
                local n = showNotif("✅ Скопировано: " .. lastCoordsText, Color3.fromRGB(100,255,100))
                game:GetService("Debris"):AddItem(n, 3)
            else
                local n = showNotif("❌ Не удалось скопировать", Color3.fromRGB(255,100,100))
                game:GetService("Debris"):AddItem(n, 3)
            end
        else
            print("[COORDS] " .. lastCoordsText)
            local n = showNotif("⚠ setclipboard нет — вывод в F9", Color3.fromRGB(255,200,80))
            game:GetService("Debris"):AddItem(n, 4)
        end
    end)

    coordsConn = runService.RenderStepped:Connect(function()
        local hrp = getHRP()
        if hrp and coordsLabel then
            local p = hrp.Position
            coordsLabel.Text = string.format("X: %.1f\nY: %.1f\nZ: %.1f", p.X, p.Y, p.Z)
            lastCoordsText = string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z)
        elseif coordsLabel then
            coordsLabel.Text = "X: —\nY: —\nZ: —"
            lastCoordsText = ""
        end
    end)
end

makeButton(armyPage, "📍 Мои координаты (X Y Z)", Color3.fromRGB(60, 110, 80), openCoordsWin)

local tpClickOn = false
local tpClickConn = nil
local tpClickIndicator = nil
local function startTpClick()
    tpClickOn = true
    if not tpClickIndicator then
        tpClickIndicator = Instance.new("TextLabel")
        tpClickIndicator.Size = UDim2.new(0, 500, 0, 40)
        tpClickIndicator.Position = UDim2.new(0.5, -250, 0, 50)
        tpClickIndicator.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        tpClickIndicator.BackgroundTransparency = 0.3
        tpClickIndicator.Text = "📍 TP ПО КЛИКУ ВКЛ — кликни в любое место"
        tpClickIndicator.TextColor3 = Color3.fromRGB(130, 70, 220)
        tpClickIndicator.Font = Enum.Font.GothamBold; tpClickIndicator.TextSize = 14
        tpClickIndicator.BorderSizePixel = 0; tpClickIndicator.ZIndex = 999; tpClickIndicator.Parent = gui
        Instance.new("UICorner", tpClickIndicator).CornerRadius = UDim.new(0, 8)
    end
    tpClickIndicator.Visible = true
    tpClickConn = uis.InputBegan:Connect(function(input, gpe)
        if not tpClickOn then return end
        if gpe then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = uis:GetMouseLocation()
            local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {player.Character}
            local result = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
            if result and result.Position then
                local hrp = getHRP()
                if hrp then hrp.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0)) end
            end
        end
    end)
end
local function stopTpClick()
    tpClickOn = false
    if tpClickConn then tpClickConn:Disconnect(); tpClickConn = nil end
    if tpClickIndicator then tpClickIndicator.Visible = false end
end
makeToggle(armyPage, "📍 TP по клику", true, function(on) if on then startTpClick() else stopTpClick() end end)

-- 🎒 МОЙ РЮКЗАК
local myBagGui, myBagRows = nil, {}
local function closeMyBagWindow()
    if myBagGui then myBagGui:Destroy(); myBagGui = nil end
    myBagRows = {}
end
local function getMyItems()
    local items = {}
    if player.Character then
        for _, t in ipairs(player.Character:GetChildren()) do
            if t:IsA("Tool") then table.insert(items, {tool = t, equipped = true}) end
        end
    end
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then table.insert(items, {tool = t, equipped = false}) end
        end
    end
    return items
end
local function openMyBagWindow()
    closeMyBagWindow()
    myBagGui = Instance.new("ScreenGui")
    myBagGui.Name = "MyBag"; myBagGui.ResetOnSpawn = false; myBagGui.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 340, 0, 480); f.Position = UDim2.new(0.5, -170, 0.5, -240)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = myBagGui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 35); t.Text = "🎒 МОЙ РЮКЗАК"
    t.TextColor3 = Color3.fromRGB(240,240,245); t.BackgroundColor3 = C.topbar
    t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.BorderSizePixel = 0; t.Parent = f
    t.Active = true
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
    local bagDrag, bagDS, bagSP = false, nil, nil
    t.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            bagDrag = true; bagDS = input.Position; bagSP = f.Position
        end
    end)
    t.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            bagDrag = false
        end
    end)
    uis.InputChanged:Connect(function(input)
        if bagDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - bagDS
            f.Position = UDim2.new(bagSP.X.Scale, bagSP.X.Offset + d.X, bagSP.Y.Scale, bagSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 28, 0, 28); xb.Position = UDim2.new(1, -33, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0
    xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closeMyBagWindow)
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0, 90, 0, 22); refreshBtn.Position = UDim2.new(1, -94, 0.1, 0)
    refreshBtn.Text = "🔄 Обновить"; refreshBtn.TextColor3 = C.text
    refreshBtn.BackgroundColor3 = C.accentDk; refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.TextSize = 10; refreshBtn.BorderSizePixel = 0; refreshBtn.Parent = f
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92, 0, 0.82, 0); sb.Position = UDim2.new(0.04, 0, 0.14, 0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0,6)
    local function refresh()
        for _, r in ipairs(myBagRows) do pcall(function() r:Destroy() end) end
        myBagRows = {}
        local items = getMyItems()
        for _, data in ipairs(items) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -8, 0, 34); b.Text = (data.equipped and "🔫 " or "📦 ") .. data.tool.Name
            b.TextColor3 = data.equipped and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(220, 230, 250)
            b.BackgroundColor3 = data.equipped and Color3.fromRGB(50, 45, 70) or C.row
            b.Font = Enum.Font.GothamBold; b.TextSize = 11
            b.BorderSizePixel = 0; b.TextXAlignment = Enum.TextXAlignment.Left; b.AutoButtonColor = false
            b.Parent = sb
            local pad = Instance.new("UIPadding", b); pad.PaddingLeft = UDim.new(0, 8)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
            b.MouseButton1Click:Connect(function()
                local tool = data.tool
                if not tool or not tool.Parent then return end
                local hum = getHum()
                if data.equipped then
                    local bp2 = player:FindFirstChild("Backpack")
                    if bp2 then tool.Parent = bp2 end
                else
                    if player.Character then
                        tool.Parent = player.Character
                        if hum then hum:EquipTool(tool) end
                    end
                end
                task.wait(0.15); refresh()
            end)
            table.insert(myBagRows, b)
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do
            if c:IsA("TextButton") then h = h + c.Size.Y.Offset + 6 end
        end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    refreshBtn.MouseButton1Click:Connect(refresh)
    refresh()
end
makeToggle(armyPage, "🎒 Мой рюкзак", false, function(on) if on then openMyBagWindow() else closeMyBagWindow() end end)

-- ═══ 🎒 ИНВЕНТАРЬ ДРУГОГО ИГРОКА ═══
local pInvPicker = nil
local function closePlayerInvPicker()
    if pInvPicker then pInvPicker:Destroy(); pInvPicker = nil end
end

local pInvWin, pInvRows = nil, {}
local function closePlayerInvWin()
    if pInvWin then pInvWin:Destroy(); pInvWin = nil end
    pInvRows = {}
end
local function getPlayerItems(plr)
    local items = {}
    if not plr then return items end
    if plr.Character then
        for _, t in ipairs(plr.Character:GetChildren()) do
            if t:IsA("Tool") then table.insert(items, {tool = t, equipped = true}) end
        end
    end
    local bp = plr:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then table.insert(items, {tool = t, equipped = false}) end
        end
    end
    return items
end

local function openPlayerInventoryWin(plr)
    closePlayerInvWin()
    if not plr then return end
    pInvWin = Instance.new("ScreenGui")
    pInvWin.Name = "PlayerBag"; pInvWin.ResetOnSpawn = false; pInvWin.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 360, 0, 500); f.Position = UDim2.new(0.5, -180, 0.5, -250)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = pInvWin
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 35); t.Text = "🎒 ИНВЕНТАРЬ: " .. plr.Name
    t.TextColor3 = Color3.fromRGB(240,240,245); t.BackgroundColor3 = C.topbar
    t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.BorderSizePixel = 0; t.Parent = f
    t.Active = true
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
    local pDrag, pDS, pSP = false, nil, nil
    t.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            pDrag = true; pDS = input.Position; pSP = f.Position
        end
    end)
    t.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then pDrag = false end
    end)
    uis.InputChanged:Connect(function(input)
        if pDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - pDS
            f.Position = UDim2.new(pSP.X.Scale, pSP.X.Offset + d.X, pSP.Y.Scale, pSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 28, 0, 28); xb.Position = UDim2.new(1, -33, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0; xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closePlayerInvWin)
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0, 90, 0, 22); refreshBtn.Position = UDim2.new(1, -94, 0.09, 0)
    refreshBtn.Text = "🔄 Обновить"; refreshBtn.TextColor3 = C.text
    refreshBtn.BackgroundColor3 = C.accentDk; refreshBtn.Font = Enum.Font.GothamBold
    refreshBtn.TextSize = 10; refreshBtn.BorderSizePixel = 0; refreshBtn.Parent = f
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)
    local statusLbl = Instance.new("TextLabel")
    statusLbl.Size = UDim2.new(0.92, 0, 0, 18); statusLbl.Position = UDim2.new(0.04, 0, 0.09, 0)
    statusLbl.BackgroundTransparency = 1; statusLbl.Text = ""
    statusLbl.TextColor3 = C.badgeText; statusLbl.Font = Enum.Font.GothamMedium
    statusLbl.TextSize = 10; statusLbl.TextXAlignment = Enum.TextXAlignment.Left; statusLbl.Parent = f
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92, 0, 0.78, 0); sb.Position = UDim2.new(0.04, 0, 0.14, 0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0,6)
    local function refresh()
        for _, r in ipairs(pInvRows) do pcall(function() r:Destroy() end) end
        pInvRows = {}
        local items = getPlayerItems(plr)
        if #items == 0 then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, -8, 0, 30); empty.BackgroundTransparency = 1
            empty.Text = "— инвентарь пуст —"
            empty.TextColor3 = C.textDim; empty.Font = Enum.Font.GothamMedium
            empty.TextSize = 11; empty.Parent = sb
            table.insert(pInvRows, empty)
            statusLbl.Text = "Предметов: 0"
        else
            statusLbl.Text = "Предметов: " .. #items
            for _, data in ipairs(items) do
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1, -8, 0, 34)
                b.Text = (data.equipped and "🔫 " or "📦 ") .. data.tool.Name
                b.TextColor3 = data.equipped and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(220, 230, 250)
                b.BackgroundColor3 = data.equipped and Color3.fromRGB(50, 45, 70) or C.row
                b.Font = Enum.Font.GothamBold; b.TextSize = 11
                b.BorderSizePixel = 0; b.TextXAlignment = Enum.TextXAlignment.Left; b.AutoButtonColor = false
                b.Parent = sb
                local pad = Instance.new("UIPadding", b); pad.PaddingLeft = UDim.new(0, 8)
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
                table.insert(pInvRows, b)
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") then h = h + c.Size.Y.Offset + 6 end
        end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    refreshBtn.MouseButton1Click:Connect(refresh)
    refresh()
end

local function openPlayerInvPicker()
    closePlayerInvPicker()
    pInvPicker = Instance.new("ScreenGui")
    pInvPicker.Name = "PlayerPicker"; pInvPicker.ResetOnSpawn = false; pInvPicker.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 320, 0, 480); f.Position = UDim2.new(0.5, -160, 0.5, -240)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = pInvPicker
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 35); t.Text = "🎒 ВЫБЕРИ ИГРОКА"
    t.TextColor3 = Color3.fromRGB(240,240,245); t.BackgroundColor3 = C.topbar
    t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.BorderSizePixel = 0; t.Parent = f
    t.Active = true
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
    local pDrag, pDS, pSP = false, nil, nil
    t.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            pDrag = true; pDS = input.Position; pSP = f.Position
        end
    end)
    t.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then pDrag = false end
    end)
    uis.InputChanged:Connect(function(input)
        if pDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - pDS
            f.Position = UDim2.new(pSP.X.Scale, pSP.X.Offset + d.X, pSP.Y.Scale, pSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 28, 0, 28); xb.Position = UDim2.new(1, -33, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0; xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closePlayerInvPicker)
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(0.92, 0, 0, 32); searchBox.Position = UDim2.new(0.04, 0, 0.09, 0)
    searchBox.PlaceholderText = "🔍 Поиск игрока..."; searchBox.Text = ""
    searchBox.TextColor3 = C.text; searchBox.BackgroundColor3 = C.row
    searchBox.PlaceholderColor3 = C.textDim; searchBox.Font = Enum.Font.GothamMedium
    searchBox.TextSize = 12; searchBox.BorderSizePixel = 0; searchBox.ClearTextOnFocus = false; searchBox.Parent = f
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92, 0, 0.82, 0); sb.Position = UDim2.new(0.04, 0, 0.15, 0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0, 6)
    local rows = {}
    local function refresh(filter)
        filter = (filter or ""):lower()
        for _, r in ipairs(rows) do pcall(function() r:Destroy() end) end
        rows = {}
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and (filter == "" or p.Name:lower():find(filter, 1, true)) then
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1, -8, 0, 44); b.Text = "👤 " .. p.Name
                b.TextColor3 = C.text; b.BackgroundColor3 = C.row
                b.Font = Enum.Font.GothamBold; b.TextSize = 12
                b.BorderSizePixel = 0; b.TextXAlignment = Enum.TextXAlignment.Left; b.AutoButtonColor = false
                b.Parent = sb
                local pad = Instance.new("UIPadding", b); pad.PaddingLeft = UDim.new(0, 10)
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
                b.MouseButton1Click:Connect(function()
                    closePlayerInvPicker()
                    openPlayerInventoryWin(p)
                end)
                table.insert(rows, b)
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do if c:IsA("TextButton") then h = h + c.Size.Y.Offset + 6 end end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    searchBox:GetPropertyChangedSignal("Text"):Connect(function() refresh(searchBox.Text) end)
    refresh("")
end

-- 🔍 СКАНЕР ПЛЕЙСА
local scanWin, scanRows = nil, {}
local scanLastFound = {}
local function closeScanWin()
    if scanWin then scanWin:Destroy(); scanWin = nil end
    scanRows = {}
end
local function scanPlace()
    local found = {}
    local roots = {}
    local reps = game:GetService("ReplicatedStorage")
    local rf = game:GetService("ReplicatedFirst")
    local sg = game:GetService("StarterGui")
    local sp = game:GetService("StarterPack")
    local ss = game:GetService("ServerStorage")
    table.insert(roots, {name = "ReplicatedStorage", obj = reps})
    table.insert(roots, {name = "ReplicatedFirst", obj = rf})
    table.insert(roots, {name = "StarterGui", obj = sg})
    table.insert(roots, {name = "StarterPack", obj = sp})
    table.insert(roots, {name = "Workspace", obj = workspace})
    if ss then table.insert(roots, {name = "ServerStorage", obj = ss}) end
    for _, root in ipairs(roots) do
        local ok, descendants = pcall(function() return root.obj:GetDescendants() end)
        if ok and descendants then
            for _, obj in ipairs(descendants) do
                local cls = obj.ClassName
                if cls == "RemoteEvent" or cls == "RemoteFunction"
                   or cls == "BindableEvent" or cls == "BindableFunction"
                   or cls == "UnreliableRemoteEvent" then
                    table.insert(found, {obj = obj, cls = cls, root = root.name})
                end
            end
        end
    end
    table.sort(found, function(a, b)
        if a.cls == b.cls then return a.obj.Name < b.obj.Name end
        return a.cls < b.cls
    end)
    return found
end

local function openScanWin()
    closeScanWin()
    scanWin = Instance.new("ScreenGui")
    scanWin.Name = "PlaceScanner"; scanWin.ResetOnSpawn = false; scanWin.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 480, 0, 580); f.Position = UDim2.new(0.5, -240, 0.5, -290)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = scanWin
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 35); t.Text = "🔍 СКАНЕР ПЛЕЙСА"
    t.TextColor3 = Color3.fromRGB(240,240,245); t.BackgroundColor3 = C.topbar
    t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.BorderSizePixel = 0; t.Parent = f
    t.Active = true
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
    local sDrag, sDS, sSP = false, nil, nil
    t.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true; sDS = input.Position; sSP = f.Position
        end
    end)
    t.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sDrag = false end
    end)
    uis.InputChanged:Connect(function(input)
        if sDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - sDS
            f.Position = UDim2.new(sSP.X.Scale, sSP.X.Offset + d.X, sSP.Y.Scale, sSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 28, 0, 28); xb.Position = UDim2.new(1, -33, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0; xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closeScanWin)
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(0.92, 0, 0, 18); info.Position = UDim2.new(0.04, 0, 0.065, 0)
    info.BackgroundTransparency = 1
    info.Text = "Вот что тут для тебя нашлось:"; info.TextColor3 = C.badgeText
    info.Font = Enum.Font.GothamMedium; info.TextSize = 11
    info.TextXAlignment = Enum.TextXAlignment.Left; info.Parent = f
    local counters = Instance.new("TextLabel")
    counters.Size = UDim2.new(0.92, 0, 0, 16); counters.Position = UDim2.new(0.04, 0, 0.10, 0)
    counters.BackgroundTransparency = 1; counters.Text = ""
    counters.TextColor3 = C.text; counters.Font = Enum.Font.GothamBold
    counters.TextSize = 11; counters.TextXAlignment = Enum.TextXAlignment.Left; counters.Parent = f
    local rescan = Instance.new("TextButton")
    rescan.Size = UDim2.new(0, 130, 0, 26); rescan.Position = UDim2.new(1, -276, 0.062, 0)
    rescan.Text = "🔄 Пересканировать"; rescan.TextColor3 = C.text
    rescan.BackgroundColor3 = C.accentDk; rescan.Font = Enum.Font.GothamBold
    rescan.TextSize = 10; rescan.BorderSizePixel = 0; rescan.ZIndex = 5; rescan.Parent = f
    Instance.new("UICorner", rescan).CornerRadius = UDim.new(0, 4)
    local copyAll = Instance.new("TextButton")
    copyAll.Size = UDim2.new(0, 140, 0, 26); copyAll.Position = UDim2.new(1, -142, 0.062, 0)
    copyAll.Text = "📋 Скопировать все пути"; copyAll.TextColor3 = C.text
    copyAll.BackgroundColor3 = Color3.fromRGB(90, 70, 160); copyAll.Font = Enum.Font.GothamBold
    copyAll.TextSize = 10; copyAll.BorderSizePixel = 0; copyAll.ZIndex = 5; copyAll.Parent = f
    Instance.new("UICorner", copyAll).CornerRadius = UDim.new(0, 4)
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92, 0, 0.83, 0); sb.Position = UDim2.new(0.04, 0, 0.14, 0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0, 4)
    local function clearRows()
        for _, r in ipairs(scanRows) do pcall(function() r:Destroy() end) end
        scanRows = {}
    end
    local function doScan()
        clearRows()
        local found = scanPlace()
        scanLastFound = found
        local byClass = {}
        for _, it in ipairs(found) do
            byClass[it.cls] = (byClass[it.cls] or 0) + 1
        end
        local summary = {}
        for cls, cnt in pairs(byClass) do table.insert(summary, cls .. ": " .. cnt) end
        table.sort(summary)
        counters.Text = "Найдено: " .. #found .. ( #summary > 0 and ("  (" .. table.concat(summary, ", ") .. ")") or "" )
        if #found == 0 then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, -8, 0, 30); empty.BackgroundTransparency = 1
            empty.Text = "— ничего не найдено —"
            empty.TextColor3 = C.textDim; empty.Font = Enum.Font.GothamMedium
            empty.TextSize = 11; empty.Parent = sb
            table.insert(scanRows, empty)
        else
            local lastClass = nil
            for _, it in ipairs(found) do
                if it.cls ~= lastClass then
                    lastClass = it.cls
                    local hdr = Instance.new("TextLabel")
                    hdr.Size = UDim2.new(1, -8, 0, 22); hdr.BackgroundTransparency = 1
                    hdr.Text = "▶ " .. it.cls
                    hdr.TextColor3 = C.accent; hdr.Font = Enum.Font.GothamBold
                    hdr.TextSize = 11; hdr.TextXAlignment = Enum.TextXAlignment.Left; hdr.Parent = sb
                    table.insert(scanRows, hdr)
                end
                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, -8, 0, 40); row.BackgroundColor3 = C.row
                row.BorderSizePixel = 0; row.Parent = sb
                Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)
                local nameL = Instance.new("TextLabel")
                nameL.Size = UDim2.new(1, -80, 0, 18); nameL.Position = UDim2.new(0, 8, 0, 3)
                nameL.BackgroundTransparency = 1
                nameL.Text = "📡 " .. it.obj.Name
                nameL.TextColor3 = Color3.fromRGB(240, 240, 245)
                nameL.Font = Enum.Font.GothamBold; nameL.TextSize = 11
                nameL.TextXAlignment = Enum.TextXAlignment.Left; nameL.Parent = row
                local fullPath = it.root .. "." .. it.obj:GetFullName():gsub("^" .. it.root .. "%.", "")
                local pathL = Instance.new("TextLabel")
                pathL.Size = UDim2.new(1, -80, 0, 14); pathL.Position = UDim2.new(0, 8, 0, 21)
                pathL.BackgroundTransparency = 1
                pathL.Text = "📁 " .. fullPath .. "   [" .. it.root .. "]"
                pathL.TextColor3 = C.textDim; pathL.Font = Enum.Font.GothamMedium
                pathL.TextSize = 10; pathL.TextXAlignment = Enum.TextXAlignment.Left; pathL.Parent = row
                local copyBtn = Instance.new("TextButton")
                copyBtn.Size = UDim2.new(0, 64, 0, 24); copyBtn.Position = UDim2.new(1, -70, 0.5, -12)
                copyBtn.Text = "📋 Путь"; copyBtn.TextColor3 = C.text
                copyBtn.BackgroundColor3 = C.accentDk; copyBtn.Font = Enum.Font.GothamBold
                copyBtn.TextSize = 10; copyBtn.BorderSizePixel = 0; copyBtn.Parent = row
                Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 4)
                copyBtn.MouseButton1Click:Connect(function()
                    if setclipboard then
                        pcall(function() setclipboard(it.obj:GetFullName()) end)
                        local n = showNotif("📋 Скопировано: " .. it.obj:GetFullName(), Color3.fromRGB(100,255,100))
                        game:GetService("Debris"):AddItem(n, 2)
                    else
                        local n = showNotif("📋 Путь: " .. it.obj:GetFullName(), Color3.fromRGB(150,200,255))
                        game:GetService("Debris"):AddItem(n, 3)
                    end
                end)
                table.insert(scanRows, row)
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") or c:IsA("Frame") then h = h + c.Size.Y.Offset + 4 end
        end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    copyAll.MouseButton1Click:Connect(function()
        if #scanLastFound == 0 then
            local n = showNotif("❌ Нечего копировать", Color3.fromRGB(255,100,100))
            game:GetService("Debris"):AddItem(n, 2); return
        end
        local lines = {"===== СКАНЕР ПЛЕЙСА =====", "Всего найдено: " .. #scanLastFound, "========================="}
        local lastCls = nil
        for _, it in ipairs(scanLastFound) do
            if it.cls ~= lastCls then
                lastCls = it.cls
                table.insert(lines, ""); table.insert(lines, "--- " .. it.cls .. " ---")
            end
            local fullPath = it.root .. "." .. it.obj:GetFullName():gsub("^" .. it.root .. "%.", "")
            table.insert(lines, fullPath .. "  [" .. it.root .. "]")
        end
        local text = table.concat(lines, "\n")
        if setclipboard then
            local ok = pcall(function() setclipboard(text) end)
            local n = showNotif(ok and ("✅ Скопировано " .. #scanLastFound .. " путей") or "❌ Не скопировалось", ok and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,100,100))
            game:GetService("Debris"):AddItem(n, 3)
        else
            print(text)
            local n = showNotif("⚠ setclipboard нет — вывод в F9 (" .. #scanLastFound .. ")", Color3.fromRGB(255,200,80))
            game:GetService("Debris"):AddItem(n, 5)
        end
    end)
    rescan.MouseButton1Click:Connect(doScan)
    doScan()
end

makeToggle(armyPage, "🎒 Инвентарь игрока", true, function(on)
    if on then openPlayerInvPicker() else closePlayerInvPicker(); closePlayerInvWin() end
end)

makeButton(armyPage, "🔍 Сканер плейса (что тут есть)", Color3.fromRGB(60, 90, 130), openScanWin)

-- ═══════════════════════════════════════════════════════════
-- 📍 ВКЛАДКА ТЕЛЕПОРТЫ
-- ═══════════════════════════════════════════════════════════

local function teleportTo(x, y, z, label)
    local hrp = getHRP()
    if not hrp then
        local n = showNotif("❌ Нет персонажа (возможно мёртв)", Color3.fromRGB(255,100,100))
        game:GetService("Debris"):AddItem(n, 3)
        return
    end
    hrp.CFrame = CFrame.new(Vector3.new(x, y, z))
    local n = showNotif("📍 ТП: " .. (label or "точка"), Color3.fromRGB(100,255,100))
    game:GetService("Debris"):AddItem(n, 3)
end

makeSectionLabel(tpPage, "🏛 ГОС. СТРУКТУРЫ")
makeButton(tpPage, "🪖 Армия", Color3.fromRGB(70, 100, 60), function()
    teleportTo(256.9, 4.2, 83.3, "Армия")
end)
makeButton(tpPage, "👮 МВД", Color3.fromRGB(60, 80, 130), function()
    teleportTo(1861.1, 5.0, -61.0, "МВД")
end)
makeButton(tpPage, "🕵️ ФСБ", Color3.fromRGB(90, 60, 60), function()
    teleportTo(2201.7, 1.0, -601.0, "ФСБ")
end)
makeButton(tpPage, "🏢 КБ", Color3.fromRGB(70, 70, 90), function()
    teleportTo(805.1, 5.0, -902.6, "КБ")
end)
makeButton(tpPage, "⚖️ Прокуратура", Color3.fromRGB(80, 90, 120), function()
    teleportTo(2585.4, 1.1, -1025.0, "Прокуратура")
end)

makeSectionLabel(tpPage, "🛒 ТОРГОВЦЫ")
makeButton(tpPage, "🔫 Торговец оружием", Color3.fromRGB(110, 80, 40), function()
    teleportTo(840.5, 41.0, -118.7, "Торговец оружие")
end)

makeSectionLabel(tpPage, "⚔️ НЕЛЕГАЛЬНЫЕ")
makeButton(tpPage, "🎯 Наём", Color3.fromRGB(130, 60, 60), function()
    teleportTo(1543.9, 3.0, 770.3, "Наём")
end)
makeButton(tpPage, "💼 Брокеры", Color3.fromRGB(100, 70, 130), function()
    teleportTo(1661.7, 25.0, -1937.1, "Брокеры")
end)

makeSectionLabel(tpPage, "🌪️ ИВЕНТЫ")
makeButton(tpPage, "🌪️ ШТОРМ", Color3.fromRGB(70, 90, 120), function()
    teleportTo(441.3, 9.0, 997.0, "Шторм")
end)

-- 👁️ СПЕКТАТОР
local specGui, specRows, specSelected = nil, {}, nil
local specOriginalSubject, specOriginalType = nil, nil
local refreshFaction
local function restoreMovement()
    local h = getHum()
    if h then
        pcall(function()
            h.WalkSpeed = 16; h.JumpPower = 50; h.UseJumpPower = true; h.PlatformStand = false
        end)
    end
end
local function stopSpectate()
    if specOriginalSubject then
        pcall(function() camera.CameraSubject = specOriginalSubject end)
    elseif player.Character then
        local h = player.Character:FindFirstChildOfClass("Humanoid")
        if h then camera.CameraSubject = h end
    end
    if specOriginalType then pcall(function() camera.CameraType = specOriginalType end) end
    restoreMovement(); task.delay(0.1, restoreMovement); task.delay(0.3, restoreMovement)
    specSelected = nil
end
local function startSpectate(plr)
    if not plr or not plr.Character then return end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if not specOriginalSubject then
        specOriginalSubject = camera.CameraSubject
        specOriginalType = camera.CameraType
    end
    local myHum = getHum()
    if myHum then myHum.WalkSpeed = 0; myHum.JumpPower = 0 end
    camera.CameraSubject = hum
    camera.CameraType = Enum.CameraType.Custom
    specSelected = plr
end
local function closeSpecWindow()
    stopSpectate()
    specOriginalSubject = nil; specOriginalType = nil
    if specGui then specGui:Destroy(); specGui = nil end
    specRows = {}
end
local function openSpecWindow()
    closeSpecWindow()
    specGui = Instance.new("ScreenGui")
    specGui.Name = "SpectateMenu"; specGui.ResetOnSpawn = false; specGui.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 320, 0, 640); f.Position = UDim2.new(0.5, -160, 0.5, -320)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = specGui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35); title.Text = "👁️ СПЕКТАТОР"
    title.TextColor3 = Color3.fromRGB(240,240,245); title.BackgroundColor3 = C.topbar
    title.Font = Enum.Font.GothamBold; title.TextSize = 13
    title.BorderSizePixel = 0; title.Parent = f; title.Active = true
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)
    local specDrag, specDS, specSP = false, nil, nil
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            specDrag = true; specDS = input.Position; specSP = f.Position
        end
    end)
    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then specDrag = false end
    end)
    uis.InputChanged:Connect(function(input)
        if specDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - specDS
            f.Position = UDim2.new(specSP.X.Scale, specSP.X.Offset + d.X, specSP.Y.Scale, specSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0, 28, 0, 28); xb.Position = UDim2.new(1, -33, 0, 3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0
    xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0, 5)
    xb.MouseButton1Click:Connect(closeSpecWindow)
    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(0.92, 0, 0, 18); hint.Position = UDim2.new(0.04, 0, 0.06, 0)
    hint.BackgroundTransparency = 1
    hint.Text = "Клик по игроку = смотреть"
    hint.TextColor3 = C.badgeText; hint.Font = Enum.Font.GothamMedium
    hint.TextSize = 10; hint.TextXAlignment = Enum.TextXAlignment.Left; hint.Parent = f
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(0.92, 0, 0, 30); searchBox.Position = UDim2.new(0.04, 0, 0.10, 0)
    searchBox.PlaceholderText = "Поиск игрока..."
    searchBox.Text = ""; searchBox.TextColor3 = C.text
    searchBox.BackgroundColor3 = C.row; searchBox.PlaceholderColor3 = C.textDim
    searchBox.Font = Enum.Font.GothamMedium; searchBox.TextSize = 12
    searchBox.BorderSizePixel = 0; searchBox.ClearTextOnFocus = false; searchBox.Parent = f
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)
    local meBtn = Instance.new("TextButton")
    meBtn.Size = UDim2.new(0.92, 0, 0, 30); meBtn.Position = UDim2.new(0.04, 0, 0.155, 0)
    meBtn.Text = "🔄 ВЕРНУТЬСЯ К СЕБЕ"; meBtn.TextColor3 = C.text
    meBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 100)
    meBtn.Font = Enum.Font.GothamBold; meBtn.TextSize = 11
    meBtn.BorderSizePixel = 0; meBtn.Parent = f
    Instance.new("UICorner", meBtn).CornerRadius = UDim.new(0, 5)
    local watchingLbl = Instance.new("TextLabel")
    watchingLbl.Size = UDim2.new(0.92, 0, 0, 18); watchingLbl.Position = UDim2.new(0.04, 0, 0.21, 0)
    watchingLbl.BackgroundTransparency = 1
    watchingLbl.Text = "Смотрю за: —"
    watchingLbl.TextColor3 = Color3.fromRGB(180, 180, 200)
    watchingLbl.Font = Enum.Font.GothamBold
    watchingLbl.TextSize = 11
    watchingLbl.TextXAlignment = Enum.TextXAlignment.Left; watchingLbl.Parent = f
    meBtn.MouseButton1Click:Connect(function()
        stopSpectate()
        watchingLbl.Text = "Смотрю за: —"
        watchingLbl.TextColor3 = Color3.fromRGB(100, 255, 100)
        for _, r in ipairs(specRows) do
            if r.Parent then
                r.BackgroundColor3 = C.row
                local sub = r:FindFirstChild("__sub")
                if sub then
                    local pName = r:GetAttribute("plrName")
                    local p = pName and game.Players:FindFirstChild(pName)
                    sub.Text = (p and p.Character and "🟢 В игре" or "🔴 Мёртв")
                end
            end
        end
    end)
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92, 0, 0, 240); sb.Position = UDim2.new(0.04, 0, 0.25, 0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0, 6)
    local function refreshList(filter)
        filter = (filter or ""):lower()
        for _, r in ipairs(specRows) do pcall(function() r:Destroy() end) end
        specRows = {}
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and (filter == "" or p.Name:lower():find(filter, 1, true)) then
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1, -8, 0, 40); b.Text = ""
                b.BackgroundColor3 = specSelected == p and Color3.fromRGB(45, 35, 70) or C.row
                b.BorderSizePixel = 0; b.AutoButtonColor = false; b.Parent = sb
                b:SetAttribute("plrName", p.Name)
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
                local nl = Instance.new("TextLabel")
                nl.Size = UDim2.new(1, -10, 0, 18); nl.Position = UDim2.new(0, 8, 0, 3)
                nl.Text = "👤 " .. p.Name
                nl.TextColor3 = Color3.fromRGB(240, 240, 245)
                nl.BackgroundTransparency = 1
                nl.Font = Enum.Font.GothamBold; nl.TextSize = 12
                nl.TextXAlignment = Enum.TextXAlignment.Left; nl.Parent = b
                local sl = Instance.new("TextLabel")
                sl.Name = "__sub"
                sl.Size = UDim2.new(1, -10, 0, 14); sl.Position = UDim2.new(0, 8, 0, 21)
                sl.Text = (p.Character and "🟢 В игре" or "🔴 Мёртв") .. (specSelected == p and "  👁️ СМОТРИМ" or "")
                sl.TextColor3 = specSelected == p and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(150, 200, 150)
                sl.BackgroundTransparency = 1
                sl.Font = Enum.Font.GothamSemibold; sl.TextSize = 10
                sl.TextXAlignment = Enum.TextXAlignment.Left; sl.Parent = b
                b.MouseButton1Click:Connect(function()
                    startSpectate(p)
                    watchingLbl.Text = "Смотрю за: " .. p.Name
                    watchingLbl.TextColor3 = Color3.fromRGB(100, 255, 100)
                    refreshList(searchBox.Text)
                    if refreshFaction then refreshFaction() end
                end)
                table.insert(specRows, b)
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do if c:IsA("TextButton") then h = h + c.Size.Y.Offset + 6 end end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    local facHeader = Instance.new("Frame")
    facHeader.Size = UDim2.new(0.92, 0, 0, 22); facHeader.Position = UDim2.new(0.04, 0, 0.65, 0)
    facHeader.BackgroundTransparency = 1; facHeader.Parent = f
    local facLbl = Instance.new("TextLabel")
    facLbl.Size = UDim2.new(1, 0, 1, 0); facLbl.BackgroundTransparency = 1
    facLbl.Text = "🛡️ МОЯ ФРАКЦИЯ: —"
    facLbl.TextColor3 = C.badgeText; facLbl.Font = Enum.Font.GothamBold
    facLbl.TextSize = 11; facLbl.TextXAlignment = Enum.TextXAlignment.Left; facLbl.Parent = facHeader
    local fb = Instance.new("ScrollingFrame")
    fb.Size = UDim2.new(0.92, 0, 0, 150); fb.Position = UDim2.new(0.04, 0, 0.70, 0)
    fb.BackgroundTransparency = 1; fb.CanvasSize = UDim2.new(0,0,0,0)
    fb.ScrollBarThickness = 6; fb.ScrollBarImageColor3 = C.accent; fb.Parent = f
    Instance.new("UIListLayout", fb).Padding = UDim.new(0, 4)
    local facRows = {}
    refreshFaction = function()
        for _, r in ipairs(facRows) do pcall(function() r:Destroy() end) end
        facRows = {}
        local myTeam = player.Team
        if myTeam then
            facLbl.Text = "🛡️ МОЯ ФРАКЦИЯ: " .. myTeam.Name
            facLbl.TextColor3 = (myTeam.TeamColor and myTeam.TeamColor.Color) or C.badgeText
        else
            facLbl.Text = "🛡️ МОЯ ФРАКЦИЯ: — (без фракции)"
            facLbl.TextColor3 = C.badgeText
        end
        if not myTeam then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, -8, 0, 28); empty.BackgroundTransparency = 1
            empty.Text = "— вы без фракции —"
            empty.TextColor3 = C.textDim; empty.Font = Enum.Font.GothamMedium
            empty.TextSize = 11; empty.Parent = fb
            table.insert(facRows, empty)
        else
            local members = {}
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= player and p.Team == myTeam then table.insert(members, p) end
            end
            if #members == 0 then
                local empty = Instance.new("TextLabel")
                empty.Size = UDim2.new(1, -8, 0, 28); empty.BackgroundTransparency = 1
                empty.Text = "— в вашей фракции больше никого —"
                empty.TextColor3 = C.textDim; empty.Font = Enum.Font.GothamMedium
                empty.TextSize = 11; empty.Parent = fb
                table.insert(facRows, empty)
            else
                for _, p in ipairs(members) do
                    local b = Instance.new("TextButton")
                    b.Size = UDim2.new(1, -8, 0, 28); b.Text = ""
                    b.BackgroundColor3 = specSelected == p and Color3.fromRGB(45, 35, 70) or C.row
                    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.Parent = fb
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
                    local nm = Instance.new("TextLabel")
                    nm.Size = UDim2.new(1, -8, 1, 0); nm.Position = UDim2.new(0, 8, 0, 0)
                    nm.BackgroundTransparency = 1
                    nm.Text = (p.Character and "🟢 " or "🔴 ") .. p.Name .. (specSelected == p and "  👁️ СМОТРИМ" or "")
                    nm.TextColor3 = specSelected == p and Color3.fromRGB(150, 100, 255)
                        or (p.Character and Color3.fromRGB(240, 240, 245) or Color3.fromRGB(150, 150, 160))
                    nm.Font = Enum.Font.GothamSemibold; nm.TextSize = 11
                    nm.TextXAlignment = Enum.TextXAlignment.Left; nm.Parent = b
                    b.MouseButton1Click:Connect(function()
                        if not p.Character then
                            watchingLbl.Text = "Смотрю за: — (" .. p.Name .. " недоступен)"
                            watchingLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
                            return
                        end
                        startSpectate(p)
                        watchingLbl.Text = "Смотрю за: " .. p.Name
                        watchingLbl.TextColor3 = Color3.fromRGB(100, 255, 100)
                        refreshList(searchBox.Text)
                        refreshFaction()
                    end)
                    table.insert(facRows, b)
                end
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(fb:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") then h = h + c.Size.Y.Offset + 4 end
        end
        fb.CanvasSize = UDim2.new(0,0,0,h+10)
    end
    local searchDebounce = nil
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        if searchDebounce then task.cancel(searchDebounce) end
        searchDebounce = task.delay(0.15, function() refreshList(searchBox.Text) end)
    end)
    refreshList(""); refreshFaction()
    task.spawn(function() while specGui do refreshFaction(); task.wait(2) end end)
    task.spawn(function()
        while specGui do
            if specSelected then
                local c = specSelected.Character
                local hum = c and c:FindFirstChildOfClass("Humanoid")
                if not c or not hum or hum.Health <= 0 then
                    stopSpectate()
                    watchingLbl.Text = "Смотрю за: — (цель пропала)"
                    watchingLbl.TextColor3 = Color3.fromRGB(255, 100, 100)
                    refreshFaction()
                else
                    if camera.CameraSubject ~= hum then camera.CameraSubject = hum end
                end
            end
            task.wait(0.5)
        end
    end)
end
makeToggle(armyPage, "👁️ Спектатор", false, function(on) if on then openSpecWindow() else closeSpecWindow() end end)

-- TP ОКНО
local tpGui, tpRows = nil, {}
local function closeTP()
    if tpGui then tpGui:Destroy(); tpGui = nil end
    tpRows = {}
end
local function tpTo(plr)
    if not plr or not plr.Character then return end
    local t = plr.Character:FindFirstChild("HumanoidRootPart"); local my = getHRP()
    if t and my then my.CFrame = t.CFrame + Vector3.new(0,3,0) end
end
local function openTP()
    closeTP()
    tpGui = Instance.new("ScreenGui")
    tpGui.Name = "TPMenu"; tpGui.ResetOnSpawn = false; tpGui.Parent = gui.Parent
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,320,0,480); f.Position = UDim2.new(0.5,-160,0.5,-240)
    f.BackgroundColor3 = C.bg; f.BorderSizePixel = 0; f.Active = true; f.Parent = tpGui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,8)
    local s = Instance.new("UIStroke", f); s.Color = C.accentDk; s.Thickness = 1
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,0,0,35); t.Text = "ТЕЛЕПОРТ К ИГРОКУ"
    t.TextColor3 = Color3.fromRGB(240,240,245); t.BackgroundColor3 = C.topbar
    t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.BorderSizePixel = 0; t.Parent = f
    t.Active = true
    Instance.new("UICorner", t).CornerRadius = UDim.new(0,8)
    local tpDrag, tpDS, tpSP = false, nil, nil
    t.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tpDrag = true; tpDS = input.Position; tpSP = f.Position
        end
    end)
    t.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then tpDrag = false end
    end)
    uis.InputChanged:Connect(function(input)
        if tpDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - tpDS
            f.Position = UDim2.new(tpSP.X.Scale, tpSP.X.Offset + d.X, tpSP.Y.Scale, tpSP.Y.Offset + d.Y)
        end
    end)
    local xb = Instance.new("TextButton")
    xb.Size = UDim2.new(0,28,0,28); xb.Position = UDim2.new(1,-33,0,3)
    xb.Text = "✕"; xb.TextColor3 = C.textDim; xb.BackgroundColor3 = C.red
    xb.Font = Enum.Font.GothamBold; xb.TextSize = 14; xb.BorderSizePixel = 0; xb.ZIndex = 10; xb.Parent = f
    Instance.new("UICorner", xb).CornerRadius = UDim.new(0,5)
    xb.MouseButton1Click:Connect(closeTP)
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(0.92,0,0,32); searchBox.Position = UDim2.new(0.04,0,0.09,0)
    searchBox.PlaceholderText = "🔍 Поиск игрока..."; searchBox.Text = ""
    searchBox.TextColor3 = C.text; searchBox.BackgroundColor3 = C.row
    searchBox.PlaceholderColor3 = C.textDim; searchBox.Font = Enum.Font.GothamMedium
    searchBox.TextSize = 12; searchBox.BorderSizePixel = 0; searchBox.ClearTextOnFocus = false; searchBox.Parent = f
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,6)
    local sb = Instance.new("ScrollingFrame")
    sb.Size = UDim2.new(0.92,0,0.78,0); sb.Position = UDim2.new(0.04,0,0.19,0)
    sb.BackgroundTransparency = 1; sb.CanvasSize = UDim2.new(0,0,0,0)
    sb.ScrollBarThickness = 6; sb.ScrollBarImageColor3 = C.accent; sb.Parent = f
    Instance.new("UIListLayout", sb).Padding = UDim.new(0,6)
    tpRows = {}
    local function refresh(filter)
        filter = (filter or ""):lower()
        for _, r in ipairs(tpRows) do pcall(function() r.btn:Destroy() end) end
        tpRows = {}
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and (filter == "" or p.Name:lower():find(filter,1,true)) then
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1,-8,0,44); b.Text = "👤 " .. p.Name
                b.TextColor3 = C.text; b.BackgroundColor3 = C.row
                b.Font = Enum.Font.GothamBold; b.TextSize = 12
                b.BorderSizePixel = 0; b.TextXAlignment = Enum.TextXAlignment.Left; b.AutoButtonColor = false
                b.Parent = sb
                local pad = Instance.new("UIPadding", b); pad.PaddingLeft = UDim.new(0, 10)
                Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
                b.MouseButton1Click:Connect(function() tpTo(p); closeTP() end)
                table.insert(tpRows, {btn=b, plr=p})
            end
        end
        task.wait(0.05)
        local h = 0
        for _, c in ipairs(sb:GetChildren()) do if c:IsA("TextButton") then h = h + c.Size.Y.Offset + 6 end end
        sb.CanvasSize = UDim2.new(0,0,0,h+20)
    end
    searchBox:GetPropertyChangedSignal("Text"):Connect(function() refresh(searchBox.Text) end)
    refresh("")
end
makeToggle(armyPage, "Телепорт к игроку", false, function(on) if on then openTP() else closeTP() end end)

-- ═══ SETTINGS ═══
local function makeSettingRow(text)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,-12,0,42); row.BackgroundColor3 = C.row
    row.BorderSizePixel = 0; row.Parent = settingsPage
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55,0,1,0); label.Position = UDim2.new(0,26,0,0)
    label.Text = text; label.TextColor3 = C.text; label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium; label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = row
    return row
end

makeSectionLabel(settingsPage, "🎨 ЦВЕТ АКЦЕНТА")
local colorsRow = Instance.new("Frame")
colorsRow.Size = UDim2.new(1,-12,0,46); colorsRow.BackgroundColor3 = C.row
colorsRow.BorderSizePixel = 0; colorsRow.Parent = settingsPage
Instance.new("UICorner", colorsRow).CornerRadius = UDim.new(0,6)
local presets = {
    Color3.fromRGB(130,70,220), Color3.fromRGB(60,120,220), Color3.fromRGB(60,180,100),
    Color3.fromRGB(200,50,60), Color3.fromRGB(230,140,40), Color3.fromRGB(220,80,180),
}
local function applyAccent(newColor)
    C.accent = newColor
    C.accentDk = Color3.new(newColor.R*0.65, newColor.G*0.65, newColor.B*0.65)
    mStroke.Color = C.accentDk
    for _, p in ipairs({armyPage, tpPage, aimbotPage, settingsPage}) do
        p.ScrollBarImageColor3 = C.accent
    end
    if tabArmy.BackgroundColor3 ~= C.sidebar then tabArmy.BackgroundColor3 = C.accentDk end
    if tabTP.BackgroundColor3 ~= C.sidebar then tabTP.BackgroundColor3 = C.accentDk end
    if tabAimbot.BackgroundColor3 ~= C.sidebar then tabAimbot.BackgroundColor3 = C.accentDk end
    if tabSettings.BackgroundColor3 ~= C.sidebar then tabSettings.BackgroundColor3 = C.accentDk end
    for _, td in ipairs(togglesData) do
        if td.api.get() and td.tBg and td.dot then
            td.tBg.BackgroundColor3 = C.accent; td.dot.BackgroundColor3 = C.accent
        end
    end
end
for i, col in ipairs(presets) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0,30,0,30); cBtn.Position = UDim2.new(0, 8+(i-1)*36, 0.5, -15)
    cBtn.Text = ""; cBtn.BackgroundColor3 = col; cBtn.BorderSizePixel = 0; cBtn.Parent = colorsRow
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(1,0)
    local stroke = Instance.new("UIStroke", cBtn)
    stroke.Color = Color3.fromRGB(60,60,70); stroke.Thickness = 1
    cBtn.MouseButton1Click:Connect(function() applyAccent(col) end)
end

makeSectionLabel(settingsPage, "📐 РАЗМЕР ОКНА")
local sizeRow = makeSettingRow("Ширина / Высота")
local wBox = Instance.new("TextBox")
wBox.Size = UDim2.new(0,46,0,26); wBox.Position = UDim2.new(1,-170,0.5,-13)
wBox.Text = "540"; wBox.TextColor3 = C.text; wBox.BackgroundColor3 = C.badge
wBox.Font = Enum.Font.GothamSemibold; wBox.TextSize = 12; wBox.BorderSizePixel = 0
wBox.ClearTextOnFocus = false; wBox.Parent = sizeRow
Instance.new("UICorner", wBox).CornerRadius = UDim.new(0,4)
local hBox = Instance.new("TextBox")
hBox.Size = UDim2.new(0,46,0,26); hBox.Position = UDim2.new(1,-118,0.5,-13)
hBox.Text = "460"; hBox.TextColor3 = C.text; hBox.BackgroundColor3 = C.badge
hBox.Font = Enum.Font.GothamSemibold; hBox.TextSize = 12; hBox.BorderSizePixel = 0
hBox.ClearTextOnFocus = false; hBox.Parent = sizeRow
Instance.new("UICorner", hBox).CornerRadius = UDim.new(0,4)
local applySizeBtn = Instance.new("TextButton")
applySizeBtn.Size = UDim2.new(0,60,0,26); applySizeBtn.Position = UDim2.new(1,-66,0.5,-13)
applySizeBtn.Text = "OK"; applySizeBtn.TextColor3 = C.text
applySizeBtn.BackgroundColor3 = C.accentDk; applySizeBtn.Font = Enum.Font.GothamBold
applySizeBtn.TextSize = 12; applySizeBtn.BorderSizePixel = 0; applySizeBtn.Parent = sizeRow
Instance.new("UICorner", applySizeBtn).CornerRadius = UDim.new(0,4)
applySizeBtn.MouseButton1Click:Connect(function()
    local w = tonumber(wBox.Text); local h = tonumber(hBox.Text)
    if w and h then
        w = math.clamp(math.floor(w), 300, 900); h = math.clamp(math.floor(h), 200, 700)
        main.Size = UDim2.new(0, w, 0, h)
        wBox.Text = tostring(w); hBox.Text = tostring(h)
    end
end)

makeSectionLabel(settingsPage, "⌨️ КНОПКА ОТКРЫТИЯ МЕНЮ")
local keyRow = makeSettingRow("Текущая клавиша")
local keyShow = Instance.new("TextLabel")
keyShow.Size = UDim2.new(0,80,0,26); keyShow.Position = UDim2.new(1,-168,0.5,-13)
keyShow.Text = "RightShift"; keyShow.TextColor3 = C.badgeText
keyShow.BackgroundColor3 = C.badge; keyShow.Font = Enum.Font.GothamBold
keyShow.TextSize = 11; keyShow.BorderSizePixel = 0; keyShow.Parent = keyRow
Instance.new("UICorner", keyShow).CornerRadius = UDim.new(0,4)
local assignKeyBtn = Instance.new("TextButton")
assignKeyBtn.Size = UDim2.new(0,90,0,26); assignKeyBtn.Position = UDim2.new(1,-80,0.5,-13)
assignKeyBtn.Text = "Назначить"; assignKeyBtn.TextColor3 = C.text
assignKeyBtn.BackgroundColor3 = C.accentDk; assignKeyBtn.Font = Enum.Font.GothamBold
assignKeyBtn.TextSize = 11; assignKeyBtn.BorderSizePixel = 0; assignKeyBtn.Parent = keyRow
Instance.new("UICorner", assignKeyBtn).CornerRadius = UDim.new(0,4)
local toggleKey = Enum.KeyCode.RightShift
local waitingForKey = false
assignKeyBtn.MouseButton1Click:Connect(function()
    waitingForKey = true
    assignKeyBtn.Text = "Жми клавишу..."
    assignKeyBtn.BackgroundColor3 = C.green
end)
uis.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if waitingForKey and input.KeyCode ~= Enum.KeyCode.Unknown then
        toggleKey = input.KeyCode
        waitingForKey = false
        assignKeyBtn.Text = "Назначить"
        assignKeyBtn.BackgroundColor3 = C.accentDk
        keyShow.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.","")
        return
    end
    if uis:GetFocusedTextBox() then return end
    if input.KeyCode == toggleKey then main.Visible = not main.Visible end
end)

task.spawn(function()
    task.wait(0.1)
    for _, page in ipairs({armyPage, tpPage, aimbotPage, settingsPage}) do
        local h = 0
        for _, c in ipairs(page:GetChildren()) do
            if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("TextButton") then h = h + c.Size.Y.Offset + 6 end
        end
        page.CanvasSize = UDim2.new(0,0,0,h+20)
    end
end)

local minimized = false
local origSize = main.Size
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        origSize = main.Size
        sidebar.Visible = false; content.Visible = false
        main.Size = UDim2.new(0,540,0,40)
    else
        sidebar.Visible = true; content.Visible = true
        main.Size = origSize
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    stopESP(); stopAimbot(); stopFly(); stopGhost(); stopNC(); stopVeh()
    stopTpClick()
    closeTP(); closeMyBagWindow(); closeSpecWindow()
    closePlayerInvPicker(); closePlayerInvWin(); closeScanWin()
    closeCoordsWin()
    setSpeed(defaultSpeed)
    jumpOn = false
    gui:Destroy()
end)

print("✅ Eclipse Menu + Ghost + Точный Aimbot + Шторм загружен.")
print("⌨️ RightShift — открыть/закрыть меню.")
