--[[
    ELITE BLOCKER SYSTEM - V11 (ULTRA-SPEED & INVISIBLE)
    DEVELOPER: andyxx7
    
    OPTIMIZĂRI:
    - Viteza de click a fost mutată pe un thread paralel (task.spawn).
    - Eliminat delay-ul vizual: Confirmarea se face în milisecunde.
    - Logica "Block & Click" sincronizată perfect.
]]--

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ==========================================
-- CONFIGURARE
-- ==========================================
local Whitelist = {}
local IsBlockingSequenceActive = false
local UI_NAME = "Andy_Blocker_V11_Ultra"

if CoreGui:FindFirstChild(UI_NAME) then
    CoreGui[UI_NAME]:Destroy()
end

-- ==========================================
-- DESIGN UI (Identic cu cerințele tale)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_NAME
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 360, 0, 500)
Main.Position = UDim2.new(0.5, -180, 0.4, -250)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Main)
local Grad = Instance.new("UIGradient")
Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 115, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 115, 20))
})
Grad.Parent = Main

task.spawn(function()
    local rot = 0
    while true do
        Grad.Rotation = rot
        rot = (rot + 1.2) % 360
        RunService.RenderStepped:Wait()
    end
end)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundTransparency = 0.5
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Text = "discord : andyxx7"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -45, 0, 10)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 115, 20)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn)

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -55)
Body.Position = UDim2.new(0, 0, 0, 55)
Body.BackgroundTransparency = 1
Body.Parent = Main

local TurboBtn = Instance.new("TextButton")
TurboBtn.Text = "BLOCK ALL PLAYERS"
TurboBtn.Font = Enum.Font.GothamBold
TurboBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TurboBtn.BackgroundColor3 = Color3.fromRGB(255, 115, 20)
TurboBtn.Size = UDim2.new(1, -30, 0, 45)
TurboBtn.Position = UDim2.new(0, 15, 0, 15)
TurboBtn.Parent = Body
Instance.new("UICorner", TurboBtn)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -120)
Scroll.Position = UDim2.new(0, 10, 0, 75)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 115, 20)
Scroll.Parent = Body

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.Parent = Scroll

-- ==========================================
-- SISTEMUL DE CLICK "INVIZIBIL"
-- ==========================================
local function FormatNum(v)
    local n = tonumber(v) or 0
    if n >= 10^12 then return string.format("%.1fT", n/10^12)
    elseif n >= 10^9 then return string.format("%.1fB", n/10^9)
    elseif n >= 10^6 then return string.format("%.1fM", n/10^6)
    elseif n >= 10^3 then return string.format("%.1fK", n/10^3)
    else return tostring(math.floor(n)) end
end

-- Funcție care forțează click-ul instantaneu
local function InstantConfirm()
    local v = workspace.CurrentCamera.ViewportSize
    local x, y = v.X/2, v.Y/2 + 55
    -- Executăm 5 click-uri instantanee pentru a fi siguri că prindem UI-ul în primul frame
    for i = 1, 5 do
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
    end
end

local function BuildList()
    if IsBlockingSequenceActive then return end
    for _, item in pairs(Scroll:GetChildren()) do if item:IsA("Frame") then item:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            local isWL = table.find(Whitelist, p.UserId)
            local l = p:FindFirstChild("leaderstats")
            local cash = l and (l:FindFirstChild("Cash") or l:FindFirstChild("Money") or l:FindFirstChild("Coins"))
            local reb = l and (l:FindFirstChild("Rebirths") or l:FindFirstChild("Prestige"))

            local Entry = Instance.new("Frame")
            Entry.Size = UDim2.new(1, -5, 0, 85)
            Entry.BackgroundColor3 = isWL and Color3.fromRGB(20, 45, 20) or Color3.fromRGB(20, 20, 20)
            Entry.Parent = Scroll
            Instance.new("UICorner", Entry)

            local Name = Instance.new("TextLabel")
            Name.Text = (isWL and "⭐ " or "") .. p.DisplayName .. " (@" .. p.Name .. ")"
            Name.Font = Enum.Font.GothamBold
            Name.TextColor3 = Color3.fromRGB(255, 255, 255)
            Name.TextSize = 12
            Name.Size = UDim2.new(0.5, 0, 0, 25)
            Name.Position = UDim2.new(0, 12, 0, 10)
            Name.BackgroundTransparency = 1
            Name.TextXAlignment = Enum.TextXAlignment.Left
            Name.Parent = Entry

            local Stats = Instance.new("TextLabel")
            Stats.Text = "Cash: " .. FormatNum(cash and cash.Value or 0) .. " | Reb: " .. (reb and reb.Value or 0)
            Stats.Font = Enum.Font.Gotham
            Stats.TextColor3 = Color3.fromRGB(170, 170, 170)
            Stats.TextSize = 10
            Stats.Size = UDim2.new(0.5, 0, 0, 25)
            Stats.Position = UDim2.new(0, 12, 0, 35)
            Stats.BackgroundTransparency = 1
            Stats.TextXAlignment = Enum.TextXAlignment.Left
            Stats.Parent = Entry

            local B_Block = Instance.new("TextButton")
            B_Block.Text = isWL and "SAFE" or "BLOCK"
            B_Block.Size = UDim2.new(0, 75, 0, 32)
            B_Block.Position = UDim2.new(1, -85, 0, 26)
            B_Block.BackgroundColor3 = isWL and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(190, 40, 40)
            B_Block.Font = Enum.Font.GothamBold
            B_Block.TextColor3 = Color3.fromRGB(255, 255, 255)
            B_Block.Parent = Entry
            Instance.new("UICorner", B_Block)

            local B_WL = Instance.new("TextButton")
            B_WL.Text = isWL and "REMOVE WL" or "WHITELIST"
            B_WL.Size = UDim2.new(0, 85, 0, 32)
            B_WL.Position = UDim2.new(1, -175, 0, 26)
            B_WL.BackgroundColor3 = isWL and Color3.fromRGB(180, 90, 0) or Color3.fromRGB(0, 130, 0)
            B_WL.Font = Enum.Font.GothamBold
            B_WL.TextColor3 = Color3.fromRGB(255, 255, 255)
            B_WL.TextSize = 10
            B_WL.Parent = Entry
            Instance.new("UICorner", B_WL)

            B_Block.MouseButton1Click:Connect(function()
                if not isWL then
                    StarterGui:SetCore("PromptBlockPlayer", p)
                    task.spawn(InstantConfirm)
                end
            end)

            B_WL.MouseButton1Click:Connect(function()
                if isWL then table.remove(Whitelist, table.find(Whitelist, p.UserId))
                else table.insert(Whitelist, p.UserId) end
                BuildList()
            end)
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end

-- ==========================================
-- ACTIONS (BLOCK ALL ULTRA SPEED)
-- ==========================================
TurboBtn.MouseButton1Click:Connect(function()
    if IsBlockingSequenceActive then return end
    IsBlockingSequenceActive = true
    TurboBtn.Text = "EXECUTING..."
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and not table.find(Whitelist, p.UserId) then
            StarterGui:SetCore("PromptBlockPlayer", p)
            -- Lansăm click-ul pe un thread separat ca să nu aștepte block-ul următor
            task.spawn(InstantConfirm)
            task.wait(0.02) -- Delay minim pentru a nu bloca motorul UI
        end
    end
    
    IsBlockingSequenceActive = false
    TurboBtn.Text = "BLOCK ALL PLAYERS"
    BuildList()
end)

local m = false
MinBtn.MouseButton1Click:Connect(function()
    m = not m
    Main:TweenSize(m and UDim2.new(0, 360, 0, 55) or UDim2.new(0, 360, 0, 500), "Out", "Quart", 0.3, true)
    Body.Visible = not m
    MinBtn.Text = m and "+" or "-"
end)

Players.PlayerAdded:Connect(BuildList)
Players.PlayerRemoving:Connect(BuildList)
task.spawn(function() while true do task.wait(20) if not m and not IsBlockingSequenceActive then BuildList() end end end)

BuildList()
print("Elite V11 - ULTRA SPEED LOADED")
