-- ECLIPSE MENU — ПОЛНЫЙ КОД
local player=game.Players.LocalPlayer
local camera=workspace.CurrentCamera
local runService=game:GetService("RunService")
local uis=game:GetService("UserInputService")
local lighting=game:GetService("Lighting")
local toggleKey=Enum.KeyCode.F4
local waitingForMenuKey=false
local setMenuKeyDisplay=nil
local ghostOn=false
local specSelected=nil
local stopSpectate=nil
local C={bg=Color3.fromRGB(15,15,22),topbar=Color3.fromRGB(20,20,30),sidebar=Color3.fromRGB(18,18,26),row=Color3.fromRGB(22,22,32),accent=Color3.fromRGB(130,70,220),accentDk=Color3.fromRGB(90,40,160),text=Color3.fromRGB(220,220,230),textDim=Color3.fromRGB(140,140,160),badge=Color3.fromRGB(35,30,50),badgeText=Color3.fromRGB(150,130,180),toggleOff=Color3.fromRGB(50,50,65),knob=Color3.fromRGB(230,230,240),red=Color3.fromRGB(180,40,40),green=Color3.fromRGB(80,130,80)}
local gui=Instance.new("ScreenGui")
gui.Name="EclipseMenu";gui.ResetOnSpawn=false;gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=player:WaitForChild("PlayerGui")
local main=Instance.new("Frame")
main.Size=UDim2.new(0,540,0,460);main.Position=UDim2.new(0.5,-270,0.5,-230)
main.BackgroundColor3=C.bg;main.BorderSizePixel=0;main.Active=true;main.Parent=gui
Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
local mStroke=Instance.new("UIStroke",main);mStroke.Color=C.accentDk;mStroke.Thickness=1;mStroke.Transparency=0.4
local topbar=Instance.new("Frame")
topbar.Size=UDim2.new(1,0,0,40);topbar.BackgroundColor3=C.topbar;topbar.BorderSizePixel=0
topbar.Parent=main;topbar.Active=true
Instance.new("UICorner",topbar).CornerRadius=UDim.new(0,8)
local titleLbl=Instance.new("TextLabel")
titleLbl.Size=UDim2.new(0,200,1,0);titleLbl.Position=UDim2.new(0,18,0,0)
titleLbl.Text="ECLIPSE";titleLbl.TextColor3=Color3.fromRGB(240,240,245)
titleLbl.BackgroundTransparency=1;titleLbl.Font=Enum.Font.GothamBold;titleLbl.TextSize=16
titleLbl.TextXAlignment=Enum.TextXAlignment.Left;titleLbl.Parent=topbar
local minBtn=Instance.new("TextButton")
minBtn.Size=UDim2.new(0,30,0,30);minBtn.Position=UDim2.new(1,-76,0,5)
minBtn.Text="—";minBtn.TextColor3=C.textDim;minBtn.BackgroundTransparency=1
minBtn.Font=Enum.Font.GothamBold;minBtn.TextSize=16;minBtn.Parent=topbar
local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,30,0,30);closeBtn.Position=UDim2.new(1,-42,0,5)
closeBtn.Text="✕";closeBtn.TextColor3=C.textDim;closeBtn.BackgroundTransparency=1
closeBtn.Font=Enum.Font.GothamBold;closeBtn.TextSize=14;closeBtn.Parent=topbar
local dragging,dragStart,startPos=false,nil,nil
local function beginDrag(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=true;dragStart=i.Position;startPos=main.Position end end
local function endDrag(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=false end end
topbar.InputBegan:Connect(beginDrag);topbar.InputEnded:Connect(endDrag)
titleLbl.InputBegan:Connect(beginDrag);titleLbl.InputEnded:Connect(endDrag)
uis.InputChanged:Connect(function(i)
if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
local d=i.Position-dragStart
main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
local sidebar=Instance.new("Frame")
sidebar.Size=UDim2.new(0,140,1,-54);sidebar.Position=UDim2.new(0,8,0,46)
sidebar.BackgroundColor3=C.sidebar;sidebar.BorderSizePixel=0;sidebar.Parent=main
Instance.new("UICorner",sidebar).CornerRadius=UDim.new(0,6)
local function makeTabBtn(text,y)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-16,0,32);b.Position=UDim2.new(0,8,0,y)
b.Text=text;b.TextColor3=Color3.fromRGB(240,240,245);b.BackgroundColor3=C.sidebar
b.Font=Enum.Font.GothamSemibold;b.TextSize=11;b.BorderSizePixel=0
b.TextXAlignment=Enum.TextXAlignment.Left;b.Parent=sidebar
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
Instance.new("UIPadding",b).PaddingLeft=UDim.new(0,10)
return b end
local tabArmy=makeTabBtn("Армия РП",8);tabArmy.BackgroundColor3=C.accentDk
local tabTP=makeTabBtn("Телепорты",44)
local tabAimbot=makeTabBtn("Aimbot",80)
local tabPvP=makeTabBtn("🔥 ПВП",116)
local tabSettings=makeTabBtn("Настройки",152)
local content=Instance.new("Frame")
content.Size=UDim2.new(1,-156,1,-54);content.Position=UDim2.new(0,148,0,46)
content.BackgroundColor3=C.bg;content.BorderSizePixel=0;content.Parent=main
Instance.new("UICorner",content).CornerRadius=UDim.new(0,6)
local function makePage()
local p=Instance.new("ScrollingFrame")
p.Size=UDim2.new(1,-16,1,-16);p.Position=UDim2.new(0,8,0,8)
p.BackgroundTransparency=1;p.BorderSizePixel=0;p.CanvasSize=UDim2.new(0,0,0,0)
p.ScrollBarThickness=4;p.ScrollBarImageColor3=C.accent;p.Visible=false;p.Parent=content
Instance.new("UIListLayout",p).Padding=UDim.new(0,6)
return p end
local armyPage=makePage();armyPage.Visible=true
local tpPage=makePage();local aimbotPage=makePage()
local pvpPage=makePage();local settingsPage=makePage()
local function showTab(n)
armyPage.Visible=false;tpPage.Visible=false;aimbotPage.Visible=false;pvpPage.Visible=false;settingsPage.Visible=false
tabArmy.BackgroundColor3=C.sidebar;tabTP.BackgroundColor3=C.sidebar;tabAimbot.BackgroundColor3=C.sidebar;tabPvP.BackgroundColor3=C.sidebar;tabSettings.BackgroundColor3=C.sidebar
if n=="army" then armyPage.Visible=true;tabArmy.BackgroundColor3=C.accentDk
elseif n=="tp" then tpPage.Visible=true;tabTP.BackgroundColor3=C.accentDk
elseif n=="aimbot" then aimbotPage.Visible=true;tabAimbot.BackgroundColor3=C.accentDk
elseif n=="pvp" then pvpPage.Visible=true;tabPvP.BackgroundColor3=C.accentDk
else settingsPage.Visible=true;tabSettings.BackgroundColor3=C.accentDk end end
tabArmy.MouseButton1Click:Connect(function() showTab("army") end)
tabTP.MouseButton1Click:Connect(function() showTab("tp") end)
tabAimbot.MouseButton1Click:Connect(function() showTab("aimbot") end)
tabPvP.MouseButton1Click:Connect(function() showTab("pvp") end)
tabSettings.MouseButton1Click:Connect(function() showTab("settings") end)
local togglesData={};local hotkeyRegistry={};local waitingHotkeyToggle=nil
local function keyToShortName(k)
if not k then return "NONE" end
local n=tostring(k):gsub("Enum.KeyCode.","")
n=n:gsub("^Left","L"):gsub("^Right","R"):gsub("Control","Ctrl")
if #n>8 then n=n:sub(1,7).."…" end
return n end
local function renderBadge(b,k)
if not b then return end
if k then b.Text="[ "..keyToShortName(k).." ]";b.TextColor3=C.accent
else b.Text="[ NONE ]";b.TextColor3=C.badgeText end end
local function makeToggle(parent,text,hasBadge,onClick)
local row=Instance.new("Frame")
row.Size=UDim2.new(1,-12,0,42);row.BackgroundColor3=C.row;row.BorderSizePixel=0;row.Parent=parent
Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
local dot=Instance.new("Frame")
dot.Size=UDim2.new(0,6,0,6);dot.Position=UDim2.new(0,12,0.5,-3)
dot.BackgroundColor3=C.textDim;dot.BorderSizePixel=0;dot.Parent=row
Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
local label=Instance.new("TextLabel")
label.Size=UDim2.new(0.55,0,1,0);label.Position=UDim2.new(0,26,0,0)
label.Text=text;label.TextColor3=C.text;label.BackgroundTransparency=1
label.Font=Enum.Font.GothamMedium;label.TextSize=12
label.TextXAlignment=Enum.TextXAlignment.Left;label.Parent=row
local badge=nil
if hasBadge then
badge=Instance.new("TextButton")
badge.Size=UDim2.new(0,88,0,20);badge.Position=UDim2.new(1,-138,0.5,-10)
badge.Text="[ NONE ]";badge.TextColor3=C.badgeText;badge.BackgroundColor3=C.badge
badge.Font=Enum.Font.GothamMedium;badge.TextSize=10;badge.BorderSizePixel=0
badge.Parent=row;badge.AutoButtonColor=false;badge.ZIndex=5
Instance.new("UICorner",badge).CornerRadius=UDim.new(0,4) end
local tBg=Instance.new("Frame")
tBg.Size=UDim2.new(0,34,0,18);tBg.Position=UDim2.new(1,-46,0.5,-9)
tBg.BackgroundColor3=C.toggleOff;tBg.BorderSizePixel=0;tBg.Parent=row
Instance.new("UICorner",tBg).CornerRadius=UDim.new(1,0)
local knob=Instance.new("Frame")
knob.Size=UDim2.new(0,14,0,14);knob.Position=UDim2.new(0,2,0.5,-7)
knob.BackgroundColor3=C.knob;knob.BorderSizePixel=0;knob.Parent=tBg
Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
local click=Instance.new("TextButton")
click.Size=UDim2.new(1,0,1,0);click.BackgroundTransparency=1;click.Text=""
click.Parent=row;click.ZIndex=1
local state=false;local hotkey=nil
local function render()
if state then tBg.BackgroundColor3=C.accent;knob.Position=UDim2.new(1,-16,0.5,-7);dot.BackgroundColor3=C.accent
else tBg.BackgroundColor3=C.toggleOff;knob.Position=UDim2.new(0,2,0.5,-7);dot.BackgroundColor3=C.textDim end end
local api={}
api.set=function(v) state=v;render();if onClick then onClick(state) end end
api.get=function() return state end
api.getHotkey=function() return hotkey end
api.getBadge=function() return badge end
api.setHotkeyInternal=function(k) hotkey=k end
api.clearHotkey=function()
if hotkey and hotkeyRegistry[hotkey]==api then hotkeyRegistry[hotkey]=nil end
hotkey=nil;if badge then renderBadge(badge,nil) end end
click.MouseButton1Click:Connect(function() state=not state;render();if onClick then onClick(state) end end)
if badge then
badge.MouseButton1Click:Connect(function()
if waitingHotkeyToggle and waitingHotkeyToggle~=api then
local prev=waitingHotkeyToggle.getBadge()
if prev then renderBadge(prev,waitingHotkeyToggle.getHotkey()) end end
if waitingHotkeyToggle==api then waitingHotkeyToggle=nil;renderBadge(badge,hotkey);return end
waitingHotkeyToggle=api;badge.Text="[ ... ]";badge.TextColor3=Color3.fromRGB(255,200,80) end)
badge.MouseButton2Click:Connect(function()
if waitingHotkeyToggle==api then waitingHotkeyToggle=nil end
api.clearHotkey() end) end
table.insert(togglesData,{api=api,tBg=tBg,dot=dot})
return api end
local function makeSlider(parent,label,minVal,maxVal,defaultVal,isFloat,onChange)
local row=Instance.new("Frame")
row.Size=UDim2.new(1,-12,0,58);row.BackgroundColor3=C.row
row.BorderSizePixel=0;row.Parent=parent
Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(0.7,-12,0,18);lbl.Position=UDim2.new(0,12,0,4)
lbl.BackgroundTransparency=1;lbl.Text=label;lbl.TextColor3=C.text
lbl.Font=Enum.Font.GothamMedium;lbl.TextSize=12
lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Parent=row
local valLbl=Instance.new("TextLabel")
valLbl.Size=UDim2.new(0.3,-12,0,18);valLbl.Position=UDim2.new(0.7,0,0,4)
valLbl.BackgroundTransparency=1
valLbl.Text=isFloat and string.format("%.2f",defaultVal) or tostring(defaultVal)
valLbl.TextColor3=C.accent;valLbl.Font=Enum.Font.GothamBold
valLbl.TextSize=12;valLbl.TextXAlignment=Enum.TextXAlignment.Right;valLbl.Parent=row
local barBg=Instance.new("Frame")
barBg.Size=UDim2.new(1,-24,0,6);barBg.Position=UDim2.new(0,12,0,34)
barBg.BackgroundColor3=C.toggleOff;barBg.BorderSizePixel=0;barBg.Parent=row
Instance.new("UICorner",barBg).CornerRadius=UDim.new(1,0)
local barFill=Instance.new("Frame")
barFill.Size=UDim2.new(0,0,1,0);barFill.BackgroundColor3=C.accent
barFill.BorderSizePixel=0;barFill.Parent=barBg
Instance.new("UICorner",barFill).CornerRadius=UDim.new(1,0)
local knob=Instance.new("Frame")
knob.Size=UDim2.new(0,14,0,14);knob.Position=UDim2.new(0,0,0.5,-7)
knob.BackgroundColor3=C.knob;knob.BorderSizePixel=0;knob.ZIndex=2;knob.Parent=barBg
Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
local value=defaultVal
local function setValue(v)
v=math.clamp(v,minVal,maxVal)
if not isFloat then v=math.floor(v) end
value=v;valLbl.Text=isFloat and string.format("%.2f",v) or tostring(v)
local pct=(v-minVal)/(maxVal-minVal)
barFill.Size=UDim2.new(pct,0,1,0);knob.Position=UDim2.new(pct,-7,0.5,-7)
if onChange then onChange(v) end end
setValue(defaultVal)
local dragging2=false
local function updateFromX(x)
local relX=x-barBg.AbsolutePosition.X
local pct=math.clamp(relX/barBg.AbsoluteSize.X,0,1)
setValue(minVal+pct*(maxVal-minVal)) end
barBg.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging2=true;updateFromX(i.Position.X) end end)
uis.InputChanged:Connect(function(i)
if dragging2 and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
updateFromX(i.Position.X) end end)
uis.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging2=false end end)
return {set=setValue,get=function() return value end} end
local function makeSectionLabel(parent,text)
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(1,-12,0,22);lbl.BackgroundTransparency=1
lbl.Text=text;lbl.TextColor3=C.badgeText;lbl.Font=Enum.Font.GothamBold
lbl.TextSize=11;lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Parent=parent
return lbl end
local function makeButton(parent,text,color,onClick)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-12,0,40);b.BackgroundColor3=color or C.accentDk
b.Text=text;b.TextColor3=C.text;b.Font=Enum.Font.GothamBold
b.TextSize=12;b.BorderSizePixel=0;b.Parent=parent
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
b.MouseButton1Click:Connect(onClick)
return b end
local function getHum() local c=player.Character;return c and c:FindFirstChildOfClass("Humanoid") end
local function getHRP() local c=player.Character;return c and c:FindFirstChild("HumanoidRootPart") end
local function getFactionColor(p)
if p.Team and p.Team.TeamColor then return p.Team.TeamColor.Color end
return Color3.fromRGB(180,180,180) end
local function showNotif(text,color)
local n=Instance.new("TextLabel")
n.Size=UDim2.new(0,500,0,50);n.Position=UDim2.new(0.5,-250,0.15,0)
n.BackgroundColor3=Color3.fromRGB(20,20,30);n.BackgroundTransparency=0.15
n.Text=text;n.TextColor3=color or C.text;n.Font=Enum.Font.GothamBold
n.TextSize=14;n.BorderSizePixel=0;n.ZIndex=999;n.Parent=gui
Instance.new("UICorner",n).CornerRadius=UDim.new(0,8)
game:GetService("Debris"):AddItem(n,3)
return n end

-- УНИВЕРСАЛЬНОЕ ПЕРЕТАСКИВАНИЕ ОКОН
local function makeDraggable(frame, handle)
if not frame or not handle then return end
local dragOn, ds, sp = false, nil, nil
handle.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragOn=true; ds=i.Position; sp=frame.Position
end end)
handle.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragOn=false end end)
uis.InputChanged:Connect(function(i)
if dragOn and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
local d=i.Position-ds
frame.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
end end)
uis.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragOn=false end end)
end

-- ESP
local espList,espData,espConn={},{},nil
local playerConns,statCache={},{}
local function clearESP()
for _,o in ipairs(espList) do pcall(function() o:Destroy() end) end
espList,espData={},{} end
local function formatNum(n)
if not n then return "—" end
n=tonumber(n) or 0
if n>=1e6 then return string.format("%.1fM",n/1e6) end
if n>=1e3 then return string.format("%.1fK",n/1e3) end
return tostring(math.floor(n)) end
local function updateStats()
for _,d in ipairs(espData) do
local p=d.plr;local cache=statCache[p]
if not cache then cache={};statCache[p]=cache end
local cs={p:FindFirstChild("leaderstats"),p:FindFirstChild("Stats"),p}
local cash,minutes
for _,c in ipairs(cs) do
if c then local v=c:FindFirstChild("Cash") or c:FindFirstChild("Деньги") or c:FindFirstChild("Money") or c:FindFirstChild("Баланс")
if v and (v:IsA("IntValue") or v:IsA("NumberValue")) then cash=v.Value;break end end end
for _,c in ipairs(cs) do
if c then local v=c:FindFirstChild("Minute") or c:FindFirstChild("Minutes") or c:FindFirstChild("Минуты") or c:FindFirstChild("Time")
if v and (v:IsA("IntValue") or v:IsA("NumberValue")) then minutes=v.Value;break end end end
cache.cash=cash;cache.minutes=minutes
cache.faction=p.Team and p.Team.Name or nil
cache.factionColor=getFactionColor(p) end end
local function createESP(p)
if p==player then return end
local ch=p.Character;if not ch then return end
local head=ch:FindFirstChild("Head");if not head then return end
local bb=Instance.new("BillboardGui")
bb.Size=UDim2.new(0,260,0,68);bb.StudsOffset=Vector3.new(0,3.5,0)
bb.AlwaysOnTop=true;bb.Parent=head
local bg=Instance.new("Frame")
bg.Size=UDim2.new(1,0,1,0);bg.BackgroundColor3=Color3.fromRGB(0,0,0)
bg.BackgroundTransparency=0.85;bg.BorderSizePixel=0;bg.Parent=bb
Instance.new("UICorner",bg).CornerRadius=UDim.new(0,3)
local function mt(pos,size,font,txtSize,color,align)
local t=Instance.new("TextLabel")
t.Size=size;t.Position=pos;t.BackgroundTransparency=1;t.Font=font
t.TextSize=txtSize;t.TextColor3=color;t.TextXAlignment=align
t.TextStrokeTransparency=0;t.TextStrokeColor3=Color3.fromRGB(0,0,0);t.Parent=bg;return t end
local nameL=mt(UDim2.new(0,3,0,1),UDim2.new(0.45,-3,0,15),Enum.Font.GothamBold,11,Color3.fromRGB(255,255,255),Enum.TextXAlignment.Left)
local factionL=mt(UDim2.new(0.45,0,0,1),UDim2.new(0.4,-3,0,15),Enum.Font.GothamBold,11,Color3.fromRGB(255,200,50),Enum.TextXAlignment.Left)
local hpTextL=mt(UDim2.new(0.85,0,0,1),UDim2.new(0.15,-3,0,15),Enum.Font.GothamBold,10,Color3.fromRGB(100,255,100),Enum.TextXAlignment.Right)
local distL=mt(UDim2.new(0,3,0,18),UDim2.new(0.4,-3,0,13),Enum.Font.GothamBold,10,Color3.fromRGB(255,200,50),Enum.TextXAlignment.Left)
local cashL=mt(UDim2.new(0.4,0,0,18),UDim2.new(0.3,-3,0,13),Enum.Font.GothamBold,10,Color3.fromRGB(100,255,100),Enum.TextXAlignment.Center)
local minL=mt(UDim2.new(0.7,0,0,18),UDim2.new(0.3,-3,0,13),Enum.Font.GothamBold,10,Color3.fromRGB(100,200,255),Enum.TextXAlignment.Right)
local hpBg=Instance.new("Frame")
hpBg.Size=UDim2.new(1,-6,0,4);hpBg.Position=UDim2.new(0,3,0,34)
hpBg.BackgroundColor3=Color3.fromRGB(40,15,15);hpBg.BackgroundTransparency=0.4
hpBg.BorderSizePixel=0;hpBg.Parent=bg
Instance.new("UICorner",hpBg).CornerRadius=UDim.new(1,0)
local hpF=Instance.new("Frame")
hpF.Size=UDim2.new(1,0,1,0);hpF.BackgroundColor3=Color3.fromRGB(0,200,0)
hpF.BackgroundTransparency=0.15;hpF.BorderSizePixel=0;hpF.Parent=hpBg
Instance.new("UICorner",hpF).CornerRadius=UDim.new(1,0)
local hl=Instance.new("Highlight")
hl.FillColor=Color3.fromRGB(255,0,0);hl.FillTransparency=0.85
hl.OutlineColor=Color3.fromRGB(255,255,0);hl.OutlineTransparency=0.3;hl.Parent=ch
table.insert(espList,hl)
return {bb=bb,nameL=nameL,factionL=factionL,distL=distL,hpTextL=hpTextL,cashL=cashL,minL=minL,hpF=hpF,plr=p,hl=hl} end
local function removeESPFor(p)
statCache[p]=nil
for i=#espData,1,-1 do
if espData[i].plr==p then
if espData[i].hl then pcall(function() espData[i].hl:Destroy() end) end
pcall(function() espData[i].bb:Destroy() end)
table.remove(espData,i) end end end
local function refreshPlayerESP(p)
if p==player or not p.Character then return end
removeESPFor(p)
local d=createESP(p)
if d then table.insert(espList,d.bb);table.insert(espData,d) end end
local function hookPlayer(p)
if p==player or playerConns[p] then return end
playerConns[p]=true
p.CharacterAdded:Connect(function() task.wait(0.15);if espConn then refreshPlayerESP(p) end end)
p.CharacterRemoving:Connect(function() task.wait(0.1);removeESPFor(p) end) end
local function syncESP()
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=player then
hookPlayer(p)
local hasChar=p.Character and p.Character:FindFirstChild("Head")
local hasESP=false
for _,d in ipairs(espData) do
if d.plr==p and d.bb.Parent then
if d.bb.Parent==p.Character:FindFirstChild("Head") then hasESP=true end
break end end
if hasChar and not hasESP then refreshPlayerESP(p)
elseif not hasChar then removeESPFor(p) end end end
for i=#espData,1,-1 do
local d=espData[i]
if not d.plr or not d.plr.Parent or not game.Players:FindFirstChild(d.plr.Name) then
if d.hl then pcall(function() d.hl:Destroy() end) end
pcall(function() d.bb:Destroy() end);table.remove(espData,i) end end end
game.Players.PlayerAdded:Connect(function(p) hookPlayer(p);task.wait(0.5);if espConn then refreshPlayerESP(p) end end)
game.Players.PlayerRemoving:Connect(function(p) playerConns[p]=nil;removeESPFor(p) end)
local function startESP()
clearESP()
for _,p in ipairs(game.Players:GetPlayers()) do
hookPlayer(p)
if p~=player and p.Character then
local d=createESP(p)
if d then table.insert(espList,d.bb);table.insert(espData,d) end end end
espConn=runService.RenderStepped:Connect(function()
local myHRP=getHRP()
for _,d in ipairs(espData) do
local char=d.plr.Character
if char and d.bb.Parent then
local theirHRP=char:FindFirstChild("HumanoidRootPart")
if myHRP and theirHRP then
local dist=(myHRP.Position-theirHRP.Position).Magnitude
d.distL.Text=string.format("📍%.0fм",dist)
if dist<30 then d.distL.TextColor3=Color3.fromRGB(255,80,80)
elseif dist<100 then d.distL.TextColor3=Color3.fromRGB(255,200,50)
else d.distL.TextColor3=Color3.fromRGB(100,200,255) end
else d.distL.Text="📍—" end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum then
local pct=math.clamp(hum.Health/hum.MaxHealth,0,1)
d.hpF.Size=UDim2.new(pct,0,1,0)
d.hpTextL.Text=string.format("❤%d",math.floor(hum.Health))
if pct>0.6 then d.hpF.BackgroundColor3=Color3.fromRGB(0,200,0);d.hpTextL.TextColor3=Color3.fromRGB(100,255,100)
elseif pct>0.3 then d.hpF.BackgroundColor3=Color3.fromRGB(255,200,0);d.hpTextL.TextColor3=Color3.fromRGB(255,200,50)
else d.hpF.BackgroundColor3=Color3.fromRGB(255,0,0);d.hpTextL.TextColor3=Color3.fromRGB(255,80,80) end end end end end)
task.spawn(function() while espConn do syncESP();task.wait(0.5) end end)
task.spawn(function()
while espConn do
updateStats()
for _,d in ipairs(espData) do
local cache=statCache[d.plr]
if cache and d.bb.Parent then
d.nameL.Text=d.plr.Name
if cache.faction and cache.faction~="" then d.factionL.Text="| "..cache.faction;d.factionL.TextColor3=cache.factionColor
else d.factionL.Text="| Без фракции";d.factionL.TextColor3=Color3.fromRGB(140,140,140) end
d.cashL.Text="💰"..formatNum(cache.cash)
d.minL.Text="⏱"..formatNum(cache.minutes) end end
task.wait(0.4) end end) end
local function stopESP()
if espConn then espConn:Disconnect();espConn=nil end
clearESP();playerConns={};statCache={} end

-- AIMBOT
local aimbotOn,aimbotConn=false,nil
local aimbotFOV,aimbotSmooth=300,0.35
local aimbotVisible=true
local aimbotButtonMode="RMB"
local aimbotPrediction,aimbotSticky=true,true
local aimbotTargetMode,aimbotIgnoreTeammates="Auto",true
local currentTarget=nil
local function isTeammate(p)
if not p then return false end
return player.Team~=nil and p.Team==player.Team end
local function isAimbotActive()
if aimbotButtonMode=="Always" then return true end
if aimbotButtonMode=="RMB" then return uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end
if aimbotButtonMode=="LMB" then return uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end
return false end
local function rayVisible(from,to,ign)
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
local filter={}
if player.Character then table.insert(filter,player.Character) end
if ign then table.insert(filter,ign) end
params.FilterDescendantsInstances=filter
return workspace:Raycast(from,to-from,params)==nil end
local function getAimParts(char)
local out={}
if aimbotTargetMode=="Head" then
local h=char:FindFirstChild("Head");if h then table.insert(out,h) end
elseif aimbotTargetMode=="Body" then
local u=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
if u then table.insert(out,u) end
else
local h=char:FindFirstChild("Head")
local u=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
if h then table.insert(out,h) end
if u and u~=h then table.insert(out,u) end end
return out end
local function scoreTarget(part,scrCenter,myPos)
local sp,onScreen=camera:WorldToViewportPoint(part.Position)
if not onScreen then return nil end
local d2d=(Vector2.new(sp.X,sp.Y)-scrCenter).Magnitude
if d2d>aimbotFOV then return nil end
if aimbotVisible and not rayVisible(myPos,part.Position,part.Parent) then return nil end
return d2d+(myPos-part.Position).Magnitude*0.05 end
local function findTarget()
local myPos=camera.CFrame.Position
local scrCenter=Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)
local best,bestScore=nil,math.huge
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=player and p.Character and not (aimbotIgnoreTeammates and isTeammate(p)) then
local hum=p.Character:FindFirstChildOfClass("Humanoid")
if hum and hum.Health>0 then
for _,part in ipairs(getAimParts(p.Character)) do
local score=scoreTarget(part,scrCenter,myPos)
if score and score<bestScore then bestScore=score;best={part=part,character=p.Character,player=p} end end end end end
return best end
local function validateTarget(t)
if not t or not t.player or not t.player.Parent then return false end
if not t.character or not t.character.Parent then return false end
if t.part.Parent~=t.character then return false end
if aimbotIgnoreTeammates and isTeammate(t.player) then return false end
local hum=t.character:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health<=0 then return false end
local score=scoreTarget(t.part,Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2),camera.CFrame.Position)
if not score or score>aimbotFOV*1.5 then return false end
return true end
local function predictPos(t)
if not aimbotPrediction then return t.part.Position end
local vel=t.part.AssemblyLinearVelocity
if not vel or vel.Magnitude<1 then return t.part.Position end
return t.part.Position+vel*0.08 end
local function startAimbot()
if aimbotConn then aimbotConn:Disconnect() end
currentTarget=nil
aimbotConn=runService.RenderStepped:Connect(function(dt)
if not aimbotOn then return end
if not isAimbotActive() then currentTarget=nil;return end
if dt<=0 then return end
local target
if aimbotSticky and currentTarget and validateTarget(currentTarget) then target=currentTarget
else target=findTarget();currentTarget=target end
if target then
local desired=CFrame.new(camera.CFrame.Position,predictPos(target))
local alpha=math.clamp(dt/math.max(aimbotSmooth,0.01)*10,0,1)
camera.CFrame=camera.CFrame:Lerp(desired,alpha) end end) end
local function stopAimbot()
if aimbotConn then aimbotConn:Disconnect();aimbotConn=nil end
currentTarget=nil end
makeSectionLabel(aimbotPage,"🎯 УПРАВЛЕНИЕ")
makeToggle(aimbotPage,"Аимбот включён",true,function(on) aimbotOn=on;if on then startAimbot() else stopAimbot() end end)
local btnModeRow=Instance.new("Frame")
btnModeRow.Size=UDim2.new(1,-12,0,62);btnModeRow.BackgroundColor3=C.row
btnModeRow.BorderSizePixel=0;btnModeRow.Parent=aimbotPage
Instance.new("UICorner",btnModeRow).CornerRadius=UDim.new(0,6)
local btnModeLbl=Instance.new("TextLabel")
btnModeLbl.Size=UDim2.new(1,-20,0,18);btnModeLbl.Position=UDim2.new(0,12,0,4)
btnModeLbl.BackgroundTransparency=1;btnModeLbl.Text="Кнопка активации"
btnModeLbl.TextColor3=C.text;btnModeLbl.Font=Enum.Font.GothamMedium
btnModeLbl.TextSize=12;btnModeLbl.TextXAlignment=Enum.TextXAlignment.Left;btnModeLbl.Parent=btnModeRow
local function makeModeBtn(text,x,mode)
local b=Instance.new("TextButton")
b.Size=UDim2.new(0.31,-6,0,28);b.Position=UDim2.new(x,0,0,28)
b.Text=text;b.TextColor3=C.text
b.BackgroundColor3=(aimbotButtonMode==mode) and C.accent or C.badge
b.Font=Enum.Font.GothamBold;b.TextSize=11;b.BorderSizePixel=0;b.Parent=btnModeRow
Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
return b end
local btnRMB=makeModeBtn("ПКМ",0.02,"RMB")
local btnLMB=makeModeBtn("ЛКМ",0.345,"LMB")
local btnAlways=makeModeBtn("Всегда",0.67,"Always")
local modeBtns={RMB=btnRMB,LMB=btnLMB,Always=btnAlways}
local function setMode(m) aimbotButtonMode=m
for k,b in pairs(modeBtns) do if k==m then b.BackgroundColor3=C.accent else b.BackgroundColor3=C.badge end end end
btnRMB.MouseButton1Click:Connect(function() setMode("RMB") end)
btnLMB.MouseButton1Click:Connect(function() setMode("LMB") end)
btnAlways.MouseButton1Click:Connect(function() setMode("Always") end)
makeSectionLabel(aimbotPage,"🎯 ЦЕЛЬ")
makeToggle(aimbotPage,"Предсказание",true,function(on) aimbotPrediction=on end)
makeToggle(aimbotPage,"Держать цель",true,function(on) aimbotSticky=on;if not on then currentTarget=nil end end)
local partRow=Instance.new("Frame")
partRow.Size=UDim2.new(1,-12,0,62);partRow.BackgroundColor3=C.row
partRow.BorderSizePixel=0;partRow.Parent=aimbotPage
Instance.new("UICorner",partRow).CornerRadius=UDim.new(0,6)
local partLbl=Instance.new("TextLabel")
partLbl.Size=UDim2.new(1,-20,0,18);partLbl.Position=UDim2.new(0,12,0,4)
partLbl.BackgroundTransparency=1;partLbl.Text="Точка"
partLbl.TextColor3=C.text;partLbl.Font=Enum.Font.GothamMedium
partLbl.TextSize=12;partLbl.TextXAlignment=Enum.TextXAlignment.Left;partLbl.Parent=partRow
local function makePartBtn(text,x,mode)
local b=Instance.new("TextButton")
b.Size=UDim2.new(0.31,-6,0,28);b.Position=UDim2.new(x,0,0,28)
b.Text=text;b.TextColor3=C.text
b.BackgroundColor3=(aimbotTargetMode==mode) and C.accent or C.badge
b.Font=Enum.Font.GothamBold;b.TextSize=11;b.BorderSizePixel=0;b.Parent=partRow
Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
return b end
local pBtnAuto=makePartBtn("Авто",0.02,"Auto")
local pBtnHead=makePartBtn("Голова",0.345,"Head")
local pBtnBody=makePartBtn("Тело",0.67,"Body")
local partBtns={Auto=pBtnAuto,Head=pBtnHead,Body=pBtnBody}
local function setTargetMode(m) aimbotTargetMode=m
for k,b in pairs(partBtns) do if k==m then b.BackgroundColor3=C.accent else b.BackgroundColor3=C.badge end end
currentTarget=nil end
pBtnAuto.MouseButton1Click:Connect(function() setTargetMode("Auto") end)
pBtnHead.MouseButton1Click:Connect(function() setTargetMode("Head") end)
pBtnBody.MouseButton1Click:Connect(function() setTargetMode("Body") end)
makeSectionLabel(aimbotPage,"⚙️ ПАРАМЕТРЫ")
makeSlider(aimbotPage,"FOV",50,800,300,false,function(v) aimbotFOV=v end)
makeSlider(aimbotPage,"Плавность",0.05,1,0.35,true,function(v) aimbotSmooth=v end)
makeToggle(aimbotPage,"Только видимые",true,function(on) aimbotVisible=on end)
makeToggle(aimbotPage,"Не стрелять по своим",true,function(on) aimbotIgnoreTeammates=on;currentTarget=nil end)

-- ARMY
makeToggle(armyPage,"ESP Игроков",true,function(on) if on then startESP() else stopESP() end end)
makeButton(armyPage,"🔄 Обновить ESP",Color3.fromRGB(50,80,120),function()
if not espConn then showNotif("⚠ Сначала включи ESP",Color3.fromRGB(255,200,80));return end
syncESP()
showNotif("✅ ESP обновлён ("..#espData..")",Color3.fromRGB(100,255,100)) end)
local noRecoilOn=false
local noRecoilConn=nil
local recoilMouseDelta=Vector2.new(0,0)
local lastRecoilCamLook=nil
uis.InputChanged:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseMovement then
recoilMouseDelta=recoilMouseDelta+Vector2.new(i.Delta.X,i.Delta.Y) end end)
local function killRecoil(obj)
for _,c in ipairs(obj:GetDescendants()) do
if c:IsA("NumberValue") or c:IsA("IntValue") then
local n=c.Name:lower()
if n:find("recoil") or n:find("kick") or n:find("shake") or n:find("spread") or n:find("bounce") or n:find("camera") then pcall(function() c.Value=0 end) end
elseif c:IsA("Vector3Value") then
local n=c.Name:lower()
if n:find("recoil") or n:find("kick") or n:find("shake") then pcall(function() c.Value=Vector3.new(0,0,0) end) end end end end
local function scanWeapons()
if not player.Character then return end
for _,t in ipairs(player.Character:GetChildren()) do if t:IsA("Tool") then killRecoil(t) end end
local bp=player:FindFirstChild("Backpack")
if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then killRecoil(t) end end end end
local function startNoRecoil()
noRecoilOn=true;scanWeapons();lastRecoilCamLook=camera.CFrame.LookVector
if noRecoilConn then noRecoilConn:Disconnect() end
noRecoilConn=runService.RenderStepped:Connect(function()
if not noRecoilOn then return end
local hum=getHum()
if hum and hum.CameraOffset.Magnitude>0.001 then hum.CameraOffset=Vector3.new(0,0,0) end
local currentLook=camera.CFrame.LookVector
if lastRecoilCamLook then
local cPitch=math.asin(math.clamp(currentLook.Y,-1,1))
local lPitch=math.asin(math.clamp(lastRecoilCamLook.Y,-1,1))
local pDelta=cPitch-lPitch
local exp=-math.rad(recoilMouseDelta.Y)*0.35
local unexp=pDelta-exp
if math.abs(unexp)>0.001 then camera.CFrame=camera.CFrame*CFrame.Angles(-unexp,0,0);currentLook=camera.CFrame.LookVector end
local tU=camera.CFrame.Position+camera.CFrame.LookVector*10+Vector3.new(0,0.5,0)
local uD=(tU-(camera.CFrame.Position+camera.CFrame.LookVector*10)).Y
if uD>0.05 then camera.CFrame=camera.CFrame*CFrame.Angles(-uD*0.15,0,0) end end
lastRecoilCamLook=currentLook;recoilMouseDelta=Vector2.new(0,0) end)
task.spawn(function() while noRecoilOn do scanWeapons();task.wait(0.5) end end) end
local function stopNoRecoil()
noRecoilOn=false
if noRecoilConn then noRecoilConn:Disconnect();noRecoilConn=nil end
local hum=getHum();if hum then hum.CameraOffset=Vector3.new(0,0,0) end
lastRecoilCamLook=nil end
local fullbrightOn=false
local fbConn=nil
local fbSaved=nil
local fbHiddenAtmos={}
local function applyFB()
if not fbSaved then
fbSaved={Brightness=lighting.Brightness,Ambient=lighting.Ambient,OutdoorAmbient=lighting.OutdoorAmbient,FogEnd=lighting.FogEnd,FogStart=lighting.FogStart,FogColor=lighting.FogColor,ClockTime=lighting.ClockTime,GeographicLatitude=lighting.GeographicLatitude,GlobalShadows=lighting.GlobalShadows,ExposureCompensation=lighting.ExposureCompensation,EnvironmentDiffuseScale=lighting.EnvironmentDiffuseScale,EnvironmentSpecularScale=lighting.EnvironmentSpecularScale,ShadowSoftness=lighting.ShadowSoftness} end
lighting.Brightness=3;lighting.Ambient=Color3.fromRGB(200,200,200)
lighting.OutdoorAmbient=Color3.fromRGB(200,200,200)
lighting.FogEnd=1e6;lighting.FogStart=1e6
lighting.FogColor=Color3.fromRGB(200,200,200);lighting.ClockTime=14
lighting.GeographicLatitude=0;lighting.GlobalShadows=false
lighting.ExposureCompensation=1;lighting.EnvironmentDiffuseScale=1;lighting.EnvironmentSpecularScale=1
for _,c in ipairs(lighting:GetChildren()) do
if c:IsA("Atmosphere") and not fbHiddenAtmos[c] then fbHiddenAtmos[c]={parent=c.Parent,name=c.Name};c.Parent=nil end end end
local function restoreFB()
if fbSaved then for k,v in pairs(fbSaved) do pcall(function() lighting[k]=v end) end;fbSaved=nil end
for a,info in pairs(fbHiddenAtmos) do pcall(function() a.Name=info.name;a.Parent=info.parent or lighting end) end
fbHiddenAtmos={} end
makeToggle(armyPage,"FullBright",true,function(on)
fullbrightOn=on
if on then applyFB()
if fbConn then fbConn:Disconnect() end
fbConn=runService.Heartbeat:Connect(function() if fullbrightOn then applyFB() end end)
else if fbConn then fbConn:Disconnect();fbConn=nil end;restoreFB() end end)
local jumpOn=false
local savedJumpPower=nil
local function applyJump()
local hum=getHum()
if hum then if savedJumpPower==nil then savedJumpPower=hum.JumpPower end
hum.UseJumpPower=true;hum.JumpPower=85 end end
local function removeJump()
local hum=getHum()
if hum and savedJumpPower then hum.JumpPower=savedJumpPower end
savedJumpPower=nil end
makeToggle(armyPage,"Прыжок+",true,function(on) jumpOn=on;if on then applyJump() else removeJump() end end)
player.CharacterAdded:Connect(function() task.wait(1);if jumpOn then applyJump() end end)
local flyBV,flyConn,flyOn,flySpeed=nil,nil,false,70
local function startFly()
local hrp,hum=getHRP(),getHum()
if not hrp or not hum then return end
flyOn=true
pcall(function() hrp:SetNetworkOwner(player) end)
hum.PlatformStand=true
flyBV=Instance.new("BodyVelocity")
flyBV.MaxForce=Vector3.new(1e4,1e4,1e4);flyBV.P=1250
flyBV.Velocity=Vector3.new(0,0,0);flyBV.Parent=hrp
flyConn=runService.RenderStepped:Connect(function(dt)
if not flyOn or not flyBV or not flyBV.Parent or not player.Character then return end
local cam=camera.CFrame
local dir=Vector3.new()
if uis:IsKeyDown(Enum.KeyCode.W) then dir=dir+cam.LookVector end
if uis:IsKeyDown(Enum.KeyCode.S) then dir=dir-cam.LookVector end
if uis:IsKeyDown(Enum.KeyCode.A) then dir=dir-cam.RightVector end
if uis:IsKeyDown(Enum.KeyCode.D) then dir=dir+cam.RightVector end
if uis:IsKeyDown(Enum.KeyCode.Space) then dir=dir+cam.UpVector end
if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir=dir-cam.UpVector end
if dir.Magnitude>0 then dir=dir.Unit end
flyBV.Velocity=flyBV.Velocity:Lerp(dir*flySpeed,math.clamp(dt*12,0,1)) end) end
local function stopFly()
flyOn=false
if flyBV then flyBV:Destroy();flyBV=nil end
if flyConn then flyConn:Disconnect();flyConn=nil end
local h=getHum();if h then h.PlatformStand=false end end
makeToggle(armyPage,"Fly",true,function(on) if on then startFly() else stopFly() end end)
makeSlider(armyPage,"✈️ Скорость Fly",20,250,70,false,function(v) flySpeed=v end)
local ghostCamConn,ghostMouseConn=nil,nil
local ghostCamPos=nil
local ghostYaw,ghostPitch=0,0
local ghostSavedCamType,ghostSavedMouseBehavior=nil,nil
local ghostSavedSpeed,ghostSpeed=16,70
local ghostSavedJumpPower=nil
local GHOST_SENS=0.25
local function startGhost()
local hrp,hum=getHRP(),getHum()
if not hrp or not hum then showNotif("❌ Нет персонажа",Color3.fromRGB(255,100,100));return end
if specSelected and stopSpectate then stopSpectate() end
ghostSavedSpeed=hum.WalkSpeed;ghostSavedJumpPower=hum.JumpPower
for _,p in ipairs(player.Character:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=true end end
hum.PlatformStand=true;hum.WalkSpeed=0;hum.JumpPower=0
local look=camera.CFrame.LookVector
ghostYaw=math.atan2(-look.X,-look.Z)
ghostPitch=math.asin(math.clamp(look.Y,-1,1))
ghostCamPos=camera.CFrame.Position
ghostSavedCamType=camera.CameraType
camera.CameraType=Enum.CameraType.Scriptable
camera.CameraSubject=nil
ghostSavedMouseBehavior=uis.MouseBehavior
uis.MouseBehavior=Enum.MouseBehavior.LockCenter
ghostMouseConn=uis.InputChanged:Connect(function(i)
if not ghostOn then return end
if i.UserInputType==Enum.UserInputType.MouseMovement then
ghostYaw=ghostYaw-math.rad(i.Delta.X)*GHOST_SENS
ghostPitch=math.clamp(ghostPitch-math.rad(i.Delta.Y)*GHOST_SENS,-math.rad(89),math.rad(89)) end end)
ghostCamConn=runService.RenderStepped:Connect(function(dt)
if not ghostOn then return end
if main.Visible then if uis.MouseBehavior~=Enum.MouseBehavior.Default then uis.MouseBehavior=Enum.MouseBehavior.Default end
else if uis.MouseBehavior~=Enum.MouseBehavior.LockCenter then uis.MouseBehavior=Enum.MouseBehavior.LockCenter end end
local rotation=CFrame.fromEulerAnglesYXZ(ghostPitch,ghostYaw,0)
local look=rotation.LookVector
local right=rotation.RightVector
local up=Vector3.new(0,1,0)
local dir=Vector3.new()
if uis:IsKeyDown(Enum.KeyCode.W) then dir=dir+look end
if uis:IsKeyDown(Enum.KeyCode.S) then dir=dir-look end
if uis:IsKeyDown(Enum.KeyCode.A) then dir=dir-right end
if uis:IsKeyDown(Enum.KeyCode.D) then dir=dir+right end
if uis:IsKeyDown(Enum.KeyCode.Space) then dir=dir+up end
if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir=dir-up end
if dir.Magnitude>0 then dir=dir.Unit end
ghostCamPos=ghostCamPos+dir*ghostSpeed*dt
camera.CFrame=CFrame.new(ghostCamPos)*rotation end)
showNotif("👻 Ghost ВКЛ",Color3.fromRGB(150,200,255)) end
local function stopGhost()
ghostOn=false
if ghostCamConn then ghostCamConn:Disconnect();ghostCamConn=nil end
if ghostMouseConn then ghostMouseConn:Disconnect();ghostMouseConn=nil end
if ghostSavedMouseBehavior then uis.MouseBehavior=ghostSavedMouseBehavior end
if ghostSavedCamType then camera.CameraType=ghostSavedCamType end
local hum=getHum()
if hum then camera.CameraSubject=hum end
if player.Character then for _,p in ipairs(player.Character:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=false end end end
if hum then hum.PlatformStand=false;hum.WalkSpeed=ghostSavedSpeed;hum.JumpPower=ghostSavedJumpPower or 50 end end
makeToggle(armyPage,"👻 Ghost",true,function(on) if on then ghostOn=true;startGhost() else stopGhost() end end)
makeSlider(armyPage,"👻 Скорость Ghost",10,300,70,false,function(v) ghostSpeed=v end)
local ncConn
local function startNC()
if ncConn then return end
ncConn=runService.RenderStepped:Connect(function()
local c=player.Character;if not c then return end
for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end) end
local function stopNC()
if ncConn then ncConn:Disconnect();ncConn=nil end
local c=player.Character
if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end end
makeToggle(armyPage,"Noclip",true,function(on) if on then startNC() else stopNC() end end)
local defaultSpeed=16
local function setSpeed(v) local h=getHum();if h then h.WalkSpeed=v end end
makeToggle(armyPage,"Скорость x5",true,function(on) setSpeed(on and 80 or defaultSpeed) end)

-- АВТО-СКОРОСТЬ МАШИНЫ (плавный разгон по W)
local vehicleActive = false
local currentVehSpeed = 80
local vehConn = nil
local currentVehVel = 0

local function getVehModel()
local h = getHum()
if not h then return nil end
local seat = h.SeatPart
if not seat then return nil end
local model = seat.Parent
if not model then return nil end
if not model:IsA("Model") and model.Parent and model.Parent:IsA("Model") then
model = model.Parent
end
return model
end

local function getVehPart(veh)
if not veh then return nil end
if veh.PrimaryPart then return veh.PrimaryPart end
for _, p in ipairs(veh:GetDescendants()) do
if p:IsA("BasePart") and p.Name ~= "Seat" and p.Name ~= "VehicleSeat" then
return p
end
end
return nil
end

local function startVeh()
if vehConn then vehConn:Disconnect() end
currentVehVel = 0
vehConn = runService.RenderStepped:Connect(function(dt)
if not vehicleActive then return end
local v = getVehModel()
if not v then currentVehVel = 0; return end
local r = getVehPart(v)
if not r then return end
local vel = r.AssemblyLinearVelocity
local dir
if vel.Magnitude > 0.5 then
dir = vel.Unit
else
local look = camera.CFrame.LookVector
dir = Vector3.new(look.X, 0, look.Z)
if dir.Magnitude > 0 then dir = dir.Unit end
end
local wHeld = uis:IsKeyDown(Enum.KeyCode.W)
if wHeld then
currentVehVel = math.min(currentVehVel + dt * 50, currentVehSpeed)
else
currentVehVel = math.max(currentVehVel - dt * 80, 0)
end
if currentVehVel > 0.5 then
pcall(function()
r.AssemblyLinearVelocity = dir * currentVehVel
end)
end
end)
end

local function stopVeh()
if vehConn then vehConn:Disconnect(); vehConn = nil end
currentVehVel = 0
end

makeToggle(armyPage,"🚗 Авто-скорость машины",true,function(on)
vehicleActive = on
if on then startVeh() else stopVeh() end
end)
makeSlider(armyPage,"🚗 Скорость машины",20,300,80,false,function(v) currentVehSpeed = v end)

-- СМЕРТЬ + ТП НАЗАД
local deathTPActive=false
local function doDeathTP()
if deathTPActive then return end
deathTPActive=true
local hrp=getHRP()
if not hrp then showNotif("❌ Нет позиции",Color3.fromRGB(255,100,100));deathTPActive=false;return end
local savedPos=hrp.CFrame
local notif=showNotif("💀 Умираю... Возрождение через 11 сек",Color3.fromRGB(255,100,100))
local respawned=false
local respawnConn=player.CharacterAdded:Connect(function() respawned=true end)
local hum=getHum()
if hum then pcall(function() hum.Health=0 end) end
task.spawn(function()
local t0=tick()
while tick()-t0<11 do task.wait(0.1) end
local t1=tick()
while not respawned and tick()-t1<10 do task.wait(0.1) end
if respawnConn then respawnConn:Disconnect() end
task.wait(0.5)
local newHRP=getHRP()
if newHRP and savedPos then
for _=1,3 do newHRP.CFrame=savedPos+Vector3.new(0,3,0);task.wait(0.3) end
if notif then notif:Destroy() end
showNotif("✅ Возрождён!",Color3.fromRGB(100,255,100))
else if notif then notif:Destroy() end end
deathTPActive=false end) end
makeButton(armyPage,"💀 Смерть + ТП назад (11 сек)",Color3.fromRGB(80,30,30),doDeathTP)

local tpClickOn,tpClickConn,tpClickIndicator=false,nil,nil
local function doTeleportToPoint(pos)
if not pos then return end
local char=player.Character
if not char then return end
local hrp=char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
local final=pos+Vector3.new(0,3,0)
pcall(function() char:PivotTo(CFrame.new(final)) end)
pcall(function() hrp.CFrame=CFrame.new(final) end)
task.delay(0.05,function()
local c2=player.Character
if c2 then local h2=c2:FindFirstChild("HumanoidRootPart")
if h2 then pcall(function() h2.CFrame=CFrame.new(final) end) end end end) end
local function startTpClick()
tpClickOn=true
if not tpClickIndicator then
tpClickIndicator=Instance.new("TextLabel")
tpClickIndicator.Size=UDim2.new(0,500,0,40);tpClickIndicator.Position=UDim2.new(0.5,-250,0,50)
tpClickIndicator.BackgroundColor3=Color3.fromRGB(20,20,30);tpClickIndicator.BackgroundTransparency=0.3
tpClickIndicator.Text="📍 TP ПО КЛИКУ ВКЛ";tpClickIndicator.TextColor3=C.accent
tpClickIndicator.Font=Enum.Font.GothamBold;tpClickIndicator.TextSize=14
tpClickIndicator.BorderSizePixel=0;tpClickIndicator.ZIndex=999;tpClickIndicator.Parent=gui
Instance.new("UICorner",tpClickIndicator).CornerRadius=UDim.new(0,8) end
tpClickIndicator.Visible=true
tpClickConn=uis.InputBegan:Connect(function(i,gpe)
if not tpClickOn or gpe then return end
if i.UserInputType~=Enum.UserInputType.MouseButton1 then return end
if main.Visible then
local mp=uis:GetMouseLocation()
local absp=main.AbsolutePosition;local abss=main.AbsoluteSize
if mp.X>=absp.X and mp.X<=absp.X+abss.X and mp.Y>=absp.Y and mp.Y<=absp.Y+abss.Y then return end end
local mp=uis:GetMouseLocation()
local ray=camera:ViewportPointToRay(mp.X,mp.Y)
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={player.Character}
local result=workspace:Raycast(ray.Origin,ray.Direction*10000,params)
if result and result.Position then doTeleportToPoint(result.Position)
else doTeleportToPoint(ray.Origin+ray.Direction*5000) end end) end
local function stopTpClick()
tpClickOn=false
if tpClickConn then tpClickConn:Disconnect();tpClickConn=nil end
if tpClickIndicator then tpClickIndicator.Visible=false end end
makeToggle(armyPage,"📍 TP по клику",true,function(on) if on then startTpClick() else stopTpClick() end end)

-- ТП К ИГРОКУ
local tpGui,tpRows,tpConn=nil,{},nil
local function closeTP()
if tpConn then tpConn:Disconnect();tpConn=nil end
if tpGui then tpGui:Destroy();tpGui=nil end
tpRows={} end
local function tpTo(plr)
if not plr or not plr.Character then return end
local t=plr.Character:FindFirstChild("HumanoidRootPart")
local my=getHRP()
if t and my then my.CFrame=t.CFrame+Vector3.new(0,3,0) end end
local function openTP()
closeTP()
tpGui=Instance.new("ScreenGui")
tpGui.Name="TPMenu";tpGui.ResetOnSpawn=false;tpGui.Parent=gui.Parent
local f=Instance.new("Frame")
f.Size=UDim2.new(0,360,0,500);f.Position=UDim2.new(0.5,-180,0.5,-250)
f.BackgroundColor3=C.bg;f.BorderSizePixel=0;f.Active=true;f.Parent=tpGui
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local s=Instance.new("UIStroke",f);s.Color=C.accentDk;s.Thickness=1
local t=Instance.new("TextLabel")
t.Size=UDim2.new(1,0,0,35);t.Text="🎯 ТП К ИГРОКУ"
t.TextColor3=Color3.fromRGB(240,240,245);t.BackgroundColor3=C.topbar
t.Font=Enum.Font.GothamBold;t.TextSize=13;t.BorderSizePixel=0;t.Parent=f;t.Active=true
Instance.new("UICorner",t).CornerRadius=UDim.new(0,8)
local xb=Instance.new("TextButton")
xb.Size=UDim2.new(0,28,0,28);xb.Position=UDim2.new(1,-33,0,3);xb.Text="✕"
xb.TextColor3=C.textDim;xb.BackgroundColor3=C.red;xb.Font=Enum.Font.GothamBold
xb.TextSize=14;xb.BorderSizePixel=0;xb.ZIndex=10;xb.Parent=f
Instance.new("UICorner",xb).CornerRadius=UDim.new(0,5)
xb.MouseButton1Click:Connect(closeTP)
makeDraggable(f, t)
local searchBox=Instance.new("TextBox")
searchBox.Size=UDim2.new(0.92,0,0,32);searchBox.Position=UDim2.new(0.04,0,0.09,0)
searchBox.PlaceholderText="🔍 Поиск...";searchBox.Text=""
searchBox.TextColor3=C.text;searchBox.BackgroundColor3=C.row
searchBox.PlaceholderColor3=C.textDim;searchBox.Font=Enum.Font.GothamMedium
searchBox.TextSize=12;searchBox.BorderSizePixel=0;searchBox.ClearTextOnFocus=false;searchBox.Parent=f
Instance.new("UICorner",searchBox).CornerRadius=UDim.new(0,6)
local sb=Instance.new("ScrollingFrame")
sb.Size=UDim2.new(0.92,0,0.78,0);sb.Position=UDim2.new(0.04,0,0.19,0)
sb.BackgroundTransparency=1;sb.CanvasSize=UDim2.new(0,0,0,0)
sb.ScrollBarThickness=6;sb.ScrollBarImageColor3=C.accent;sb.Parent=f
Instance.new("UIListLayout",sb).Padding=UDim.new(0,6)
tpRows={}
local function refresh(filter)
filter=(filter or ""):lower()
for _,r in ipairs(tpRows) do pcall(function() r.btn:Destroy() end) end
tpRows={}
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=player and (filter=="" or p.Name:lower():find(filter,1,true)) then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-8,0,52);b.Text="";b.BackgroundColor3=C.row
b.BorderSizePixel=0;b.AutoButtonColor=false;b.Parent=sb
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local nameL=Instance.new("TextLabel")
nameL.Size=UDim2.new(1,-14,0,18);nameL.Position=UDim2.new(0,10,0,4)
nameL.BackgroundTransparency=1;nameL.Text="👤 "..p.Name
nameL.TextColor3=Color3.fromRGB(240,240,245);nameL.Font=Enum.Font.GothamBold
nameL.TextSize=12;nameL.TextXAlignment=Enum.TextXAlignment.Left;nameL.Parent=b
local statusL=Instance.new("TextLabel")
statusL.Size=UDim2.new(0.55,-10,0,14);statusL.Position=UDim2.new(0,10,0,26)
statusL.BackgroundTransparency=1;statusL.Text="🟢 Жив"
statusL.TextColor3=Color3.fromRGB(100,255,100);statusL.Font=Enum.Font.GothamSemibold
statusL.TextSize=10;statusL.TextXAlignment=Enum.TextXAlignment.Left;statusL.Parent=b
local distL=Instance.new("TextLabel")
distL.Size=UDim2.new(0.45,-10,0,14);distL.Position=UDim2.new(0.55,0,0,26)
distL.BackgroundTransparency=1;distL.Text="📏 — м"
distL.TextColor3=C.textDim;distL.Font=Enum.Font.GothamBold
distL.TextSize=10;distL.TextXAlignment=Enum.TextXAlignment.Right;distL.Parent=b
b.MouseButton1Click:Connect(function() tpTo(p);closeTP() end)
table.insert(tpRows,{btn=b,plr=p,statusL=statusL,distL=distL}) end end
task.wait(0.05)
local h=0
for _,c in ipairs(sb:GetChildren()) do if c:IsA("TextButton") then h=h+c.Size.Y.Offset+6 end end
sb.CanvasSize=UDim2.new(0,0,0,h+20) end
tpConn=runService.RenderStepped:Connect(function()
if not tpGui then return end
local myHRP=getHRP()
for _,r in ipairs(tpRows) do
if r.btn.Parent and r.plr and r.plr.Parent then
local char=r.plr.Character
local hum=char and char:FindFirstChildOfClass("Humanoid")
local hrp=char and char:FindFirstChild("HumanoidRootPart")
if char and hum and hum.Health>0 then
r.statusL.Text="🟢 ❤"..math.floor(hum.Health);r.statusL.TextColor3=Color3.fromRGB(100,255,100)
if myHRP and hrp then
local dist=(myHRP.Position-hrp.Position).Magnitude
r.distL.Text=string.format("📏%.0fм",dist)
if dist<30 then r.distL.TextColor3=Color3.fromRGB(255,80,80)
elseif dist<100 then r.distL.TextColor3=Color3.fromRGB(255,200,50)
else r.distL.TextColor3=Color3.fromRGB(100,200,255) end end
elseif char and hum and hum.Health<=0 then
r.statusL.Text="🔴 Мёртв";r.statusL.TextColor3=Color3.fromRGB(255,80,80)
r.distL.Text="📏 — м";r.distL.TextColor3=C.textDim
else r.statusL.Text="⚫ Нет персонажа";r.statusL.TextColor3=C.textDim end end end end)
searchBox:GetPropertyChangedSignal("Text"):Connect(function() refresh(searchBox.Text) end)
refresh("") end
makeToggle(armyPage,"🎯 ТП к игроку",false,function(on) if on then openTP() else closeTP() end end)

-- СПЕКТАТОР
local specGui,specRows=nil,{}
local specOriginalSubject,specOriginalType=nil,nil
local function restoreMove()
local h=getHum()
if h then pcall(function() h.WalkSpeed=16;h.JumpPower=50;h.UseJumpPower=true;h.PlatformStand=false end) end end
stopSpectate=function()
if specOriginalSubject then pcall(function() camera.CameraSubject=specOriginalSubject end)
elseif player.Character then
local h=player.Character:FindFirstChildOfClass("Humanoid")
if h then camera.CameraSubject=h end end
if specOriginalType then pcall(function() camera.CameraType=specOriginalType end) end
restoreMove();task.delay(0.1,restoreMove);task.delay(0.3,restoreMove)
specSelected=nil end
local function startSpectate(plr)
if not plr or not plr.Character then return end
local hum=plr.Character:FindFirstChildOfClass("Humanoid")
if not hum then return end
if not specOriginalSubject then
specOriginalSubject=camera.CameraSubject
specOriginalType=camera.CameraType end
local myHum=getHum()
if myHum then myHum.WalkSpeed=0;myHum.JumpPower=0 end
camera.CameraSubject=hum
camera.CameraType=Enum.CameraType.Custom
specSelected=plr end
local function closeSpecWin()
if stopSpectate then stopSpectate() end
specOriginalSubject=nil;specOriginalType=nil
if specGui then specGui:Destroy();specGui=nil end
specRows={} end
local function openSpecWin()
closeSpecWin()
specGui=Instance.new("ScreenGui")
specGui.Name="SpectateMenu";specGui.ResetOnSpawn=false;specGui.Parent=gui.Parent
local f=Instance.new("Frame")
f.Size=UDim2.new(0,340,0,700);f.Position=UDim2.new(0.5,-170,0.5,-350)
f.BackgroundColor3=C.bg;f.BorderSizePixel=0;f.Active=true;f.Parent=specGui
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local s=Instance.new("UIStroke",f);s.Color=C.accentDk;s.Thickness=1
local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,0,0,35);title.Text="👁️ СПЕКТАТОР (тяни за шапку)"
title.TextColor3=Color3.fromRGB(240,240,245);title.BackgroundColor3=C.topbar
title.Font=Enum.Font.GothamBold;title.TextSize=13;title.BorderSizePixel=0;title.Parent=f;title.Active=true
Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)
local xb=Instance.new("TextButton")
xb.Size=UDim2.new(0,28,0,28);xb.Position=UDim2.new(1,-33,0,3);xb.Text="✕"
xb.TextColor3=C.textDim;xb.BackgroundColor3=C.red;xb.Font=Enum.Font.GothamBold
xb.TextSize=14;xb.BorderSizePixel=0;xb.ZIndex=10;xb.Parent=f
Instance.new("UICorner",xb).CornerRadius=UDim.new(0,5)
xb.MouseButton1Click:Connect(closeSpecWin)
makeDraggable(f, title)

local myFactionLbl=Instance.new("TextLabel")
myFactionLbl.Size=UDim2.new(0.92,0,0,22);myFactionLbl.Position=UDim2.new(0.04,0,0.055,0)
myFactionLbl.BackgroundTransparency=1
myFactionLbl.Text="👤 Ваша фракция: —"
myFactionLbl.TextColor3=Color3.fromRGB(255,200,50)
myFactionLbl.Font=Enum.Font.GothamBold
myFactionLbl.TextSize=12
myFactionLbl.TextXAlignment=Enum.TextXAlignment.Left
myFactionLbl.Parent=f

local meBtn=Instance.new("TextButton")
meBtn.Size=UDim2.new(0.92,0,0,28);meBtn.Position=UDim2.new(0.04,0,0.105,0)
meBtn.Text="🔄 ВЕРНУТЬСЯ К СЕБЕ";meBtn.TextColor3=C.text
meBtn.BackgroundColor3=Color3.fromRGB(100,180,100);meBtn.Font=Enum.Font.GothamBold
meBtn.TextSize=11;meBtn.BorderSizePixel=0;meBtn.Parent=f
Instance.new("UICorner",meBtn).CornerRadius=UDim.new(0,5)
meBtn.MouseButton1Click:Connect(function() if stopSpectate then stopSpectate() end end)

local sb=Instance.new("ScrollingFrame")
sb.Size=UDim2.new(0.92,0,0,360);sb.Position=UDim2.new(0.04,0,0.16,0)
sb.BackgroundTransparency=1;sb.CanvasSize=UDim2.new(0,0,0,0)
sb.ScrollBarThickness=6;sb.ScrollBarImageColor3=C.accent;sb.Parent=f
Instance.new("UIListLayout",sb).Padding=UDim.new(0,6)

local facSectionLbl=Instance.new("TextLabel")
facSectionLbl.Size=UDim2.new(0.92,0,0,20);facSectionLbl.Position=UDim2.new(0.04,0,0.685,0)
facSectionLbl.BackgroundTransparency=1
facSectionLbl.Text="🎖 СОСТОЯЩИЕ В ВАШЕЙ ФРАКЦИИ"
facSectionLbl.TextColor3=C.badgeText
facSectionLbl.Font=Enum.Font.GothamBold
facSectionLbl.TextSize=11
facSectionLbl.TextXAlignment=Enum.TextXAlignment.Left
facSectionLbl.Parent=f

local facCountLbl=Instance.new("TextLabel")
facCountLbl.Size=UDim2.new(0.92,0,0,16);facCountLbl.Position=UDim2.new(0.04,0,0.715,0)
facCountLbl.BackgroundTransparency=1
facCountLbl.Text="🎖 —: 0 чел."
facCountLbl.TextColor3=Color3.fromRGB(255,200,50)
facCountLbl.Font=Enum.Font.GothamBold
facCountLbl.TextSize=11
facCountLbl.TextXAlignment=Enum.TextXAlignment.Left
facCountLbl.Parent=f

local facSb=Instance.new("ScrollingFrame")
facSb.Size=UDim2.new(0.92,0,0,135);facSb.Position=UDim2.new(0.04,0,0.76,0)
facSb.BackgroundTransparency=1;facSb.CanvasSize=UDim2.new(0,0,0,0)
facSb.ScrollBarThickness=4;facSb.ScrollBarImageColor3=C.accent;facSb.Parent=f
Instance.new("UIListLayout",facSb).Padding=UDim.new(0,4)

local facRows={}

local function refreshFacSection()
for _,r in ipairs(facRows) do pcall(function() r:Destroy() end) end
facRows={}
if not player.Team then
facCountLbl.Text="🎖 Вы без фракции"
facCountLbl.TextColor3=Color3.fromRGB(140,140,150)
local empty=Instance.new("TextLabel")
empty.Size=UDim2.new(1,-8,0,30);empty.BackgroundTransparency=1
empty.Text="— нет фракции —"
empty.TextColor3=C.textDim;empty.Font=Enum.Font.GothamMedium
empty.TextSize=11;empty.Parent=facSb
table.insert(facRows,empty)
facSb.CanvasSize=UDim2.new(0,0,0,40)
return end
local myTeam=player.Team
local col=getFactionColor(player)
local mates={}
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=player and p.Team==myTeam then table.insert(mates,p) end end
facCountLbl.Text="🎖 "..myTeam.Name..": "..#mates.." чел."
facCountLbl.TextColor3=col
if #mates==0 then
local empty=Instance.new("TextLabel")
empty.Size=UDim2.new(1,-8,0,30);empty.BackgroundTransparency=1
empty.Text="— в вашей фракции больше никого —"
empty.TextColor3=C.textDim;empty.Font=Enum.Font.GothamMedium
empty.TextSize=11;empty.Parent=facSb
table.insert(facRows,empty)
else
for _,p in ipairs(mates) do
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-8,0,30);b.Text=""
b.BackgroundColor3=specSelected==p and Color3.fromRGB(45,35,70) or C.row
b.BorderSizePixel=0;b.AutoButtonColor=false;b.Parent=facSb
Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)
local nl=Instance.new("TextLabel")
nl.Size=UDim2.new(1,-10,0,14);nl.Position=UDim2.new(0,8,0,2)
nl.Text="👤 "..p.Name
nl.TextColor3=Color3.fromRGB(240,240,245)
nl.BackgroundTransparency=1;nl.Font=Enum.Font.GothamBold
nl.TextSize=11;nl.TextXAlignment=Enum.TextXAlignment.Left;nl.Parent=b
local sl=Instance.new("TextLabel")
sl.Size=UDim2.new(1,-10,0,12);sl.Position=UDim2.new(0,8,0,16)
local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then
sl.Text="🟢 "..math.floor(h.Health).." HP"
sl.TextColor3=Color3.fromRGB(150,200,150)
else
sl.Text="🔴 Мёртв"
sl.TextColor3=Color3.fromRGB(200,120,120) end
sl.BackgroundTransparency=1;sl.Font=Enum.Font.GothamSemibold
sl.TextSize=9;sl.TextXAlignment=Enum.TextXAlignment.Left;sl.Parent=b
b.MouseButton1Click:Connect(function()
startSpectate(p);refreshFacSection() end)
table.insert(facRows,b) end end
task.wait(0.05)
local h=0
for _,c in ipairs(facSb:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then h=h+c.Size.Y.Offset+4 end end
facSb.CanvasSize=UDim2.new(0,0,0,h+15) end

local function refreshList()
for _,r in ipairs(specRows) do pcall(function() r:Destroy() end) end
specRows={}
if player.Team then
local col=getFactionColor(player)
myFactionLbl.Text="👤 Ваша фракция: "..player.Team.Name
myFactionLbl.TextColor3=col
else
myFactionLbl.Text="👤 Ваша фракция: без фракции"
myFactionLbl.TextColor3=Color3.fromRGB(140,140,150) end
for _,p in ipairs(game.Players:GetPlayers()) do
if p~=player then
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-8,0,44);b.Text=""
b.BackgroundColor3=specSelected==p and Color3.fromRGB(45,35,70) or C.row
b.BorderSizePixel=0;b.AutoButtonColor=false;b.Parent=sb
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local nl=Instance.new("TextLabel")
nl.Size=UDim2.new(1,-10,0,18);nl.Position=UDim2.new(0,8,0,3)
nl.Text="👤 "..p.Name
nl.TextColor3=Color3.fromRGB(240,240,245)
nl.BackgroundTransparency=1;nl.Font=Enum.Font.GothamBold
nl.TextSize=12;nl.TextXAlignment=Enum.TextXAlignment.Left;nl.Parent=b
local fac=Instance.new("TextLabel")
fac.Size=UDim2.new(0.55,-10,0,14);fac.Position=UDim2.new(0,8,0,22)
local factionName=p.Team and p.Team.Name or "Без фракции"
local factionColor=getFactionColor(p)
fac.Text="🎖 "..factionName
fac.TextColor3=factionColor
fac.BackgroundTransparency=1;fac.Font=Enum.Font.GothamSemibold
fac.TextSize=10;fac.TextXAlignment=Enum.TextXAlignment.Left
fac.Parent=b
local sl=Instance.new("TextLabel")
sl.Size=UDim2.new(0.45,-10,0,14);sl.Position=UDim2.new(0.55,0,0,22)
local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then
sl.Text="🟢 В игре"
sl.TextColor3=Color3.fromRGB(150,200,150)
else
sl.Text="🔴 Мёртв"
sl.TextColor3=Color3.fromRGB(200,120,120) end
sl.BackgroundTransparency=1;sl.Font=Enum.Font.GothamSemibold
sl.TextSize=10;sl.TextXAlignment=Enum.TextXAlignment.Right
sl.Parent=b
b.MouseButton1Click:Connect(function()
startSpectate(p);refreshList();refreshFacSection() end)
table.insert(specRows,b) end end
task.wait(0.05)
local h=0
for _,c in ipairs(sb:GetChildren()) do if c:IsA("TextButton") then h=h+c.Size.Y.Offset+6 end end
sb.CanvasSize=UDim2.new(0,0,0,h+20) end

refreshList()
refreshFacSection()
task.spawn(function()
while specGui do task.wait(1); if specGui then refreshList();refreshFacSection() end end
end) end
makeToggle(armyPage,"👁️ Спектатор",false,function(on) if on then openSpecWin() else closeSpecWin() end end)

-- ПВП
makeSectionLabel(pvpPage,"🔫 ОРУЖИЕ")
local soundReplaceOn=false
local soundReplaceConn=nil
local NEW_SHOOT_ID="rbxassetid://109502137778920"
local function replaceSounds(tool)
for _,s in ipairs(tool:GetDescendants()) do
if s:IsA("Sound") then
local n=s.Name:lower()
if n:find("shoot") or n:find("fire") or n:find("shot") or n:find("gun") or n:find("muzzle") or n:find("bang") then
pcall(function()
if s.SoundId~=NEW_SHOOT_ID then s.SoundId=NEW_SHOOT_ID;s.Volume=2 end end) end end end end
local function scanSounds()
local ch=player.Character
if ch then for _,t in ipairs(ch:GetChildren()) do if t:IsA("Tool") then replaceSounds(t) end end end
local bp=player:FindFirstChild("Backpack")
if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then replaceSounds(t) end end end end
makeToggle(pvpPage,"🔊 Свой звук выстрела",true,function(on)
soundReplaceOn=on
if on then scanSounds()
if soundReplaceConn then soundReplaceConn:Disconnect() end
soundReplaceConn=runService.Heartbeat:Connect(function() if soundReplaceOn then scanSounds() end end)
showNotif("🔊 Звуки заменены",C.accent)
else if soundReplaceConn then soundReplaceConn:Disconnect();soundReplaceConn=nil end
showNotif("🔊 Звуки выкл",Color3.fromRGB(255,200,80)) end end)

makeToggle(pvpPage,"🔫 Оружие без отдачи",true,function(on) if on then startNoRecoil() else stopNoRecoil() end end)

local noWeaponRecoilOn,weaponRecoilConn=false,nil
makeToggle(pvpPage,"🎯 Убрать отдачу",true,function(on)
noWeaponRecoilOn=on
if on then
if weaponRecoilConn then weaponRecoilConn:Disconnect() end
weaponRecoilConn=runService.Heartbeat:Connect(function()
if not noWeaponRecoilOn then return end
local ch=player.Character;if not ch then return end
for _,tool in ipairs(ch:GetChildren()) do
if tool:IsA("Tool") then
for _,obj in ipairs(tool:GetDescendants()) do
if obj:IsA("NumberValue") or obj:IsA("IntValue") then
local n=obj.Name:lower()
if n:find("recoil") or n:find("kick") or n:find("spread") then
if obj.Value~=0 then obj.Value=0 end end end end end end end)
else if weaponRecoilConn then weaponRecoilConn:Disconnect();weaponRecoilConn=nil end end end)

-- TELEPORTY
local function teleportTo(x,y,z,label)
local hrp=getHRP()
if not hrp then showNotif("❌ Нет персонажа",Color3.fromRGB(255,100,100));return end
hrp.CFrame=CFrame.new(Vector3.new(x,y,z))
showNotif("📍 ТП: "..(label or "точка"),Color3.fromRGB(100,255,100)) end
makeSectionLabel(tpPage,"🏛 ГОС. СТРУКТУРЫ")
makeButton(tpPage,"🪖 Армия",Color3.fromRGB(70,100,60),function() teleportTo(256.9,4.2,83.3,"Армия") end)
makeButton(tpPage,"👮 МВД",Color3.fromRGB(60,80,130),function() teleportTo(1861.1,5.0,-61.0,"МВД") end)
makeButton(tpPage,"🕵️ ФСБ",Color3.fromRGB(90,60,60),function() teleportTo(2201.7,1.0,-601.0,"ФСБ") end)
makeButton(tpPage,"🏢 КБ",Color3.fromRGB(70,70,90),function() teleportTo(805.1,5.0,-902.6,"КБ") end)
makeButton(tpPage,"⚖️ Прокуратура",Color3.fromRGB(80,90,120),function() teleportTo(2585.4,1.1,-1025.0,"Прокуратура") end)
makeSectionLabel(tpPage,"🛒 ТОРГОВЦЫ")
makeButton(tpPage,"🔫 Торговец",Color3.fromRGB(110,80,40),function() teleportTo(840.5,41.0,-118.7,"Торговец") end)
makeSectionLabel(tpPage,"⚔️ НЕЛЕГАЛЬНЫЕ")
makeButton(tpPage,"🎯 Наём",Color3.fromRGB(130,60,60),function() teleportTo(1543.9,3.0,770.3,"Наём") end)
makeButton(tpPage,"💼 Брокеры",Color3.fromRGB(100,70,130),function() teleportTo(1661.7,25.0,-1937.1,"Брокеры") end)
makeSectionLabel(tpPage,"🌪️ ИВЕНТЫ")
makeButton(tpPage,"🌪️ ШТОРМ",Color3.fromRGB(70,90,120),function() teleportTo(441.3,9.0,997.0,"Шторм") end)

-- SETTINGS
local function makeSettingRow(text)
local row=Instance.new("Frame")
row.Size=UDim2.new(1,-12,0,42);row.BackgroundColor3=C.row
row.BorderSizePixel=0;row.Parent=settingsPage
Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
local label=Instance.new("TextLabel")
label.Size=UDim2.new(0.55,0,1,0);label.Position=UDim2.new(0,26,0,0)
label.Text=text;label.TextColor3=C.text;label.BackgroundTransparency=1
label.Font=Enum.Font.GothamMedium;label.TextSize=12
label.TextXAlignment=Enum.TextXAlignment.Left;label.Parent=row
return row end
makeSectionLabel(settingsPage,"🎨 ЦВЕТ АКЦЕНТА")
local colorsRow=Instance.new("Frame")
colorsRow.Size=UDim2.new(1,-12,0,46);colorsRow.BackgroundColor3=C.row
colorsRow.BorderSizePixel=0;colorsRow.Parent=settingsPage
Instance.new("UICorner",colorsRow).CornerRadius=UDim.new(0,6)
local presets={Color3.fromRGB(130,70,220),Color3.fromRGB(60,120,220),Color3.fromRGB(60,180,100),Color3.fromRGB(200,50,60),Color3.fromRGB(230,140,40),Color3.fromRGB(220,80,180)}
local function applyAccent(newColor)
C.accent=newColor
C.accentDk=Color3.new(newColor.R*0.65,newColor.G*0.65,newColor.B*0.65)
mStroke.Color=C.accentDk
for _,p in ipairs({armyPage,tpPage,aimbotPage,pvpPage,settingsPage}) do p.ScrollBarImageColor3=C.accent end
if tabArmy.BackgroundColor3~=C.sidebar then tabArmy.BackgroundColor3=C.accentDk end
if tabTP.BackgroundColor3~=C.sidebar then tabTP.BackgroundColor3=C.accentDk end
if tabAimbot.BackgroundColor3~=C.sidebar then tabAimbot.BackgroundColor3=C.accentDk end
if tabPvP.BackgroundColor3~=C.sidebar then tabPvP.BackgroundColor3=C.accentDk end
if tabSettings.BackgroundColor3~=C.sidebar then tabSettings.BackgroundColor3=C.accentDk end
for _,td in ipairs(togglesData) do
if td.api.get() and td.tBg and td.dot then td.tBg.BackgroundColor3=C.accent;td.dot.BackgroundColor3=C.accent end end end
for i,col in ipairs(presets) do
local cBtn=Instance.new("TextButton")
cBtn.Size=UDim2.new(0,30,0,30);cBtn.Position=UDim2.new(0,8+(i-1)*36,0.5,-15)
cBtn.Text="";cBtn.BackgroundColor3=col;cBtn.BorderSizePixel=0;cBtn.Parent=colorsRow
Instance.new("UICorner",cBtn).CornerRadius=UDim.new(1,0)
local stroke=Instance.new("UIStroke",cBtn);stroke.Color=Color3.fromRGB(60,60,70);stroke.Thickness=1
cBtn.MouseButton1Click:Connect(function() applyAccent(col) end) end

makeSectionLabel(settingsPage,"📐 РАЗМЕР ОКНА")
local sizeRow = makeSettingRow("Ширина / Высота")
local wBox = Instance.new("TextBox")
wBox.Size = UDim2.new(0,46,0,26);wBox.Position = UDim2.new(1,-170,0.5,-13)
wBox.Text = "540";wBox.TextColor3 = C.text;wBox.BackgroundColor3 = C.badge
wBox.Font = Enum.Font.GothamSemibold;wBox.TextSize = 12;wBox.BorderSizePixel = 0
wBox.ClearTextOnFocus = false;wBox.Parent = sizeRow
Instance.new("UICorner", wBox).CornerRadius = UDim.new(0,4)
local hBox = Instance.new("TextBox")
hBox.Size = UDim2.new(0,46,0,26);hBox.Position = UDim2.new(1,-118,0.5,-13)
hBox.Text = "460";hBox.TextColor3 = C.text;hBox.BackgroundColor3 = C.badge
hBox.Font = Enum.Font.GothamSemibold;hBox.TextSize = 12;hBox.BorderSizePixel = 0
hBox.ClearTextOnFocus = false;hBox.Parent = sizeRow
Instance.new("UICorner", hBox).CornerRadius = UDim.new(0,4)
local applySizeBtn = Instance.new("TextButton")
applySizeBtn.Size = UDim2.new(0,60,0,26);applySizeBtn.Position = UDim2.new(1,-66,0.5,-13)
applySizeBtn.Text = "OK";applySizeBtn.TextColor3 = C.text
applySizeBtn.BackgroundColor3 = C.accentDk;applySizeBtn.Font = Enum.Font.GothamBold
applySizeBtn.TextSize = 12;applySizeBtn.BorderSizePixel = 0;applySizeBtn.Parent = sizeRow
Instance.new("UICorner", applySizeBtn).CornerRadius = UDim.new(0,4)
applySizeBtn.MouseButton1Click:Connect(function()
    local w = tonumber(wBox.Text)
    local h = tonumber(hBox.Text)
    if w and h then
        w = math.clamp(math.floor(w), 300, 900)
        h = math.clamp(math.floor(h), 200, 700)
        main.Size = UDim2.new(0, w, 0, h)
        wBox.Text = tostring(w)
        hBox.Text = tostring(h)
    end
end)

makeSectionLabel(settingsPage,"⌨️ КНОПКА МЕНЮ")
local keyRow=makeSettingRow("Текущая клавиша")
local keyShow=Instance.new("TextLabel")
keyShow.Size=UDim2.new(0,80,0,26);keyShow.Position=UDim2.new(1,-168,0.5,-13)
keyShow.Text="F4";keyShow.TextColor3=C.badgeText;keyShow.BackgroundColor3=C.badge
keyShow.Font=Enum.Font.GothamBold;keyShow.TextSize=11;keyShow.BorderSizePixel=0;keyShow.Parent=keyRow
Instance.new("UICorner",keyShow).CornerRadius=UDim.new(0,4)
local assignKeyBtn=Instance.new("TextButton")
assignKeyBtn.Size=UDim2.new(0,90,0,26);assignKeyBtn.Position=UDim2.new(1,-80,0.5,-13)
assignKeyBtn.Text="Назначить";assignKeyBtn.TextColor3=C.text
assignKeyBtn.BackgroundColor3=C.accentDk;assignKeyBtn.Font=Enum.Font.GothamBold
assignKeyBtn.TextSize=11;assignKeyBtn.BorderSizePixel=0;assignKeyBtn.Parent=keyRow
Instance.new("UICorner",assignKeyBtn).CornerRadius=UDim.new(0,4)
assignKeyBtn.MouseButton1Click:Connect(function()
waitingForMenuKey=true;assignKeyBtn.Text="Жми..." end)
setMenuKeyDisplay=function(k) keyShow.Text=tostring(k):gsub("Enum.KeyCode.","") end
uis.InputBegan:Connect(function(i,gpe)
if gpe then return end
if i.UserInputType~=Enum.UserInputType.Keyboard then return end
if i.KeyCode==Enum.KeyCode.Unknown then return end
if waitingForMenuKey then
toggleKey=i.KeyCode;waitingForMenuKey=false
if setMenuKeyDisplay then setMenuKeyDisplay(i.KeyCode) end
assignKeyBtn.Text="Назначить";return end
if waitingHotkeyToggle then
if i.KeyCode==Enum.KeyCode.Escape then
local badge=waitingHotkeyToggle.getBadge()
if badge then renderBadge(badge,waitingHotkeyToggle.getHotkey()) end
waitingHotkeyToggle=nil;return end
local oldKey=waitingHotkeyToggle.getHotkey()
if oldKey and hotkeyRegistry[oldKey]==waitingHotkeyToggle then hotkeyRegistry[oldKey]=nil end
local conflicting=hotkeyRegistry[i.KeyCode]
if conflicting and conflicting~=waitingHotkeyToggle then conflicting.clearHotkey() end
waitingHotkeyToggle.setHotkeyInternal(i.KeyCode)
hotkeyRegistry[i.KeyCode]=waitingHotkeyToggle
local badge=waitingHotkeyToggle.getBadge()
if badge then renderBadge(badge,i.KeyCode) end
waitingHotkeyToggle=nil;return end
if uis:GetFocusedTextBox() then return end
local api=hotkeyRegistry[i.KeyCode]
if api then api.set(not api.get()) end end)
uis.InputBegan:Connect(function(i,gpe)
if gpe then return end
if waitingForMenuKey then return end
if uis:GetFocusedTextBox() then return end
if i.KeyCode==toggleKey then main.Visible=not main.Visible end end)
task.spawn(function()
task.wait(0.1)
for _,page in ipairs({armyPage,tpPage,aimbotPage,pvpPage,settingsPage}) do
local h=0
for _,c in ipairs(page:GetChildren()) do
if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("TextButton") or c:IsA("TextBox") then
h=h+c.Size.Y.Offset+6 end end
page.CanvasSize=UDim2.new(0,0,0,h+20) end end)
local minimized=false
local origSize=main.Size
minBtn.MouseButton1Click:Connect(function()
minimized=not minimized
if minimized then
origSize=main.Size;sidebar.Visible=false;content.Visible=false
main.Size=UDim2.new(0,540,0,40)
else sidebar.Visible=true;content.Visible=true;main.Size=origSize end end)
closeBtn.MouseButton1Click:Connect(function()
stopESP();stopAimbot();stopFly();stopGhost();stopNC();stopVeh();stopNoRecoil();stopTpClick()
closeSpecWin();closeTP()
if fbConn then fbConn:Disconnect();fbConn=nil end
if soundReplaceConn then soundReplaceConn:Disconnect();soundReplaceConn=nil end
fullbrightOn=false;restoreFB()
setSpeed(defaultSpeed);jumpOn=false
gui:Destroy() end)
print("✅ Eclipse Menu загружен. F4 — меню.")
