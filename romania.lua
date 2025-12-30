-- [[ ANDYXHUB - MODERN UI: TP & AUTOCOLECT ALL ]] --
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

local autoCollectEnabled = false

-- LISTA COMPLETA
local targetNames = {"Strawberelli Flamingelli", "Trippi Trapoppi", "Tim Cheese", "Pinealotto Fruttarino", "Noobinni Pizzanini", "Boneca Ambalabu", "Sigma Girl", "Chimpanzini Bananini", "Bruto Gialutto", "Frigo Camelo", "Malame Amarele", "Sigma Boy", "Salamino Penguino", "Gangster Footera", "Talpa Di Fero", "Pipi Watermelon", "Caramello Filtrello", "Avocadini Antilopini", "Tric Trac Barbaboom", "Tralaero Tralala", "Yess My Examine", "Los 67", "Extinct Ballerina", "Extinct Tralaero", "Extinct Matteo", "La Extinct Grande", "Bambini Crostini", "Lionel Cactuseli", "Tirilikalika Tirilikalako", "Trulimero Trulicina", "Brri Brri Bicus Dicus Bombicus", "Los Noobinis", "Trippi Troppi Troppa Trippa", "Pakrahatemamat", "Ketupat Kepat", "Toiletto Focaccino", "Avocadini Guffo", "Cavallo Virtuoso", "Cachorrito Melonito", "Wombbo Rollo", "Bandito Axolito", "Fragola La La La", "Svinina Bombardino", "Burbaloni Loliloli", "Mangolini Parrocini", "Bandito Babritto", "Perochello Lemonchello", "Pipi Kiwi", "Pipi Corni", "Brr Brr Patapim", "Quivioli Ameleonni", "Dug Dug Dug", "Los Hotspotsitos", "Signore Carapace", "Espresso Signora", "Tractoro Dinosauro", "Cocosini Mama", "Kruppuk Pagi Pagi", "Rang Ring Reng Bus", "Horgini Boom", "Meowl", "Tob Tobi Tobi", "Tictac Sahur", "Chimpanzini Spiderini", "To To To Sahur", "Trenostruzzo Turbo 4000", "Perrito Burrito", "Money Money Puggy", "Tukanno Bananno", "Bombardini Tortinii", "Corn Corn Sahur", "Frioo Ninja", "Chef Crabracadabra", "Brasilini Berimbini", "Girafa Celestre", "Antonio", "Anpali Babel", "Gattatino nyanino", "Pandaccini Bananini", "Snailenzo", "Banbu Sahur", "Matteo", "Dul Dul Dul", "Lasahur Combinasion", "Los Matteos", "Tracoducotulu Delape Ladustuz", "Penguino Cocosino", "Lerulerulerule", "Avocadorilla", "Celuarcini Viciosini", "Garama And Madundung", "Chachechi", "Ballerina Cappuccina", "Los Karkeritos", "Karekerkar Kurkur", "La Karkerkar Combinasion", "Agarrini La Palini", "Ballerino Lololo", "Chicleteira Bicicleteira", "Los Chicleteiras", "Chicleteirina Bicicleteirina", "Orcalita Orcala", "La Cucaracha", "Unclito Samito", "Urubini Flamenguini", "Las Cappuchinas", "Job Job Job Sahur", "Los Jobcitos", "Cacasito Satalito", "Bisonte Giuppitere", "Las Vaquitas Saturnitas", "Los Crocodillitos", "Los Tortus", "Tartaruga Cisterna", "Bananita Dolphinita", "Rhino Toasterino", "Cacto Hipopotamo", "Las Tralateritas", "Tralalita Tralala", "Pakrahmatmatcita", "Orangutini Ananassini", "Elefanto Frigo", "Bombardiro Crocodilo", "Los Bros", "Las Sis", "Tralaedon", "Los Primos", "Tentacolo Tecnico", "Boatito Auratito", "Tang Tang Keletang", "Gattatino Neonino", "Ganganzelli Silverini", "Los Orcalitos", "Los Tralaleritos", "Los Combinasionas", "Ti Ti Ti Sahur", "Los Mobils", "Te Te Te Sahur", "Gorillo Watermelondrillo", "Gorillo Subwoofero", "Capi Taco", "Tipi Topi Taco", "Nooo My Hotspot", "Tacorita Bicicleta", "La Tacos Combinasion", "Los Tacoritas", "Ta Ta Ta Ta Sahur", "Blueberrinni Octopusini", "Karker Sahur", "Bombombini Gusini", "Glorbo Fruttodrillo", "Odin Din Din Dun", "Rhino Helicopterino", "Piccionetta Macchina", "Los Tungtungtungcitos", "Burguro And Fryuro", "Squalanana", "Mariachi Corzazon", "Aquanauta", "1x1x1x1", "Guest 666", "Tigrilini Watermelini", "Spioniro Golubiro", "Zibra Zubra Zibralini", "Carrotini Brainini", "Bananito Bandito", "Mythic Lucky Block", "Taco Lucky Block", "Brainrot God Lucky Block", "Secret Lucky Block", "Torrtuginni Dragonfrutini", "Esok Sekolah", "Pot Hotspot", "Spaghetti Tualetti", "La Secret Combinasion", "Los Tipi Tacos", "Chihuannini Taconini", "Gattito Tacoto", "Los Nooo My Hotspotsitos", "Quesadilla Crocodila", "Burritto Bandito", "Orcalero Orcala", "Tigroligre Frutonni", "Mastodontico Telepiedone", "Bulbito Bandito Traktorito", "Pop Pop Sahur", "Carloo", "Blackhole Goat", "Alessio", "Los Bombinitos", "Guerriro Digitale", "Crabbo Limonetta", "La Grande Combinasion", "67", "Trenostruzzo Turbo 3000", "Stautino Libertino", "La Vacca Saturno Saturnita", "Chillin Chili", "Piccione Maccina", "La Supreme Combinasion", "Brr Es Teh Patipum", "Graipusseni Medussini", "Belula Beluga", "Ketchuru And Musturu", "Dragon Cannelloni", "Muclearo Dinossauro", "Chipsoso And Quesoso", "Capitan Moby", "Strawberry Elephant", "Noo My Examine", "Mieteira Bicicleteira", "Quesadilla Vampira", "Boatito Auratito", "Doi Do Do", "Cupcake Koalaa", "Money Money Mann", "Clickerino Crab", "Pirulitoita Bicicletairea", "Noo La Poliziaaa", "Los Puggiess", "Fragama And Chocrama", "Los Spaghetti", "Pipi Avocado", "Pipi Patato", "Cappuccino Assassino", "Jackorilla", "Cappuccino Clownnino", "Mummy Ambalaboo", "Pumpkinni Spyderini", "Telemort", "Trickollino", "Los Spooky Combanasionias", "Skull Skul Skull", "Noo My Candy", "Headless Horseman", "Mummio Rappitto", "Quackula", "Jacko Spaventosa", "Jacko Jack Jak", "La Vacca Jacko Linterinno", "Spooky And Pumpkin", "Vultureno Skeleton", "Magi Ribitini", "Zombie Tralalero", "Frankenteo", "Pot Pumpkine", "Swag Soda", "Los Quesadillas", "Orcaledon", "Los Chihuanninis", "Centrucci Nuclucci", "Los Gattitos", "Los Burritos", "Los Cucarachas", "Puffaball", "Granchiello Spiritell", "Guadramat And Pakrahmatmamat", "Lavadorito Spinito", "Gobblino Uniciclino", "Fishino Clownino", "Los Planitos", "W Or L", "Ballerina Peppermintina", "Giftini Spyderini", "Cooki And Milki", "25", "Tung Tung Tung Sahur", "Coffin Tung Tung Tung Sahur", "Noobini Santanini", "Penguin Tree", "Sealo Regalo", "Jingle Jingle Sahur", "Frogo Elfo", "Please My Present", "Ginger Globo", "Chocco Bunny", "La Vacca Prese Presente", "Chicleteira Noelteira", "Santteo", "Ho Ho Ho Sahur", "Reindeer Tralala", "Ginger Cisterna", "Yeti Claus", "Tree Tree Tree Sahur", "La Jolly Grande", "List List List Sahur", "Buho De Noelo", "Chrismasmamat", "Triplito Tralaleritos", "Pandanini Frostini", "Santa Hotspot", "Los 25", "Naughty Naughty", "Reinito Sleighito", "Noo My Present", "Cocoa Assassino", "Los Candies", "Chimnino", "Gingerat Gerat", "Swaggy Bros", "La Og Combinazione", "La Ginger Sekolah", "Donkeyturbo Express", "Bunnyman", "Dragon Gingerrino", "Sammyy"}

-- UI PRINCIPALA
local ScreenGui = Instance.new("ScreenGui", CoreGui)

-- LOADING TEXT (Fara fundal negru)
local LoadingLabel = Instance.new("TextLabel", ScreenGui)
LoadingLabel.Size = UDim2.new(0, 300, 0, 50)
LoadingLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.Text = "AndyxHUB Loading"
LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingLabel.Font = Enum.Font.GothamBold
LoadingLabel.TextSize = 35
LoadingLabel.ZIndex = 100

-- FRAME MENIU
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 500); Main.Position = UDim2.new(0.5, -175, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true; Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- HEADER
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30); Title.Position = UDim2.new(0, 15, 0, 10)
Title.Text = "🔥 ANDYXHUB - https://discord.gg/TBeX3sYy"; Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 12; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.BackgroundTransparency = 1

local InfoLabel = Instance.new("TextLabel", Main)
InfoLabel.Size = UDim2.new(1, -30, 0, 20); InfoLabel.Position = UDim2.new(0, 15, 0, 35)
InfoLabel.Text = "U CAN FIND ONLY 201 BRAINROTS (REST ARE LIMITED)"; InfoLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
InfoLabel.Font = Enum.Font.Gotham; InfoLabel.TextSize = 9; InfoLabel.TextXAlignment = Enum.TextXAlignment.Left; InfoLabel.BackgroundTransparency = 1

-- SCROLL AREA
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -150); Scroll.Position = UDim2.new(0, 10, 0, 70); Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll); Layout.Padding = UDim.new(0, 8)

-- FUNCTIE TELEPORT
local function smartTeleport(targetPart)
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local root = LP.Character.HumanoidRootPart
        root.Anchored = false
        root.CFrame = targetPart.CFrame * CFrame.new(0, -1, 0)
        task.wait(0.1)
        root.Anchored = true
        task.wait(0.4)
        root.Anchored = false
    end
end

-- CREARE CARDURI
for _, name in pairs(targetNames) do
    local Card = Instance.new("Frame", Scroll)
    Card.Size = UDim2.new(1, -10, 0, 60); Card.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", Card)
    
    local Line = Instance.new("Frame", Card)
    Line.Size = UDim2.new(1, 0, 0, 2); Line.Position = UDim2.new(0, 0, 1, -2); Line.BackgroundColor3 = Color3.fromRGB(255, 50, 50); Line.BorderSizePixel = 0

    local Icon = Instance.new("TextLabel", Card)
    Icon.Text = "$"; Icon.Size = UDim2.new(0, 30, 0, 30); Icon.Position = UDim2.new(0, 10, 0, 15); Icon.TextColor3 = Color3.fromRGB(0, 255, 100); Icon.Font = Enum.Font.GothamBold; Icon.TextSize = 18; Icon.BackgroundTransparency = 1

    local NameLabel = Instance.new("TextLabel", Card)
    NameLabel.Text = name; NameLabel.Size = UDim2.new(0, 180, 0, 40); NameLabel.Position = UDim2.new(0, 45, 0, 10); NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255); NameLabel.Font = Enum.Font.GothamBold; NameLabel.TextSize = 13; NameLabel.TextXAlignment = Enum.TextXAlignment.Left; NameLabel.BackgroundTransparency = 1

    local TpBtn = Instance.new("TextButton", Card)
    TpBtn.Size = UDim2.new(0, 60, 0, 30); TpBtn.Position = UDim2.new(1, -70, 0.5, -15); TpBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 255); TpBtn.Text = "TP"; TpBtn.TextColor3 = Color3.new(1, 1, 1); TpBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", TpBtn)

    TpBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent and (v.Parent.Name == name or (v.Parent:FindFirstChildWhichIsA("BillboardGui", true) and v.Parent:FindFirstChildWhichIsA("BillboardGui", true):FindFirstChildWhichIsA("TextLabel").Text == name)) then
                smartTeleport(v.Parent)
                break
            end
        end
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, #targetNames * 68)

-- BUTON AUTOCOLECT
local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(1, -30, 0, 50); ToggleBtn.Position = UDim2.new(0, 15, 1, -65); ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); ToggleBtn.Text = "AutoColect ALL: OFF"; ToggleBtn.TextColor3 = Color3.new(1, 1, 1); ToggleBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", ToggleBtn)

ToggleBtn.MouseButton1Click:Connect(function()
    autoCollectEnabled = not autoCollectEnabled
    if autoCollectEnabled then
        ToggleBtn.Text = "AutoColect ALL: ON"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "AutoColect ALL: OFF"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.Anchored = false end
    end
end)

-- LOGICA AUTO-COLLECT
task.spawn(function()
    while task.wait(0.5) do
        if autoCollectEnabled then
            for _, v in pairs(workspace:GetDescendants()) do
                if not autoCollectEnabled then break end
                if v:IsA("TouchTransmitter") and v.Parent then
                    local isBrainrot = false
                    for _, n in pairs(targetNames) do
                        if v.Parent.Name == n then isBrainrot = true break end
                    end
                    if isBrainrot or v.Parent:FindFirstChildWhichIsA("BillboardGui", true) then
                        smartTeleport(v.Parent)
                    end
                end
            end
        end
    end
end)

-- LOGICA LOADING (Text animat)
task.spawn(function()
    for i = 1, 3 do
        LoadingLabel.Text = "AndyxHUB Loading."
        task.wait(0.4)
        LoadingLabel.Text = "AndyxHUB Loading.."
        task.wait(0.4)
        LoadingLabel.Text = "AndyxHUB Loading..."
        task.wait(0.4)
    end
    
    -- Efect de disparitie lina
    TweenService:Create(LoadingLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.5)
    LoadingLabel:Destroy()
    
    -- Afisare meniu
    Main.Visible = true
end)
