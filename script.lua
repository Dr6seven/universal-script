-- UNIVERSAL SCRIPT V0.3 | by D33RZN
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

-- ===== PENGATURAN (ganti sesuai punyamu) =====
local ICON_BASE = "https://raw.githubusercontent.com/Dr6seven/universal-script/refs/heads/main/icon/"
local TFA_ICON_BASE = "https://raw.githubusercontent.com/Dr6seven/throwforanimals/refs/heads/main/icon/"
local DISCORD_LINK = "https://discord.gg/bVv8juvjj"
local OWNER_IDS = { [8925135775] = "Owner" }
local COUNTER_BASE = "https://abacus.jasoncameron.dev"
local COUNTER_NS = "universal-script-d33rzn"
local COUNTER_KEY = "users"
local SALT = "GTAVI-19NOVEMBER"

-- bersihkan versi lama
if getgenv().__TemplateConns then
    for _, c in ipairs(getgenv().__TemplateConns) do pcall(function() c:Disconnect() end) end
end
getgenv().__TemplateConns = {}
local conns = getgenv().__TemplateConns
local function track(c) conns[#conns + 1] = c; return c end
if getgenv().TemplateUI then pcall(function() getgenv().TemplateUI:Destroy() end) end
task.wait(0.3)

local C_BG   = Color3.fromRGB(18, 18, 22)
local C_BAR  = Color3.fromRGB(26, 26, 32)
local C_ROW  = Color3.fromRGB(34, 34, 42)
local C_OFF  = Color3.fromRGB(70, 70, 82)
local C_ON   = Color3.fromRGB(60, 190, 100)
local C_RED  = Color3.fromRGB(150, 55, 55)
local C_GRAY = Color3.fromRGB(150, 150, 160)
local C_GOOD = Color3.fromRGB(90, 200, 120)
local WHITE  = Color3.new(1, 1, 1)

-- nilai switch dan angka disimpan di sini: State.Fly, State.FlySpeed, dst
local State = {}
-- daftar elemen UI agar config bisa menyegarkan tampilan
local UI = { switch = {}, box = {}, dd = {} }

local function corner(inst, r) Instance.new("UICorner", inst).CornerRadius = UDim.new(0, r) end
local order = 0
local function nextOrder() order += 1; return order end

-- notifikasi kecil bawaan Roblox (dipakai untuk pesan Config)
local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "UNIVERSAL SCRIPT",
            Text = tostring(text),
            Duration = 3,
        })
    end)
end

local function lbl(parent, text, ts, bold, color, size, pos)
    local l = Instance.new("TextLabel")
    l.Size = size or UDim2.new(1, 0, 0, 16)
    if pos then l.Position = pos end
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or WHITE
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize = ts
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

-- ===== ROOT =====
local gui = Instance.new("ScreenGui")
gui.Name = "TemplateUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local ok = pcall(function() gui.Parent = (gethui and gethui()) or CoreGui end)
if not ok or not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end
getgenv().TemplateUI = gui

local WIN_W, WIN_H = 470, 300
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

local title = lbl(titleBox, "UNIVERSAL SCRIPT V0.3", 12, true, WHITE, UDim2.new(0, 0, 0, 16))
title.AutomaticSize = Enum.AutomaticSize.X
title.LayoutOrder = 1
local credit = lbl(titleBox, "by D33RZN", 7, false, C_GRAY, UDim2.new(0, 0, 0, 10))
credit.AutomaticSize = Enum.AutomaticSize.X
credit.LayoutOrder = 2

local search = Instance.new("TextBox")
search.Size = UDim2.new(0, 120, 0, 22)
search.Position = UDim2.new(1, -196, 0, 5)
search.BackgroundColor3 = C_BG
search.PlaceholderText = "Search"
search.PlaceholderColor3 = C_GRAY
search.Text = ""
search.TextColor3 = WHITE
search.Font = Enum.Font.Gotham
search.TextSize = 11
search.ClearTextOnFocus = false
search.Parent = bar
corner(search, 6)

local function barBtn(text, xOff, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 28, 0, 22)
    b.Position = UDim2.new(1, xOff, 0, 5)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = bar
    corner(b, 6)
    return b
end
local minBtn = barBtn("-", -64, C_OFF)
local closeBtn = barBtn("X", -32, Color3.fromRGB(200, 50, 50))

-- ===== DIALOG TUTUP =====
local dlg = Instance.new("Frame")
dlg.Size = UDim2.new(1, 0, 1, 0)
dlg.BackgroundColor3 = Color3.new(0, 0, 0)
dlg.BackgroundTransparency = 0.45
dlg.BorderSizePixel = 0
dlg.Active = true
dlg.Visible = false
dlg.ZIndex = 50
dlg.Parent = main

local dbox = Instance.new("Frame")
dbox.Size = UDim2.new(0, 270, 0, 110)
dbox.AnchorPoint = Vector2.new(0.5, 0.5)
dbox.Position = UDim2.new(0.5, 0, 0.5, 0)
dbox.BackgroundColor3 = C_ROW
dbox.BorderSizePixel = 0
dbox.ZIndex = 51
dbox.Parent = dlg
corner(dbox, 10)
Instance.new("UIStroke", dbox).Color = Color3.fromRGB(70, 70, 85)

local dtxt = lbl(dbox, "Do you want to close this window", 13, true, WHITE,
    UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 10))
dtxt.TextWrapped = true
dtxt.TextXAlignment = Enum.TextXAlignment.Center
dtxt.ZIndex = 52

local function dlgBtn(text, xScale, xOff, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 105, 0, 30)
    b.Position = UDim2.new(xScale, xOff, 1, -42)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 52
    b.Parent = dbox
    corner(b, 8)
    return b
end
local noBtn = dlgBtn("No", 0, 20, C_OFF)
local yesBtn = dlgBtn("Yes", 1, -125, Color3.fromRGB(200, 50, 50))

-- ===== DRAG =====
do
    local dragging, startPos, startPoint, dragInput
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging, dragInput = true, i
            startPoint, startPos = i.Position, main.Position
        end
    end)
    track(UIS.InputChanged:Connect(function(i)
        if dragging and (i == dragInput or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local d = i.Position - startPoint
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end))
    track(UIS.InputEnded:Connect(function(i)
        if i == dragInput then dragging = false end
    end))
end

-- ===== IKON MINIMIZE =====
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0, 46, 0, 46)
mini.BackgroundColor3 = C_BAR
mini.AutoButtonColor = false
mini.Text = "T"
mini.TextColor3 = WHITE
mini.Font = Enum.Font.GothamBold
mini.TextSize = 22
mini.Position = UDim2.new(0, 16, 0.5, -23)
mini.Visible = false
mini.Parent = gui
corner(mini, 12)
Instance.new("UIStroke", mini).Color = Color3.fromRGB(220, 130, 30)

local iconPlaced = false
minBtn.MouseButton1Click:Connect(function()
    if not iconPlaced then mini.Position = main.Position; iconPlaced = true end
    main.Visible = false
    mini.Visible = true
end)

do
    local dragging, moved, startPoint, startPos, dragInput
    mini.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging, moved, dragInput = true, false, i
            startPoint, startPos = i.Position, mini.Position
        end
    end)
    track(UIS.InputChanged:Connect(function(i)
        if dragging and (i == dragInput or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local d = i.Position - startPoint
            if d.Magnitude > 8 then moved = true end
            if moved then
                mini.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end))
    track(UIS.InputEnded:Connect(function(i)
        if dragging and i == dragInput then
            dragging = false
            if not moved then mini.Visible = false; main.Visible = true end
        end
    end))
end

-- ===== IKON (download dari GitHub, disimpan di executor) =====
local function iconAsset(file, base)
    local path = "tpl_icons/" .. file
    if isfolder and makefolder and not isfolder("tpl_icons") then pcall(makefolder, "tpl_icons") end
    if isfile and writefile and not isfile(path) then
        local okH, data = pcall(function() return game:HttpGet((base or ICON_BASE) .. file) end)
        -- hanya simpan kalau benar-benar PNG (hindari file rusak berisi teks 404)
        if okH and type(data) == "string" and #data > 8 and data:sub(2, 4) == "PNG" then
            pcall(writefile, path, data)
        end
    end
    if getcustomasset and isfile and isfile(path) then
        local okA, a = pcall(getcustomasset, path)
        if okA and a then return a end
    end
    return ""
end

local function setIcon(img, file, base)
    task.spawn(function()
        local a = iconAsset(file, base)
        if a ~= "" and img.Parent then img.Image = a end
    end)
end

-- icon.png untuk tombol minimize (huruf T jadi cadangan)
do
    local miniImg = Instance.new("ImageLabel")
    miniImg.Size = UDim2.new(1, 0, 1, 0)
    miniImg.BackgroundTransparency = 1
    miniImg.ScaleType = Enum.ScaleType.Crop
    miniImg.Visible = false
    miniImg.Parent = mini
    corner(miniImg, 12)
    task.spawn(function()
        local a = iconAsset("icon.png")
        if a ~= "" and miniImg.Parent then
            miniImg.Image = a
            miniImg.Visible = true
            mini.Text = ""
        end
    end)
end

-- ===== BODY: SIDEBAR + HALAMAN =====
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
do
    local tl = Instance.new("UIListLayout", tabList)
    tl.Padding = UDim.new(0, 2)
    tl.SortOrder = Enum.SortOrder.LayoutOrder
    local tp = Instance.new("UIPadding", tabList)
    tp.PaddingTop = UDim.new(0, 8)
    tp.PaddingLeft = UDim.new(0, 6)
    tp.PaddingRight = UDim.new(0, 6)
end

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
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pages[name] = p
    return p
end

local function setTab(name)
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, b in pairs(tabs) do
        b.BackgroundColor3 = (n == name) and C_ROW or C_BAR
        b.TextColor3 = (n == name) and WHITE or C_GRAY
        local ic = b:FindFirstChildOfClass("ImageLabel")
        if ic then ic.ImageTransparency = (n == name) and 0 or 0.45 end
    end
end

local function newTab(name, ord, icon, label, base)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 25)
    b.Text = label or name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.LayoutOrder = ord
    b.Parent = tabList
    corner(b, 8)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 28)
    local ic = Instance.new("ImageLabel")
    ic.Size = UDim2.new(0, 18, 0, 18)
    ic.Position = UDim2.new(0, -24, 0.5, -9)
    ic.BackgroundTransparency = 1
    ic.Image = ""
    ic.Parent = b
    setIcon(ic, icon, base)
    tabs[name] = b
    b.MouseButton1Click:Connect(function() setTab(name) end)
end

-- { "NamaHalaman", "icon.png", "Label?", alamatFolderIcon? }
local tabDefs = {
    { "Main", "home.png" },
    { "Fly", "fly.png" },
    { "Aim", "aim.png" },
    { "Misc", "gear.png", nil, TFA_ICON_BASE },
}
for i, t in ipairs(tabDefs) do
    newPage(t[1])
    newTab(t[1], i, t[2], t[3], t[4])
end
setTab("Main")

-- ===== KOMPONEN =====
local sections = {}
local function section(parent, keyword)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 0)
    f.AutomaticSize = Enum.AutomaticSize.Y
    f.BackgroundTransparency = 1
    f.LayoutOrder = nextOrder()
    f.Parent = parent
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0, 4)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    sections[#sections + 1] = { f, keyword:lower() }
    return f
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    local q = search.Text:lower()
    for _, s in ipairs(sections) do
        s[1].Visible = (q == "") or (s[2]:find(q, 1, true) ~= nil)
    end
end)

local function groupTitle(parent, text)
    local l = lbl(parent, text, 12, true)
    l.LayoutOrder = nextOrder()
    return l
end

local function textBlock(parent, titleText, desc, widthOffset)
    local txt = Instance.new("Frame")
    txt.Size = UDim2.new(1, widthOffset, 0, 0)
    txt.AutomaticSize = Enum.AutomaticSize.Y
    txt.BackgroundTransparency = 1
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.Parent = parent
    local l = Instance.new("UIListLayout", txt)
    l.Padding = UDim.new(0, 2)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    local pad = Instance.new("UIPadding", txt)
    pad.PaddingTop = UDim.new(0, 7)
    pad.PaddingBottom = UDim.new(0, 7)
    lbl(txt, titleText, 12, true).LayoutOrder = 1
    if desc then
        local d = lbl(txt, desc, 10, false, C_GRAY, UDim2.new(1, 0, 0, 0))
        d.AutomaticSize = Enum.AutomaticSize.Y
        d.TextWrapped = true
        d.TextYAlignment = Enum.TextYAlignment.Top
        d.LayoutOrder = 2
    end
end

local function switchRow(parent, text, desc, key)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 0)
    row.AutomaticSize = Enum.AutomaticSize.Y
    row.BackgroundColor3 = C_ROW
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = nextOrder()
    row.Parent = parent
    corner(row, 8)
    Instance.new("UISizeConstraint", row).MinSize = Vector2.new(0, 38)
    textBlock(row, text, desc, -64)

    local pill = Instance.new("Frame")
    pill.Size = UDim2.new(0, 40, 0, 20)
    pill.Position = UDim2.new(1, -50, 0.5, -10)
    pill.Parent = row
    corner(pill, 10)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.BackgroundColor3 = WHITE
    knob.Parent = pill
    corner(knob, 8)

    local function refresh(animate)
        local on = State[key]
        local col = on and C_ON or C_OFF
        local pos = on and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
        if animate then
            local info = TweenInfo.new(0.15)
            TS:Create(pill, info, { BackgroundColor3 = col }):Play()
            TS:Create(knob, info, { Position = pos }):Play()
        else
            pill.BackgroundColor3 = col
            knob.Position = pos
        end
    end
    row.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        refresh(true)
    end)
    refresh(false)
    UI.switch[key] = function() refresh(false) end
end

local function infoRow(parent, initial)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 0)
    row.AutomaticSize = Enum.AutomaticSize.Y
    row.BackgroundColor3 = C_ROW
    row.BorderSizePixel = 0
    row.LayoutOrder = nextOrder()
    row.Parent = parent
    corner(row, 8)
    local l = lbl(row, initial, 11, false, C_GRAY, UDim2.new(1, -20, 0, 0), UDim2.new(0, 10, 0, 0))
    l.AutomaticSize = Enum.AutomaticSize.Y
    l.TextWrapped = true
    l.TextYAlignment = Enum.TextYAlignment.Top
    Instance.new("UIPadding", l).PaddingTop = UDim.new(0, 8)
    Instance.new("UIPadding", row).PaddingBottom = UDim.new(0, 8)
    return l
end

local function textBoxRow(parent, titleText, placeholder)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 54)
    row.BackgroundColor3 = C_ROW
    row.BorderSizePixel = 0
    row.LayoutOrder = nextOrder()
    row.Parent = parent
    corner(row, 8)
    lbl(row, titleText, 12, true, WHITE, UDim2.new(1, -20, 0, 16), UDim2.new(0, 10, 0, 6))

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -20, 0, 24)
    box.Position = UDim2.new(0, 10, 0, 25)
    box.BackgroundColor3 = C_BG
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = C_GRAY
    box.Text = ""
    box.TextColor3 = WHITE
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.ClipsDescendants = true
    box.TextTruncate = Enum.TextTruncate.AtEnd
    box.Parent = row
    corner(box, 6)
    Instance.new("UIPadding", box).PaddingLeft = UDim.new(0, 8)
    return box
end

-- defs = { {teks, fungsi, warna?}, ... }
local function buttonsRow(parent, defs)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.LayoutOrder = nextOrder()
    row.Parent = parent
    local l = Instance.new("UIListLayout", row)
    l.FillDirection = Enum.FillDirection.Horizontal
    l.Padding = UDim.new(0, 6)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    local n = #defs
    local gap = (n - 1) * 6 / n
    for i, d in ipairs(defs) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1 / n, -gap, 1, 0)
        b.BackgroundColor3 = d[3] or C_ROW
        b.Text = d[1]
        b.TextColor3 = WHITE
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.LayoutOrder = i
        b.Parent = row
        corner(b, 8)
        b.MouseButton1Click:Connect(d[2] or function() end)
    end
end

-- dropdown pilih satu; getItems() dipanggil tiap dibuka
local function makeDropdown(parent, titleText, getItems, onPick)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 0)
    holder.AutomaticSize = Enum.AutomaticSize.Y
    holder.BackgroundTransparency = 1
    holder.LayoutOrder = nextOrder()
    holder.Parent = parent
    local hl = Instance.new("UIListLayout", holder)
    hl.Padding = UDim.new(0, 4)
    hl.SortOrder = Enum.SortOrder.LayoutOrder

    local head = Instance.new("TextButton")
    head.Size = UDim2.new(1, 0, 0, 38)
    head.BackgroundColor3 = C_ROW
    head.Text = ""
    head.AutoButtonColor = false
    head.LayoutOrder = 1
    head.Parent = holder
    corner(head, 8)
    local tLbl = lbl(head, titleText, 12, true, WHITE, UDim2.new(1, -40, 0, 16), UDim2.new(0, 10, 0, 11))
    local valueLbl = lbl(head, "", 10, false, C_GRAY, UDim2.new(1, -40, 0, 14), UDim2.new(0, 10, 0, 21))
    valueLbl.Visible = false
    local arrow = lbl(head, "v", 13, true, WHITE, UDim2.new(0, 24, 0, 20), UDim2.new(1, -30, 0.5, -10))
    arrow.TextXAlignment = Enum.TextXAlignment.Center

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, 0, 0, 30)
    list.BackgroundColor3 = C_ROW
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 3
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.CanvasSize = UDim2.new(0, 0, 0, 0)
    list.Visible = false
    list.LayoutOrder = 2
    list.Parent = holder
    corner(list, 8)
    local ll = Instance.new("UIListLayout", list)
    ll.Padding = UDim.new(0, 2)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    local lpad = Instance.new("UIPadding", list)
    lpad.PaddingTop = UDim.new(0, 3)
    lpad.PaddingLeft = UDim.new(0, 4)
    lpad.PaddingRight = UDim.new(0, 4)

    local api = {}
    function api.setValue(text)
        if text and text ~= "" then
            valueLbl.Text = text
            valueLbl.Visible = true
            tLbl.Position = UDim2.new(0, 10, 0, 5)
        else
            valueLbl.Text = ""
            valueLbl.Visible = false
            tLbl.Position = UDim2.new(0, 10, 0, 11)
        end
    end

    local function close()
        list.Visible = false
        arrow.Text = "v"
    end

    head.MouseButton1Click:Connect(function()
        if list.Visible then close() return end
        for _, c in ipairs(list:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
        end
        local items = getItems()
        if #items == 0 then
            local e = lbl(list, "(empty)", 11, false, C_GRAY, UDim2.new(1, 0, 0, 24))
            e.TextXAlignment = Enum.TextXAlignment.Center
        end
        for i, name in ipairs(items) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 24)
            b.BackgroundColor3 = C_BG
            b.Text = name
            b.TextColor3 = WHITE
            b.Font = Enum.Font.Gotham
            b.TextSize = 11
            b.LayoutOrder = i
            b.Parent = list
            corner(b, 6)
            b.MouseButton1Click:Connect(function()
                api.setValue(name)
                close()
                if onPick then onPick(name) end
            end)
        end
        list.Size = UDim2.new(1, 0, 0, math.clamp(#items * 26 + 8, 30, 112))
        list.Visible = true
        arrow.Text = "^"
    end)
    return api
end

-- ===== LOGIKA FITUR =====
local function cam() return Workspace.CurrentCamera end
local function hrp() local c = lp.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hum() local c = lp.Character return c and c:FindFirstChildOfClass("Humanoid") end

-- lapisan gambar (lingkaran FOV dan label ESP), di belakang jendela utama
local overlay = Instance.new("Frame")
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.Active = false
overlay.ZIndex = 0
overlay.Parent = gui

-- lapisan paling atas khusus lingkaran FOV (tidak menerima input), supaya
-- lingkaran penuh terlihat dan tidak tertutup jendela saat mengatur FOV Size
local topLayer = Instance.new("Frame")
topLayer.Name = "TopLayer"
topLayer.Size = UDim2.new(1, 0, 1, 0)
topLayer.BackgroundTransparency = 1
topLayer.BorderSizePixel = 0
topLayer.Active = false
topLayer.ZIndex = 100
topLayer.Parent = gui

local fov = Instance.new("Frame")
fov.AnchorPoint = Vector2.new(0.5, 0.5)
fov.Position = UDim2.new(0.5, 0, 0.5, 0)
fov.BackgroundTransparency = 1
fov.BorderSizePixel = 0
fov.Active = false
fov.ZIndex = 100
fov.Visible = false
fov.Parent = topLayer
Instance.new("UICorner", fov).CornerRadius = UDim.new(0.5, 0)
local fovStroke = Instance.new("UIStroke", fov)
fovStroke.Color = WHITE
fovStroke.Thickness = 1.5

-- ---------- FLY ----------
local flyBV, flyBG
local function flyStop()
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyBG then flyBG:Destroy(); flyBG = nil end
    local h = hum()
    if h then h.PlatformStand = false end
end

local function flyStep()
    local r, h, c = hrp(), hum(), cam()
    if not (r and h and c) then return end
    if not flyBV or flyBV.Parent ~= r then
        if flyBV then flyBV:Destroy() end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = r
    end
    if not flyBG or flyBG.Parent ~= r then
        if flyBG then flyBG:Destroy() end
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.P = 9e4
        flyBG.CFrame = r.CFrame
        flyBG.Parent = r
    end
    h.PlatformStand = true
    local speed = State.FlySpeed or 50
    local cf = c.CFrame
    local md = h.MoveDirection
    local vel = Vector3.zero
    if md.Magnitude > 0 then
        -- arah gerak + naik/turun mengikuti arah kamera (cocok untuk HP)
        local flat = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
        local fwd = (flat.Magnitude > 0) and md:Dot(flat.Unit) or 0
        vel = md * speed + Vector3.new(0, cf.LookVector.Y * fwd * speed, 0)
    end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, speed, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.new(0, speed, 0) end
    flyBV.Velocity = vel
    flyBG.CFrame = cf
end

-- ---------- NOCLIP ----------
local noclipOrig = setmetatable({}, { __mode = "k" })
local function noclipStep()
    local ch = lp.Character
    if not ch then return end
    for _, d in ipairs(ch:GetDescendants()) do
        if d:IsA("BasePart") and d.CanCollide then
            noclipOrig[d] = true
            d.CanCollide = false
        end
    end
end
local function noclipRestore()
    for part in pairs(noclipOrig) do
        if part.Parent then part.CanCollide = true end
        noclipOrig[part] = nil
    end
end

-- ---------- INFINITE JUMP ----------
track(UIS.JumpRequest:Connect(function()
    if State.InfJump then
        local h = hum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

-- ---------- INVISIBLE (client side) ----------
local invisOrig = setmetatable({}, { __mode = "k" })
local function applyInvis(on)
    local ch = lp.Character
    if not ch then return end
    for _, d in ipairs(ch:GetDescendants()) do
        if (d:IsA("BasePart") or d:IsA("Decal")) and d.Name ~= "HumanoidRootPart" then
            if on then
                if invisOrig[d] == nil then invisOrig[d] = d.Transparency end
                d.Transparency = 1
            elseif invisOrig[d] ~= nil then
                d.Transparency = invisOrig[d]
                invisOrig[d] = nil
            end
        end
    end
end

-- ---------- AIMBOT ----------
local aimTarget, aimPick
local function aimPartFor(ch)
    local pick = State.AimPart or "Head"
    if pick == "Random" then pick = aimPick or "Head" end
    if pick == "Head" then return ch:FindFirstChild("Head") end
    return ch:FindFirstChild("UpperTorso") or ch:FindFirstChild("Torso") or ch:FindFirstChild("HumanoidRootPart")
end

local function aimStep()
    local c = cam()
    if not c then return end
    local size = State.FovSize or 120
    fov.Size = UDim2.fromOffset(size * 2, size * 2)
    fov.Visible = State.ShowFov == true
    if not State.Aimbot then aimTarget = nil return end

    local vp = c.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    local bestPart, bestD, bestPlayer
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp and not (State.TeamCheck and lp.Team ~= nil and pl.Team == lp.Team) then
            local ch = pl.Character
            local h = ch and ch:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 then
                local part = aimPartFor(ch)
                if part then
                    local v, on = c:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(v.X, v.Y) - center).Magnitude
                        if d <= size and (not bestD or d < bestD) then
                            bestPart, bestD, bestPlayer = part, d, pl
                        end
                    end
                end
            end
        end
    end
    if bestPlayer ~= aimTarget then
        aimTarget = bestPlayer
        aimPick = (math.random(2) == 1) and "Head" or "Torso"
    end
    if bestPart then
        local alpha = math.clamp(1 / math.max(State.Smoothness or 5, 1), 0.02, 1)
        c.CFrame = c.CFrame:Lerp(CFrame.lookAt(c.CFrame.Position, bestPart.Position), alpha)
    end
end

-- ---------- ESP PLAYER ----------
local espLabels = {}

-- true kalau titik layar berada di dalam jendela utama (label ESP disembunyikan di sana)
local function insideWindow(x, y)
    if not main.Visible then return false end
    local ap, as = main.AbsolutePosition, main.AbsoluteSize
    return x >= ap.X and x <= ap.X + as.X and y >= ap.Y and y <= ap.Y + as.Y
end

local function espStep()
    local c = cam()
    for pl, l in pairs(espLabels) do
        if not pl.Parent or not State.ESPPlayer then
            l:Destroy()
            espLabels[pl] = nil
        end
    end
    if not State.ESPPlayer or not c then return end
    local myR = hrp()
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then
            local head = pl.Character and pl.Character:FindFirstChild("Head")
            local l = espLabels[pl]
            if head then
                local v, on = c:WorldToViewportPoint(head.Position + Vector3.new(0, 1.6, 0))
                if on and not insideWindow(v.X, v.Y) then
                    if not l then
                        l = Instance.new("TextLabel")
                        l.Size = UDim2.new(0, 180, 0, 16)
                        l.AnchorPoint = Vector2.new(0.5, 1)
                        l.BackgroundTransparency = 1
                        l.TextColor3 = WHITE
                        l.TextStrokeTransparency = 1
                        l.ZIndex = 0
                        l.Font = Enum.Font.GothamBold
                        l.TextSize = 12
                        l.Parent = overlay
                        espLabels[pl] = l
                    end
                    local dist = myR and math.floor((head.Position - myR.Position).Magnitude) or 0
                    l.Text = pl.DisplayName .. " [" .. dist .. "m]"
                    l.Position = UDim2.fromOffset(v.X, v.Y)
                    l.Visible = true
                elseif l then
                    l.Visible = false
                end
            elseif l then
                l.Visible = false
            end
        end
    end
end

-- ---------- ESP LINE (garis dari kepala kita ke pemain lain) ----------
local espLines = {}

-- titik awal garis: kepala karakter kita kalau terlihat di layar (third person),
-- kalau tidak (first person) dari tengah bawah layar
local function lineOrigin(c)
    local vp = c.ViewportSize
    local myHead = lp.Character and lp.Character:FindFirstChild("Head")
    if myHead and (c.CFrame.Position - myHead.Position).Magnitude > 3 then
        local v, on = c:WorldToViewportPoint(myHead.Position)
        if on then return Vector2.new(v.X, v.Y) end
    end
    return Vector2.new(vp.X / 2, vp.Y)
end

local function lineStep()
    local c = cam()
    for pl, l in pairs(espLines) do
        if not pl.Parent or not State.ESPLine then
            l:Destroy()
            espLines[pl] = nil
        end
    end
    if not State.ESPLine or not c then return end
    local origin = lineOrigin(c)
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= lp then
            local head = pl.Character and pl.Character:FindFirstChild("Head")
            local l = espLines[pl]
            local v, on
            if head then v, on = c:WorldToViewportPoint(head.Position) end
            if head and on then
                if not l then
                    l = Instance.new("Frame")
                    l.AnchorPoint = Vector2.new(0.5, 0.5)
                    l.BackgroundColor3 = WHITE
                    l.BorderSizePixel = 0
                    l.Active = false
                    l.ZIndex = 0
                    l.Parent = overlay
                    espLines[pl] = l
                end
                local b = Vector2.new(v.X, v.Y)
                local d = b - origin
                l.Size = UDim2.fromOffset(d.Magnitude, 1.5)
                l.Position = UDim2.fromOffset((origin.X + b.X) / 2, (origin.Y + b.Y) / 2)
                l.Rotation = math.deg(math.atan2(d.Y, d.X))
                l.Visible = true
            elseif l then
                l.Visible = false
            end
        end
    end
end

pcall(function() RunService:UnbindFromRenderStep("TemplateUI_Render") end)
RunService:BindToRenderStep("TemplateUI_Render", Enum.RenderPriority.Camera.Value + 1, function()
    pcall(aimStep)
    pcall(espStep)
    pcall(lineStep)
end)
track(RunService.Heartbeat:Connect(function()
    if State.Fly then pcall(flyStep) end
end))
track(RunService.Stepped:Connect(function()
    if State.Noclip then pcall(noclipStep) end
end))

-- ---------- ANTI AFK ----------
track(lp.Idled:Connect(function()
    if State.AntiAfk then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end))

-- ---------- AUTO RECONNECT ----------
local function rejoin()
    if not State.AutoReconnect then return end
    task.wait(2)
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, lp)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
        end
    end)
end
task.spawn(function()
    pcall(function()
        local prompt = CoreGui:WaitForChild("RobloxPromptGui", 15):WaitForChild("promptOverlay", 15)
        track(prompt.ChildAdded:Connect(function(c)
            if c.Name == "ErrorPrompt" then rejoin() end
        end))
    end)
end)
track(TeleportService.TeleportInitFailed:Connect(function()
    if State.AutoReconnect then
        task.wait(2)
        pcall(function() TeleportService:Teleport(game.PlaceId, lp) end)
    end
end))

-- ---------- PERFORMANCE BOOST (pencahayaan diatur di bagian PENCAHAYAAN) ----------
local perf = { orig = setmetatable({}, { __mode = "k" }), fx = {}, water = nil, quality = nil, conn = nil, token = 0 }

local function perfApply(d)
    if d:IsA("Terrain") then return end
    if d:IsA("BasePart") then
        if not perf.orig[d] then perf.orig[d] = { d.Material, d.Reflectance, d.CastShadow } end
        d.Material = Enum.Material.SmoothPlastic
        d.Reflectance = 0
        d.CastShadow = false
    elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
        if not perf.orig[d] then perf.orig[d] = { d.Enabled } end
        d.Enabled = false
    end
end

local function perfToggle(on)
    perf.token += 1
    local myToken = perf.token
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if on then
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("PostEffect") and e.Enabled then
                perf.fx[e] = true
                e.Enabled = false
            end
        end
        if terrain then
            perf.water = { terrain.WaterWaveSize, terrain.WaterWaveSpeed, terrain.WaterReflectance }
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
        end
        pcall(function()
            perf.quality = settings().Rendering.QualityLevel
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        if perf.conn then perf.conn:Disconnect() end
        perf.conn = Workspace.DescendantAdded:Connect(function(d)
            task.defer(function() pcall(perfApply, d) end)
        end)
        task.spawn(function()
            local n = 0
            for _, d in ipairs(Workspace:GetDescendants()) do
                if perf.token ~= myToken then return end
                pcall(perfApply, d)
                n += 1
                if n % 300 == 0 then task.wait() end
            end
        end)
    else
        if perf.conn then perf.conn:Disconnect(); perf.conn = nil end
        for e in pairs(perf.fx) do
            if e.Parent then e.Enabled = true end
            perf.fx[e] = nil
        end
        if terrain and perf.water then
            terrain.WaterWaveSize = perf.water[1]
            terrain.WaterWaveSpeed = perf.water[2]
            terrain.WaterReflectance = perf.water[3]
            perf.water = nil
        end
        if perf.quality then
            pcall(function() settings().Rendering.QualityLevel = perf.quality end)
            perf.quality = nil
        end
        for d, v in pairs(perf.orig) do
            if d.Parent then
                pcall(function()
                    if d:IsA("BasePart") then
                        d.Material, d.Reflectance, d.CastShadow = v[1], v[2], v[3]
                    else
                        d.Enabled = v[1]
                    end
                end)
            end
            perf.orig[d] = nil
        end
    end
end

-- ---------- WALKSPEED & JUMPPOWER ----------
local moveOrig = setmetatable({}, { __mode = "k" })
local function moveStep()
    local h = hum()
    if not h then return end
    local o = moveOrig[h]
    if not o then o = {}; moveOrig[h] = o end

    if State.WalkOn then
        if o.ws == nil then o.ws = h.WalkSpeed end
        h.WalkSpeed = State.WalkSpeed or 16
    elseif o.ws ~= nil then
        h.WalkSpeed = o.ws
        o.ws = nil
    end

    if State.JumpOn then
        local pw = State.JumpPower or 50
        if o.jp == nil then
            o.jp = { h.UseJumpPower, h.UseJumpPower and h.JumpPower or h.JumpHeight }
        end
        if h.UseJumpPower then
            h.JumpPower = pw
        else
            h.JumpHeight = pw * pw / (2 * Workspace.Gravity)
        end
    elseif o.jp ~= nil then
        if o.jp[1] then h.JumpPower = o.jp[2] else h.JumpHeight = o.jp[2] end
        o.jp = nil
    end
end
track(RunService.Heartbeat:Connect(function() pcall(moveStep) end))

-- ---------- TELEPORT KE PLAYER ----------
local function teleportToPlayer(name)
    local target = name and Players:FindFirstChild(name)
    if not target then return false, "Select a player first" end
    local tr = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    local r = hrp()
    if not tr then return false, name .. " has no character yet" end
    if not r then return false, "Your character is not ready" end
    r.CFrame = tr.CFrame * CFrame.new(0, 0, 3)
    return true, "Teleported to " .. name
end

-- ---------- PENCAHAYAAN (Fullbright, No Fog, dan Performance Boost) ----------
local lightGroups = {}
local function lightGroup(name, active, capture, apply, restore)
    local g = lightGroups[name]
    if active then
        if not g then g = capture(); lightGroups[name] = g end
        apply()
    elseif g then
        restore(g)
        lightGroups[name] = nil
    end
end

local function lightStep()
    lightGroup("bright", State.Fullbright,
        function()
            return { Lighting.Brightness, Lighting.ClockTime, Lighting.Ambient, Lighting.OutdoorAmbient }
        end,
        function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.Ambient = Color3.fromRGB(178, 178, 178)
            Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
        end,
        function(s)
            Lighting.Brightness, Lighting.ClockTime = s[1], s[2]
            Lighting.Ambient, Lighting.OutdoorAmbient = s[3], s[4]
        end)

    lightGroup("shadow", State.Fullbright or State.PerfBoost,
        function() return { Lighting.GlobalShadows } end,
        function() Lighting.GlobalShadows = false end,
        function(s) Lighting.GlobalShadows = s[1] end)

    lightGroup("fog", State.NoFog or State.PerfBoost,
        function()
            local s = { Lighting.FogEnd, atm = {} }
            for _, a in ipairs(Lighting:GetChildren()) do
                if a:IsA("Atmosphere") then s.atm[a] = { a.Density, a.Haze } end
            end
            return s
        end,
        function()
            Lighting.FogEnd = 9e9
            for _, a in ipairs(Lighting:GetChildren()) do
                if a:IsA("Atmosphere") then
                    a.Density = 0
                    a.Haze = 0
                end
            end
        end,
        function(s)
            Lighting.FogEnd = s[1]
            for a, v in pairs(s.atm) do
                if a.Parent then a.Density, a.Haze = v[1], v[2] end
            end
        end)
end
track(RunService.Heartbeat:Connect(function() pcall(lightStep) end))

-- ---------- ANTI RAGDOLL ----------
local ragdollWas = false
local function antiRagdollStep()
    local h = hum()
    if not h then return end
    if State.AntiRagdoll then
        ragdollWas = true
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        local st = h:GetState()
        if st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown then
            h:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        -- ragdoll buatan game: sendi dimatikan + BallSocketConstraint
        for _, d in ipairs(h.Parent:GetDescendants()) do
            if d:IsA("Motor6D") and not d.Enabled then
                d.Enabled = true
            elseif d:IsA("BallSocketConstraint") and d.Enabled then
                d.Enabled = false
            end
        end
    elseif ragdollWas then
        ragdollWas = false
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    end
end
track(RunService.Heartbeat:Connect(function() pcall(antiRagdollStep) end))

-- ---------- PEMANTAU SWITCH ----------
task.spawn(function()
    local prev = {}
    while gui.Parent do
        local f = State.Fly and true or false
        if f ~= prev.Fly then
            prev.Fly = f
            if not f then pcall(flyStop) end
        end
        local n = State.Noclip and true or false
        if n ~= prev.Noclip then
            prev.Noclip = n
            if not n then pcall(noclipRestore) end
        end
        local i = State.Invisible and true or false
        if i then
            pcall(applyInvis, true)
        elseif i ~= prev.Invis then
            pcall(applyInvis, false)
        end
        prev.Invis = i
        local pb = State.PerfBoost and true or false
        if pb ~= prev.Perf then
            prev.Perf = pb
            if pb or prev.PerfWasOn then pcall(perfToggle, pb) end
            prev.PerfWasOn = pb or nil
        end
        task.wait(0.25)
    end
end)

-- bersih-bersih saat jendela ditutup
gui.Destroying:Connect(function()
    pcall(function() RunService:UnbindFromRenderStep("TemplateUI_Render") end)
    pcall(flyStop)
    pcall(noclipRestore)
    pcall(applyInvis, false)
    if perf.conn or next(perf.orig) then pcall(perfToggle, false) end
end)

-- ---------- CONFIG ----------
local Config = {}
local CFG_DIR = "TemplateUI"
local CFG_FOLDER = CFG_DIR .. "/configs"
local AUTO_FILE = CFG_DIR .. "/autoload.txt"
-- Performance Boost sengaja tidak ikut disimpan/dimuat (tidak pernah nyala otomatis)
local PERSIST = { "Fly", "FlySpeed", "Noclip", "InfJump", "Aimbot", "AimPart", "FovSize",
    "Smoothness", "ShowFov", "TeamCheck", "ESPPlayer", "Invisible", "AntiAfk", "AutoReconnect",
    "WalkOn", "WalkSpeed", "JumpOn", "JumpPower", "Fullbright", "NoFog", "AntiRagdoll", "ESPLine" }

local function cfgReady()
    return writefile and readfile and isfile and isfolder and makefolder and true or false
end
local function ensureDirs()
    if not isfolder(CFG_DIR) then makefolder(CFG_DIR) end
    if not isfolder(CFG_FOLDER) then makefolder(CFG_FOLDER) end
end
local function cleanName(n)
    return (tostring(n or ""):gsub("[^%w%-_ ]", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end
local function cfgPath(name) return CFG_FOLDER .. "/" .. name .. ".json" end

function Config.list()
    local out = {}
    if not (cfgReady() and listfiles) then return out end
    pcall(function()
        ensureDirs()
        for _, path in ipairs(listfiles(CFG_FOLDER)) do
            local name = path:match("([^/\\]+)%.json$")
            if name then out[#out + 1] = name end
        end
    end)
    table.sort(out)
    return out
end

function Config.exists(name)
    return cfgReady() and name ~= "" and isfile(cfgPath(name)) or false
end

function Config.save(name)
    name = cleanName(name)
    if name == "" then return false, "Write a config name first" end
    if not cfgReady() then return false, "Executor has no file support" end
    local data = {}
    for _, k in ipairs(PERSIST) do data[k] = State[k] end
    local okW, err = pcall(function()
        ensureDirs()
        writefile(cfgPath(name), HttpService:JSONEncode(data))
    end)
    return okW, okW and ("Saved: " .. name) or tostring(err)
end

function Config.load(name)
    name = cleanName(name)
    if name == "" then return false, "Select a config first" end
    if not cfgReady() then return false, "Executor has no file support" end
    if not isfile(cfgPath(name)) then return false, "Config not found: " .. name end
    local okR, data = pcall(function() return HttpService:JSONDecode(readfile(cfgPath(name))) end)
    if not okR or typeof(data) ~= "table" then return false, "Config file is corrupted" end
    for _, k in ipairs(PERSIST) do
        if data[k] ~= nil then State[k] = data[k] end
    end
    for _, refresh in pairs(UI.switch) do pcall(refresh) end
    for k, box in pairs(UI.box) do
        if State[k] ~= nil then box.Text = tostring(State[k]) end
    end
    if UI.dd.AimPart and State.AimPart then UI.dd.AimPart.setValue(State.AimPart) end
    return true, "Loaded: " .. name
end

function Config.getAuto()
    if cfgReady() and isfile(AUTO_FILE) then
        local n = cleanName(readfile(AUTO_FILE))
        if n ~= "" then return n end
    end
    return nil
end

function Config.clearAuto()
    if cfgReady() and delfile and isfile(AUTO_FILE) then pcall(delfile, AUTO_FILE) end
end

function Config.delete(name)
    name = cleanName(name)
    if name == "" then return false, "Select a config first" end
    if not (cfgReady() and delfile) then return false, "Executor has no file support" end
    if not isfile(cfgPath(name)) then return false, "Config not found: " .. name end
    local okD = pcall(delfile, cfgPath(name))
    if okD and Config.getAuto() == name then Config.clearAuto() end
    return okD, okD and ("Deleted: " .. name) or "Failed to delete"
end

function Config.setAuto(name)
    name = cleanName(name)
    if name == "" then return false, "Select a config first" end
    if not Config.exists(name) then return false, "Save the config first" end
    local okW = pcall(function() ensureDirs(); writefile(AUTO_FILE, name) end)
    return okW, okW and ("Active: " .. name) or "Failed to save"
end

function Config.autoload()
    local name = Config.getAuto()
    if name then return Config.load(name) end
end

-- ===== TAB MAIN =====
do
    local p = pages.Main
    local usersLbl, onlineLbl

    groupTitle(p, "Welcome")

    -- kartu akun
    local sAcc = section(p, "akun info profil")
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 76)
    row.BackgroundColor3 = C_ROW
    row.BorderSizePixel = 0
    row.LayoutOrder = nextOrder()
    row.Parent = sAcc
    corner(row, 8)

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 60, 0, 60)
    avatar.Position = UDim2.new(0, 8, 0, 8)
    avatar.BackgroundColor3 = C_BG
    avatar.BorderSizePixel = 0
    avatar.Image = ""
    avatar.Parent = row
    corner(avatar, 30)
    task.spawn(function()
        local okT, img = pcall(function()
            return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if okT and img and avatar.Parent then avatar.Image = img end
    end)

    local nameRow = Instance.new("Frame")
    nameRow.Size = UDim2.new(1, -156, 0, 20)
    nameRow.Position = UDim2.new(0, 76, 0, 14)
    nameRow.BackgroundTransparency = 1
    nameRow.Parent = row
    local nl = Instance.new("UIListLayout", nameRow)
    nl.FillDirection = Enum.FillDirection.Horizontal
    nl.VerticalAlignment = Enum.VerticalAlignment.Center
    nl.Padding = UDim.new(0, 6)
    nl.SortOrder = Enum.SortOrder.LayoutOrder

    local disp = lbl(nameRow, lp.DisplayName, 15, true, WHITE, UDim2.new(0, 0, 0, 20))
    disp.AutomaticSize = Enum.AutomaticSize.X
    disp.LayoutOrder = 1

    local ownerLabel = OWNER_IDS[lp.UserId]
    if ownerLabel then
        local tagLbl = Instance.new("TextLabel")
        tagLbl.Size = UDim2.new(0, 0, 0, 16)
        tagLbl.AutomaticSize = Enum.AutomaticSize.X
        tagLbl.BackgroundColor3 = Color3.fromRGB(210, 50, 50)
        tagLbl.Text = " " .. ownerLabel .. " "
        tagLbl.TextColor3 = WHITE
        tagLbl.Font = Enum.Font.GothamBold
        tagLbl.TextSize = 10
        tagLbl.LayoutOrder = 2
        tagLbl.Parent = nameRow
        corner(tagLbl, 4)
    end

    -- username disensor: 2 huruf pertama, sisanya bintang
    local nm = lp.Name
    local sensor = (#nm <= 2) and nm or (nm:sub(1, 2) .. string.rep("*", #nm - 2))
    lbl(row, "@" .. sensor, 10, false, C_GRAY, UDim2.new(1, -156, 0, 14), UDim2.new(0, 76, 0, 40))

    -- FPS (atas) dan ms (bawah) di sisi kanan kartu
    local function pill(y, text)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, 62, 0, 26)
        f.Position = UDim2.new(1, -70, 0, y)
        f.BackgroundColor3 = C_BG
        f.BorderSizePixel = 0
        f.Parent = row
        corner(f, 13)
        local l = lbl(f, text, 11, true, WHITE, UDim2.new(1, 0, 1, 0))
        l.TextXAlignment = Enum.TextXAlignment.Center
        return l
    end
    local pFps = pill(9, "- FPS")
    local pMs = pill(41, "- ms")

    local frames, last = 0, os.clock()
    local hb = RunService.Heartbeat:Connect(function() frames += 1 end)
    task.spawn(function()
        while gui.Parent do
            task.wait(1)
            local now = os.clock()
            local fps = math.floor(frames / (now - last) + 0.5)
            frames, last = 0, now
            local ms
            pcall(function() ms = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
            ms = ms or (lp:GetNetworkPing() * 1000)
            pFps.Text = fps .. " FPS"
            pMs.Text = math.floor(ms + 0.5) .. " ms"
        end
        hb:Disconnect()
    end)

    -- User / Online
    local s2 = section(p, "user online pengguna script")
    local statRow = Instance.new("Frame")
    statRow.Size = UDim2.new(1, 0, 0, 30)
    statRow.BackgroundTransparency = 1
    statRow.LayoutOrder = nextOrder()
    statRow.Parent = s2
    local function statCell(pos, size, iconFile, text)
        local cell = Instance.new("Frame")
        cell.Size = size
        cell.Position = pos
        cell.BackgroundColor3 = C_ROW
        cell.BorderSizePixel = 0
        cell.Parent = statRow
        corner(cell, 8)
        local ic = Instance.new("ImageLabel")
        ic.Size = UDim2.new(0, 16, 0, 16)
        ic.Position = UDim2.new(0, 8, 0.5, -8)
        ic.BackgroundTransparency = 1
        ic.Parent = cell
        setIcon(ic, iconFile)
        return lbl(cell, text, 11, true, WHITE, UDim2.new(1, -32, 1, 0), UDim2.new(0, 30, 0, 0))
    end
    usersLbl = statCell(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, -3, 1, 0), "user.png", "User : -")
    onlineLbl = statCell(UDim2.new(0.5, 3, 0, 0), UDim2.new(0.5, -3, 1, 0), "online.png", "Online : -")

    -- Discord
    groupTitle(p, "Discord")
    local sD = section(p, "discord group komunitas")
    local drow = Instance.new("TextButton")
    drow.Size = UDim2.new(1, 0, 0, 40)
    drow.BackgroundColor3 = C_ROW
    drow.BorderSizePixel = 0
    drow.Text = ""
    drow.LayoutOrder = nextOrder()
    drow.Parent = sD
    corner(drow, 8)
    local dic = Instance.new("ImageLabel")
    dic.Size = UDim2.new(0, 26, 0, 26)
    dic.Position = UDim2.new(0, 10, 0.5, -13)
    dic.BackgroundTransparency = 1
    dic.Parent = drow
    setIcon(dic, "discord.png", TFA_ICON_BASE)
    lbl(drow, "Discord Group", 12, true, WHITE, UDim2.new(1, -52, 0, 16), UDim2.new(0, 44, 0, 5))
    local dsub = lbl(drow, "Tap to copy & open the link", 9, false, C_GRAY, UDim2.new(1, -52, 0, 12), UDim2.new(0, 44, 0, 21))
    drow.MouseButton1Click:Connect(function()
        local copied = false
        local cb = setclipboard or toclipboard or (syn and syn.write_clipboard)
        if cb then copied = pcall(cb, DISCORD_LINK) end
        pcall(function() game:GetService("GuiService"):OpenBrowserWindow(DISCORD_LINK) end)
        dsub.Text = copied and "Link copied!" or DISCORD_LINK
        dsub.TextColor3 = C_GOOD
        task.delay(2.5, function()
            if dsub.Parent then
                dsub.Text = "Tap to copy & open the link"
                dsub.TextColor3 = C_GRAY
            end
        end)
    end)

    -- ===== penghitung (Abacus) =====
    local function userKey()
        local h1, h2 = 5381, 52711
        for c in (SALT .. tostring(lp.UserId)):gmatch(".") do
            h1 = (h1 * 33 + c:byte()) % 4294967296
            h2 = (h2 * 31 + c:byte()) % 4294967296
        end
        return string.format("u%08x%08x", h1, h2)
    end

    local function counterCall(path)
        local okH, resp = pcall(function() return game:HttpGet(COUNTER_BASE .. path) end)
        if not okH then return nil end
        local okJ, data = pcall(function() return HttpService:JSONDecode(resp) end)
        if okJ and typeof(data) == "table" then
            local v = tonumber(data.value) or tonumber(data.count) or tonumber(data.Count)
            if v then return v end
        end
        return tonumber(resp)
    end

    -- akun baru menambah total sekali; penanda disimpan per akun
    local function fetchTotalUsers()
        local regFile = "tpl_reg_" .. userKey() .. ".txt"
        local state = (isfile and isfile(regFile)) and readfile(regFile) or ""
        if state ~= "1" then
            if state ~= "pending" then
                local v = counterCall("/hit/" .. COUNTER_NS .. "/" .. userKey())
                if v == 1 then state = "pending"
                elseif v then state = "1" end
            end
            if state == "pending" then
                if writefile then pcall(writefile, regFile, "pending") end
                for _ = 1, 3 do
                    if counterCall("/hit/" .. COUNTER_NS .. "/" .. COUNTER_KEY) then
                        state = "1"
                        break
                    end
                    task.wait(2)
                end
            end
            if state == "1" and writefile then pcall(writefile, regFile, "1") end
        end
        return counterCall("/get/" .. COUNTER_NS .. "/" .. COUNTER_KEY)
    end

    task.spawn(function()
        while gui.Parent do
            local n = fetchTotalUsers()
            if usersLbl and usersLbl.Parent then
                usersLbl.Text = "User : " .. (n and tostring(n) or "-")
            end
            task.wait(60)
        end
    end)

    -- Online = akun yang aktif dalam 2 menit terakhir
    task.spawn(function()
        local BUCKET = 120
        local lastPinged
        while gui.Parent do
            local b = math.floor(DateTime.now().UnixTimestamp / BUCKET)
            if b ~= lastPinged then
                local v = counterCall("/hit/" .. COUNTER_NS .. "/o" .. b .. userKey())
                if v then
                    lastPinged = b
                    if v == 1 then
                        for _ = 1, 3 do
                            if counterCall("/hit/" .. COUNTER_NS .. "/on" .. b) then break end
                            task.wait(2)
                        end
                    end
                end
            end
            local cur = counterCall("/get/" .. COUNTER_NS .. "/on" .. b)
            local prev = counterCall("/get/" .. COUNTER_NS .. "/on" .. (b - 1))
            local n = math.max(cur or 0, prev or 0)
            if onlineLbl and onlineLbl.Parent then
                onlineLbl.Text = "Online : " .. (n > 0 and tostring(n) or "-")
            end
            task.wait(60)
        end
    end)
end

-- ===== TAB FLY =====
do
    local p = pages.Fly

    groupTitle(p, "Fly")
    local s1 = section(p, "fly terbang")
    switchRow(s1, "Fly", "Fly freely around the map", "Fly")

    local s2 = section(p, "fly speed kecepatan")
    local speedBox = textBoxRow(s2, "Fly Speed", "50")
    State.FlySpeed = 50
    speedBox.Text = "50"
    UI.box.FlySpeed = speedBox
    speedBox.FocusLost:Connect(function()
        local n = tonumber(speedBox.Text)
        if n then State.FlySpeed = math.clamp(n, 1, 500) end
        speedBox.Text = tostring(State.FlySpeed)
    end)

    groupTitle(p, "Movement")
    local s3 = section(p, "noclip tembus dinding")
    switchRow(s3, "Noclip", "Walk through walls and objects", "Noclip")
    local s4 = section(p, "infinite jump lompat")
    switchRow(s4, "Infinite Jump", "Jump again while in the air", "InfJump")

    groupTitle(p, "Speed")
    local w1 = section(p, "walkspeed kecepatan jalan")
    switchRow(w1, "WalkSpeed", "Changes how fast you walk", "WalkOn")
    local w2 = section(p, "walkspeed value")
    local wsBox = textBoxRow(w2, "WalkSpeed Value", "16")
    State.WalkSpeed = 16
    wsBox.Text = "16"
    UI.box.WalkSpeed = wsBox
    wsBox.FocusLost:Connect(function()
        local n = tonumber(wsBox.Text)
        if n then State.WalkSpeed = math.clamp(n, 1, 500) end
        wsBox.Text = tostring(State.WalkSpeed)
    end)

    local j1 = section(p, "jumppower tinggi lompat")
    switchRow(j1, "JumpPower", "Changes how high you jump", "JumpOn")
    local j2 = section(p, "jumppower value")
    local jpBox = textBoxRow(j2, "JumpPower Value", "50")
    State.JumpPower = 50
    jpBox.Text = "50"
    UI.box.JumpPower = jpBox
    jpBox.FocusLost:Connect(function()
        local n = tonumber(jpBox.Text)
        if n then State.JumpPower = math.clamp(n, 1, 500) end
        jpBox.Text = tostring(State.JumpPower)
    end)

    groupTitle(p, "Teleport")
    local t1 = section(p, "teleport ke player pemain")
    makeDropdown(t1, "Teleport To Player", function()
        local out = {}
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= lp then out[#out + 1] = pl.Name end
        end
        table.sort(out)
        return out
    end, function(name) State.TpTarget = name end)
    local t2 = section(p, "teleport tombol")
    buttonsRow(t2, {
        { "Teleport", function()
            local _, msg = teleportToPlayer(State.TpTarget)
            notify(msg)
        end },
    })
end

-- ===== TAB AIM =====
do
    local p = pages.Aim

    groupTitle(p, "Aim")
    local s1 = section(p, "aimbot aim bidik")
    switchRow(s1, "Aimbot", "Locks your aim onto the nearest target", "Aimbot")

    local s2 = section(p, "aim part bagian kepala")
    State.AimPart = "Head"
    local partDd = makeDropdown(s2, "Aim Part", function()
        return { "Head", "Torso", "Random" }
    end, function(name) State.AimPart = name end)
    partDd.setValue("Head")
    UI.dd.AimPart = partDd

    groupTitle(p, "Target")
    local s3 = section(p, "fov size ukuran")
    local fovBox = textBoxRow(s3, "FOV Size", "120")
    State.FovSize = 120
    fovBox.Text = "120"
    UI.box.FovSize = fovBox
    fovBox.FocusLost:Connect(function()
        local n = tonumber(fovBox.Text)
        if n then State.FovSize = math.clamp(n, 10, 800) end
        fovBox.Text = tostring(State.FovSize)
    end)

    local s4 = section(p, "smoothness halus")
    local smoothBox = textBoxRow(s4, "Smoothness", "5")
    State.Smoothness = 5
    smoothBox.Text = "5"
    UI.box.Smoothness = smoothBox
    smoothBox.FocusLost:Connect(function()
        local n = tonumber(smoothBox.Text)
        if n then State.Smoothness = math.clamp(n, 1, 50) end
        smoothBox.Text = tostring(State.Smoothness)
    end)

    local s5 = section(p, "show fov lingkaran")
    switchRow(s5, "Show FOV", "Draws the FOV circle on screen", "ShowFov")
    local s6 = section(p, "team check tim")
    switchRow(s6, "Team Check", "Ignores players on your team", "TeamCheck")
end

-- ===== TAB MISC =====
do
    local p = pages.Misc

    groupTitle(p, "Config")
    local c1 = section(p, "config name nama")
    local cfgName = textBoxRow(c1, "Config Name", "Write config name here")

    local function pickName()
        local n = cleanName(cfgName.Text)
        if n == "" then n = State.SelectedConfig or "" end
        return n
    end

    local c2 = section(p, "select config pilih")
    local cfgDd = makeDropdown(c2, "Select Config", Config.list, function(name)
        State.SelectedConfig = name
        cfgName.Text = name
    end)

    -- hasil Save/Load/Delete ditampilkan lewat notifikasi, bukan baris status
    local c3 = section(p, "save load delete config")
    buttonsRow(c3, {
        { "Save Config", function()
            local name = pickName()
            local okS, msg = Config.save(name)
            notify(msg)
            if okS then State.SelectedConfig = name; cfgDd.setValue(name) end
        end },
        { "Load Config", function()
            local name = pickName()
            local okL, msg = Config.load(name)
            notify(msg)
            if okL then State.SelectedConfig = name; cfgDd.setValue(name) end
        end },
        { "Delete Config", function()
            local okD, msg = Config.delete(pickName())
            notify(msg)
            if okD then State.SelectedConfig = nil; cfgDd.setValue(""); cfgName.Text = "" end
        end, C_RED },
    })

    groupTitle(p, "Auto Load Config")
    local c4 = section(p, "status config")
    local autoInfo = infoRow(c4, "Inactive")
    local savedAuto = Config.getAuto()
    if savedAuto then autoInfo.Text = "Active: " .. savedAuto end
    local c5 = section(p, "auto load config set delete")
    buttonsRow(c5, {
        { "Set", function()
            local _, msg = Config.setAuto(pickName())
            autoInfo.Text = msg
        end },
        { "Delete", function()
            Config.clearAuto()
            autoInfo.Text = "Inactive"
        end, C_RED },
    })

    groupTitle(p, "Visual")
    local v0 = section(p, "performance boost fps lag grafik")
    switchRow(v0, "Performance Boost", "Lowers graphics quality to boost FPS", "PerfBoost")
    local v0b = section(p, "fullbright terang gelap malam")
    switchRow(v0b, "Fullbright", "Makes everything bright, even at night", "Fullbright")
    local v0c = section(p, "no fog kabut")
    switchRow(v0c, "No Fog", "Removes fog and haze", "NoFog")
    local v1 = section(p, "esp player pemain lain")
    switchRow(v1, "ESP Player", "Shows player names and distance", "ESPPlayer")
    local v1b = section(p, "esp line garis tracer")
    switchRow(v1b, "ESP Line", "Draws lines from your head to other players", "ESPLine")
    local v2 = section(p, "invisible karakter")
    switchRow(v2, "Invisible", "Hides your character (client side)", "Invisible")

    groupTitle(p, "Other")
    local o1 = section(p, "anti afk")
    switchRow(o1, "Anti AFK", "Prevents idle kicks", "AntiAfk")
    local o2 = section(p, "auto reconnect masuk lagi terputus kick disconnect")
    switchRow(o2, "Auto Reconnect", "Rejoins if you disconnect or get kicked", "AutoReconnect")
    local o3 = section(p, "anti ragdoll jatuh terpental")
    switchRow(o3, "Anti Ragdoll", "Stops you from falling into ragdoll", "AntiRagdoll")
end

-- muat config auto-load (Performance Boost tidak pernah ikut)
Config.autoload()

-- ===== TUTUP =====
closeBtn.MouseButton1Click:Connect(function() dlg.Visible = true end)
noBtn.MouseButton1Click:Connect(function() dlg.Visible = false end)
yesBtn.MouseButton1Click:Connect(function()
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    gui:Destroy()
end)
