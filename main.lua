local Players = game:GetService("Players")
local UserService = game:GetService("UserService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- تنظيف أي واجهة سابقة
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("WTAutoSpooferAllInOne") then
        game:GetService("CoreGui").WTAutoSpooferAllInOne:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WTAutoSpooferAllInOne"
local successParent, _ = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not successParent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 540)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -270)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 2.5
UIStroke.Color = Color3.fromRGB(150, 50, 255)

-- أنيميشن ألوان الإضاءة النيون
task.spawn(function()
    while task.wait(0.05) do
        local hue = (tick() % 5) / 5
        UIStroke.Color = Color3.fromHSV(hue, 0.8, 1)
    end
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 42)
Title.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
Title.Text = "👑 WAR TYCOON // FULL AUTO SPOOFER (L للإخفاء)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- قائمة التمرير الفرعية
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(0.92, 0, 0, 420)
Scroll.Position = UDim2.new(0.04, 0, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 580)
Scroll.ScrollBarThickness = 4

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 6)

local function createInput(placeholder)
    local box = Instance.new("TextBox", Scroll)
    box.Size = UDim2.new(1, 0, 0, 34)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    return box
end

-- عناصر الإدخال والتزوير
local TargetIdBox = createInput("أدخل ID الحساب للنسخ التلقائي...")

-- قائمة اللاعبين المتواجدين بالسيرفر
local ServerLabel = Instance.new("TextLabel", Scroll)
ServerLabel.Size = UDim2.new(1, 0, 0, 18)
ServerLabel.Text = "👥 أو اختر لاعباً من السيرفر مباشرة:"
ServerLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
ServerLabel.BackgroundTransparency = 1
ServerLabel.Font = Enum.Font.GothamBold
ServerLabel.TextSize = 11
ServerLabel.TextXAlignment = Enum.TextXAlignment.Left

local ServerList = Instance.new("ScrollingFrame", Scroll)
ServerList.Size = UDim2.new(1, 0, 0, 110)
ServerList.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ServerList.CanvasSize = UDim2.new(0, 0, 0, 0)
ServerList.ScrollBarThickness = 3
Instance.new("UICorner", ServerList).CornerRadius = UDim.new(0, 8)

local ServerListLayout = Instance.new("UIListLayout", ServerList)
ServerListLayout.Padding = UDim.new(0, 2)

local function UpdateServerList()
    for _, child in pairs(ServerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local players = Players:GetPlayers()
    ServerList.CanvasSize = UDim2.new(0, 0, 0, #players * 28)
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton", ServerList)
            btn.Size = UDim2.new(1, -4, 0, 26)
            btn.Position = UDim2.new(0, 2, 0, 0)
            btn.Text = "  " .. player.Name .. " (" .. player.DisplayName .. ")"
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 11
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                TargetIdBox.Text = tostring(player.UserId)
                for _, b in pairs(ServerList:GetChildren()) do
                    if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30, 30, 40) end
                end
                btn.BackgroundColor3 = Color3.fromRGB(130, 40, 220)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
        end
    end
end

UpdateServerList()
Players.PlayerAdded:Connect(UpdateServerList)
Players.PlayerRemoving:Connect(UpdateServerList)

-- باقي خانات القيم
local RebirthBox = createInput("الريبرث Rebirths (تلقائي/أدخل قيمة)...")
local CashBox = createInput("الفلوس Cash (تلقائي/مثال: 1.50B+)...")
local LevelBox = createInput("اللفل Level (مثال: 100)...")
local ClanBox = createInput("الكلان Clan Tag (تلقائي/مثال: PRO)...")
local KillsBox = createInput("القتلات Kills (تلقائي/مثال: 150)...")
local DeathsBox = createInput("الوفيات Deaths (تلقائي/مثال: 0)...")

-- زر التنفيذ والتقمص الشامل
local ApplyBtn = Instance.new("TextButton", MainFrame)
ApplyBtn.Size = UDim2.new(0.92, 0, 0, 45)
ApplyBtn.Position = UDim2.new(0.04, 0, 0, 480)
ApplyBtn.Text = "🚀 تطبيق التزوير الشامل وإعادة التحديث"
ApplyBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyBtn.Font = Enum.Font.GothamBold
ApplyBtn.TextSize = 13
Instance.new("UICorner", ApplyBtn).CornerRadius = UDim.new(0, 8)

ApplyBtn.MouseButton1Click:Connect(function()
    local targetId = tonumber(TargetIdBox.Text)
    if not targetId then
        Title.Text = "⚠️ أدخل ID الحساب أو اختر لاعباً من السيرفر أولاً!"
        task.wait(2.5)
        Title.Text = "👑 WAR TYCOON // FULL AUTO SPOOFER (L للإخفاء)"
        return
    end

    Title.Text = "⏳ جاري سحب وتطبيق كافة البيانات بالكامل..."

    task.spawn(function()
        local fetchedUsername = ""
        local fetchedDisplayName = ""

        -- 1. جلب الاسم واليوزر من ID روبلوكس
        pcall(function()
            fetchedUsername = Players:GetNameFromUserIdAsync(targetId)
            local userInfo = UserService:GetUserInfosByUserIdsAsync({targetId})
            if userInfo and userInfo[1] then
                fetchedDisplayName = userInfo[1].DisplayName
            end
        end)

        if fetchedUsername == "" then fetchedUsername = "Player_" .. targetId end
        if fetchedDisplayName == "" then fetchedDisplayName = fetchedUsername end

        -- 2. تطبيق الاسم واليوزر محلياً
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.DisplayName = fetchedDisplayName end
        LocalPlayer.Name = fetchedUsername

        -- 3. جلب وتطبيق السكن كاملاً
        pcall(function()
            local desc = Players:GetHumanoidDescriptionFromUserId(targetId)
            if desc and hum then hum:ApplyDescription(desc) end
        end)

        -- 4. تعديل الكلان فوق الشخصية
        if ClanBox.Text ~= "" then
            local head = char:FindFirstChild("Head")
            if head then
                for _, gui in pairs(head:GetDescendants()) do
                    if gui:IsA("TextLabel") then gui.Text = "[" .. ClanBox.Text .. "]" end
                end
            end
        end

        -- 5. تحديث كافة قيم War Tycoon في القائمة (Scoreboard / Leaderboard)
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if playerGui then
            for _, gui in pairs(playerGui:GetDescendants()) do
                if gui:IsA("TextLabel") then
                    local text = gui.Text
                    if text == LocalPlayer.Name or text == LocalPlayer.DisplayName or text:find(LocalPlayer.Name) then
                        local parent = gui.Parent
                        if parent then
                            for _, child in pairs(parent:GetChildren()) do
                                if child:IsA("TextLabel") then
                                    local cName = child.Name:lower()
                                    local cText = child.Text

                                    -- اسم اللاعب
                                    if child == gui or cName:find("name") or child.LayoutOrder == 1 then
                                        child.Text = fetchedDisplayName
                                    end

                                    -- الريبرث
                                    if RebirthBox.Text ~= "" and (cName:find("rebirth") or child.LayoutOrder == 3) then
                                        child.Text = RebirthBox.Text
                                    end

                                    -- الفلوس
                                    if CashBox.Text ~= "" and (cName:find("cash") or cText:find("%$") or cText:find("M%+") or cText:find("B%+") or child.LayoutOrder == 4) then
                                        child.Text = CashBox.Text
                                    end

                                    -- اللفل
                                    if LevelBox.Text ~= "" and (cName:find("level") or cName:find("lvl")) then
                                        child.Text = "Lvl " .. LevelBox.Text
                                    end

                                    -- القتلات
                                    if KillsBox.Text ~= "" and (cName:find("kill") or child.LayoutOrder == 5) then
                                        child.Text = KillsBox.Text
                                    end

                                    -- الوفيات
                                    if DeathsBox.Text ~= "" and (cName:find("death") or child.LayoutOrder == 6) then
                                        child.Text = DeathsBox.Text
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        Title.Text = "✅ تم تزوير كامل حساب (" .. fetchedDisplayName .. ") بنجاح!"
        task.wait(3)
        Title.Text = "👑 WAR TYCOON // FULL AUTO SPOOFER (L للإخفاء)"
    end)
end)

-- اختصار الإخفاء بحرف L
UserInputService.InputBegan:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.L then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
