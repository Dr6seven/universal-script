-- ===== UNIVERSAL [BETA] by D33RZN =====
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

if getgenv().UniversalUI then pcall(function() getgenv().UniversalUI:Destroy() end) end

-- ===== WARNA =====
local C_BG   = Color3.fromRGB(18, 18, 22)
local C_BAR  = Color3.fromRGB(26, 26, 32)
local C_ROW  = Color3.fromRGB(34, 34, 42)
local C_OFF  = Color3.fromRGB(70, 70, 82)
local C_ON   = Color3.fromRGB(60, 190, 100)
local C_GRAY = Color3.fromRGB(150, 150, 160)

local State = {
    Fly = false, ESP = false,
    FlySpeed = 50
}

local function corner(inst, r) Instance.new("UICorner", inst).CornerRadius = UDim.new(0, r) end
local order = 0
local function nextOrder() order += 1; return order end

-- ===== ROOT GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "UniversalUI"
gui.ResetOnSpawn = false
local ok = pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
if not ok or not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end
getgenv().UniversalUI = gui

local WIN_W, WIN_H = 430, 270
local main = Instance.new("Frame")
main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
main.Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2)
main.BackgroundColor3 = C_BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
corner(main, 12)
Instance.new("UIStroke", main).Color = Color3.fromRGB(60, 60, 72)

-- ===== TITLE BAR =====
local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, 0, 0, 32)
bar.BackgroundColor3 = C_BAR
bar.BorderSizePixel = 0
bar.Parent = main

local titleBox = Instance.new("Frame")
titleBox.Size = UDim2.new(1, -220, 1, 0)
titleBox.Position = UDim2.new(0, 12, 0, 0)
titleBox.BackgroundTransparency = 1
titleBox.Parent = bar
local tbl = Instance.new("UIListLayout", titleBox)
tbl.FillDirection = Enum.FillDirection.Horizontal
tbl.VerticalAlignment = Enum.VerticalAlignment.Center
tbl.SortOrder = Enum.SortOrder.LayoutOrder
tbl.Padding = UDim.new(0, 5)

-- Judul Utama
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 0, 0, 16)
title.AutomaticSize = Enum.AutomaticSize.X
title.BackgroundTransparency = 1
title.Text = "UNIVERSAL [BETA]"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.LayoutOrder = 1
title.Parent = titleBox

-- Credit
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(0, 0, 0, 10)
credit.AutomaticSize = Enum.AutomaticSize.X
credit.BackgroundTransparency = 1
credit.Text = "by D33RZN"
credit.TextColor3 = C_GRAY
credit.Font = Enum.Font.Gotham
credit.TextSize = 7
credit.LayoutOrder = 2
credit.Parent = titleBox

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 22)
closeBtn.Position = UDim2.new(1, -32, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = bar
corner(closeBtn, 6)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Drag UI
local dragging, startPos, startPoint, dragInput
bar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging, dragInput = true, i
        startPoint, startPos = i.Position, main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i == dragInput or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - startPoint
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i) if i == dragInput then dragging = false end end)

-- Body & Sidebar
local body = Instance.new("Frame")
body.Size = UDim2.new(1, 0, 1, -32)
body.Position = UDim2.new(0, 0, 0, 32)
body.BackgroundTransparency = 1
body.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 96, 1, 0)
sidebar.BackgroundColor3 = C_BAR
sidebar.BorderSizePixel = 0
sidebar.Parent = body

local tabList = Instance.new("Frame")
tabList.Size = UDim2.new(1, 0, 1, 0)
tabList.BackgroundTransparency = 1
tabList.Parent = sidebar
local tl = Instance.new("UIListLayout", tabList)
tl.Padding = UDim.new(0, 4)
local tp = Instance.new("UIPadding", tabList)
tp.PaddingTop = UDim.new(0, 8); tp.PaddingLeft = UDim.new(0, 6); tp.PaddingRight = UDim.new(0, 6)

local pages, tabs = {}, {}
local function newPage(name)
    local p = Instance.new("ScrollingFrame")
    p.Size = UDim2.new(1, -96, 1, 0)
    p.Position = UDim2.new(0, 96, 0, 0)
    p.BackgroundTransparency = 1
    p.BorderSizePixel = 0
    p.ScrollBarThickness = 4
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.CanvasSize = UDim2.new(0, 0, 0, 0)
    p.Visible = false
    p.Parent = body
    local l = Instance.new("UIListLayout", p)
    l.Padding = UDim.new(0, 6)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    local pad = Instance.new("UIPadding", p)
    pad.PaddingLeft = UDim.new(0, 8); pad.PaddingRight = UDim.new(0, 8); pad.PaddingTop = UDim.new(0, 8); pad.PaddingBottom = UDim.new(0, 8)
    pages[name] = p
    return p
end

local function setTab(name)
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, b in pairs(tabs) do
        b.BackgroundColor3 = (n == name) and C_ROW or C_BAR
        b.TextColor3 = (n == name) and Color3.new(1, 1, 1) or C_GRAY
    end
end

local function newTab(name, ord, icon)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 28)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.LayoutOrder = ord
    b.Parent = tabList
    corner(b, 8)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 28)
    local ic = Instance.new("TextLabel")
    ic.Size = UDim2.new(0, 24, 1, 0)
    ic.Position = UDim2.new(0, -26, 0, 0)
    ic.BackgroundTransparency = 1
    ic.Text = icon
    ic.TextSize = 15
    ic.Font = Enum.Font.GothamBold
    ic.TextColor3 = Color3.new(1, 1, 1)
    ic.Parent = b
    tabs[name] = b
    b.MouseButton1Click:Connect(function() setTab(name) end)
end

newPage("Main")
newPage("Misc")
newTab("Main", 1, "🦅")
newTab("Misc", 2, "👁")

-- ===== KOMPONEN =====
local function textBlock(parent, titleText, desc)
    local txt = Instance.new("Frame"); txt.Size = UDim2.new(1, -64, 0, 0); txt.AutomaticSize = Enum.AutomaticSize.Y
    txt.BackgroundTransparency = 1; txt.LayoutOrder = 1; txt.Position = UDim2.new(0, 10, 0, 0); txt.Parent = parent
    local l = Instance.new("UIListLayout", txt); l.Padding = UDim.new(0, 2)
    local t = Instance.new("TextLabel"); t.Size = UDim2.new(1, 0, 0, 16); t.BackgroundTransparency = 1
    t.Text = titleText; t.TextColor3 = Color3.new(1, 1, 1); t.Font = Enum.Font.GothamBold; t.TextSize = 12
    t.TextXAlignment = Enum.TextXAlignment.Left; t.LayoutOrder = 1; t.Parent = txt
    if desc then
        local d = Instance.new("TextLabel"); d.Size = UDim2.new(1, 0, 0, 0); d.AutomaticSize = Enum.AutomaticSize.Y
        d.BackgroundTransparency = 1; d.Text = desc; d.TextColor3 = C_GRAY; d.Font = Enum.Font.Gotham
        d.TextSize = 10; d.TextWrapped = true; d.TextXAlignment = Enum.TextXAlignment.Left; d.LayoutOrder = 2; d.Parent = txt
    end
end

local function switchRow(parent, text, desc, key)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 0); row.AutomaticSize = Enum.AutomaticSize.Y; row.BackgroundColor3 = C_ROW
    row.Text = ""; row.AutoButtonColor = false; row.LayoutOrder = nextOrder(); row.Parent = parent; corner(row, 8)
    Instance.new("UISizeConstraint", row).MinSize = Vector2.new(0, 38)
    textBlock(row, text, desc)
    local pill = Instance.new("Frame"); pill.Size = UDim2.new(0, 40, 0, 20); pill.Position = UDim2.new(1, -50, 0.5, -10)
    pill.Parent = row; corner(pill, 10)
    local knob = Instance.new("Frame"); knob.Size = UDim2.new(0, 16, 0, 16); knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = pill; corner(knob, 8)
    local function refresh(animate)
        local on = State[key]; local col = on and C_ON or C_OFF
        local pos = on and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
        if animate then
            TS:Create(pill, TweenInfo.new(0.15), { BackgroundColor3 = col }):Play()
            TS:Create(knob, TweenInfo.new(0.15), { Position = pos }):Play()
        else
            pill.BackgroundColor3 = col; knob.Position = pos
        end
    end
    row.MouseButton1Click:Connect(function() State[key] = not State[key]; refresh(true) end)
    refresh(false)
end

local function boxCard(page, order, titleText, desc)
    local card = Instance.new("Frame"); card.Size = UDim2.new(1, 0, 0, 0); card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = C_ROW; card.LayoutOrder = order; card.Parent = page; corner(card, 8)
    local cl = Instance.new("UIListLayout", card); cl.Padding = UDim.new(0, 4)
    local cp = Instance.new("UIPadding", card); cp.PaddingLeft = UDim.new(0, 10); cp.PaddingRight = UDim.new(0, 10); cp.PaddingBottom = UDim.new(0, 8)
    textBlock(card, titleText, desc)
    return card
end

local function newBox(parent, placeholder, order)
    local b = Instance.new("TextBox")
    b.Size = UDim2.new(1, 0, 0, 26); b.BackgroundColor3 = C_BG; b.PlaceholderText = placeholder
    b.PlaceholderColor3 = C_GRAY; b.Text = ""; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.Gotham
    b.TextSize = 11; b.ClearTextOnFocus = false; b.LayoutOrder = order; b.Parent = parent; corner(b, 6)
    return b
end

-- ===== HALAMAN MAIN (FLY) =====
local pMain = pages.Main
switchRow(pMain, "Fly", "Terbang bebas (W/A/S/D + Space/Ctrl).", "Fly")

do
    local card = boxCard(pMain, 2, "Fly Speed", "Ubah kecepatan terbang.")
    local box = newBox(card, "Default: 50", 2)
    box.Text = tostring(State.FlySpeed)
    box.FocusLost:Connect(function()
        local v = tonumber(box.Text)
        if v and v > 0 then State.FlySpeed = v else box.Text = tostring(State.FlySpeed) end
    end)
end

-- ===== HALAMAN MISC (ESP) =====
local pMisc = pages.Misc
switchRow(pMisc, "ESP Player", "Tampilkan nama, jarak, dan warna tembus tembok.", "ESP")

-- ===== LOGIKA FLY =====
local function getHRP() return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") end
local bodyVel, bodyGyro, flyConnection

local function stopFly()
    if bodyVel then bodyVel:Destroy() bodyVel = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
end

local function startFly()
    local hrp = getHRP()
    if not hrp then return end
    stopFly()
    
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVel.Velocity = Vector3.zero
    bodyVel.Parent = hrp
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.P = 1000
    bodyGyro.Parent = hrp
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not State.Fly then stopFly() return end
        if not hrp or not lp.Character then stopFly() return end
        
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.zero
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end
        
        bodyVel.Velocity = moveDir * State.FlySpeed
        bodyGyro.CFrame = cam.CFrame
    end)
end

local lastFly = false
RunService.Heartbeat:Connect(function()
    if State.Fly ~= lastFly then
        lastFly = State.Fly
        if State.Fly then startFly() else stopFly() end
    end
end)

lp.CharacterAdded:Connect(function()
    task.wait(1)
    if State.Fly then
        lastFly = false
        State.Fly = false
        stopFly()
    end
end)

-- ===== LOGIKA ESP =====
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP_Folder"
espFolder.Parent = gui

local espData = {} 

local function createESP(plr)
    local char = plr.Character
    if not char or char == lp.Character then return end

    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255, 50, 50)
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.FillTransparency = 0.5
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char

    local head = char:FindFirstChild("Head")
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = head

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.fromRGB(255, 50, 50)
    txt.TextStrokeTransparency = 0
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 14
    txt.Parent = bb

    espData[plr] = { hl = hl, bb = bb, txt = txt }
end

local function removeESP(plr)
    local data = espData[plr]
    if data then
        if data.hl then data.hl:Destroy() end
        if data.bb then data.bb:Destroy() end
        espData[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not gui.Parent then return end
    
    for plr, data in pairs(espData) do
        if not plr.Character or not plr.Character:FindFirstChild("Head") then
            removeESP(plr)
        else
            local myHRP = getHRP()
            local theirHRP = plr.Character:FindFirstChild("HumanoidRootPart")
            if myHRP and theirHRP then
                local dist = math.floor((myHRP.Position - theirHRP.Position).Magnitude)
                data.txt.Text = plr.DisplayName .. " [" .. dist .. "m]"
            end
        end
    end

    if State.ESP then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp and not espData[plr] and plr.Character then
                createESP(plr)
            end
        end
    else
        if next(espData) then
            for plr, _ in pairs(espData) do
                removeESP(plr)
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    removeESP(plr)
end)

setTab("Main")
print("✅ UNIVERSAL [BETA] by D33RZN Berhasil Dimuat!")
