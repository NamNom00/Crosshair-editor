-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Constants
local CROSSHAIR_URLS = {
    "rbxassetid://5681283757", -- Regular crosshair
    "rbxassetid://95285133056919", -- Red crosshair
    "rbxassetid://17459159283", -- Test crosshair
    "rbxassetid://358650041" -- Blue crosshair
}

local CROSSHAIR_NAMES = {
    "Default",
    "Red",
    "Test",
    "Blue"
}

-- Create UI
local TextureChangerUI = Instance.new("ScreenGui")
TextureChangerUI.Name = "CrosshairTextureChanger"
TextureChangerUI.ResetOnSpawn = false
TextureChangerUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TextureChangerUI.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = TextureChangerUI

-- Round corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Round TitleBar corners
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Fix rounded corners with a Frame
local CornerFix = Instance.new("Frame")
CornerFix.Name = "CornerFix"
CornerFix.Size = UDim2.new(1, 0, 0.5, 0)
CornerFix.Position = UDim2.new(0, 0, 0.5, 0)
CornerFix.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CornerFix.BorderSizePixel = 0
CornerFix.Parent = TitleBar

-- Title text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -60, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Crosshair Texture Changer"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✖"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

-- Minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = TitleBar

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Preview Label
local PreviewLabel = Instance.new("TextLabel")
PreviewLabel.Name = "PreviewLabel"
PreviewLabel.Size = UDim2.new(1, 0, 0, 25)
PreviewLabel.BackgroundTransparency = 1
PreviewLabel.Text = "Current Crosshair Preview:"
PreviewLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PreviewLabel.TextSize = 16
PreviewLabel.Font = Enum.Font.SourceSansSemibold
PreviewLabel.Parent = ContentFrame

-- Crosshair Preview
local PreviewFrame = Instance.new("Frame")
PreviewFrame.Name = "PreviewFrame"
PreviewFrame.Size = UDim2.new(1, 0, 0, 100)
PreviewFrame.Position = UDim2.new(0, 0, 0, 30)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PreviewFrame.BorderSizePixel = 0
PreviewFrame.Parent = ContentFrame

local UICornerPreview = Instance.new("UICorner")
UICornerPreview.CornerRadius = UDim.new(0, 6)
UICornerPreview.Parent = PreviewFrame

local CrosshairPreview = Instance.new("ImageLabel")
CrosshairPreview.Name = "CrosshairPreview"
CrosshairPreview.Size = UDim2.new(0, 50, 0, 50)
CrosshairPreview.Position = UDim2.new(0.5, -25, 0.5, -25)
CrosshairPreview.BackgroundTransparency = 1
CrosshairPreview.Image = CROSSHAIR_URLS[1]
CrosshairPreview.Parent = PreviewFrame

-- Options Label
local OptionsLabel = Instance.new("TextLabel")
OptionsLabel.Name = "OptionsLabel"
OptionsLabel.Size = UDim2.new(1, 0, 0, 25)
OptionsLabel.Position = UDim2.new(0, 0, 0, 140)
OptionsLabel.BackgroundTransparency = 1
OptionsLabel.Text = "Available Crosshairs:"
OptionsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OptionsLabel.TextSize = 16
OptionsLabel.Font = Enum.Font.SourceSansSemibold
OptionsLabel.Parent = ContentFrame

-- Create buttons for each crosshair
for i, url in ipairs(CROSSHAIR_URLS) do
    local CrosshairButton = Instance.new("TextButton")
    CrosshairButton.Name = "Crosshair" .. i
    CrosshairButton.Size = UDim2.new(0.48, 0, 0, 60)
    CrosshairButton.Position = UDim2.new(
        i % 2 == 1 and 0 or 0.52, 
        0, 
        0, 
        175 + math.floor((i-1)/2) * 70
    )
    CrosshairButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CrosshairButton.BorderSizePixel = 0
    CrosshairButton.Text = ""
    CrosshairButton.Parent = ContentFrame
    
    local UICornerButton = Instance.new("UICorner")
    UICornerButton.CornerRadius = UDim.new(0, 6)
    UICornerButton.Parent = CrosshairButton
    
    local CrosshairImage = Instance.new("ImageLabel")
    CrosshairImage.Name = "CrosshairImage"
    CrosshairImage.Size = UDim2.new(0, 30, 0, 30)
    CrosshairImage.Position = UDim2.new(0, 10, 0.5, -15)
    CrosshairImage.BackgroundTransparency = 1
    CrosshairImage.Image = url
    CrosshairImage.Parent = CrosshairButton
    
    local CrosshairText = Instance.new("TextLabel")
    CrosshairText.Name = "CrosshairText"
    CrosshairText.Size = UDim2.new(1, -50, 1, 0)
    CrosshairText.Position = UDim2.new(0, 50, 0, 0)
    CrosshairText.BackgroundTransparency = 1
    CrosshairText.Text = CROSSHAIR_NAMES[i]
    CrosshairText.TextColor3 = Color3.fromRGB(255, 255, 255)
    CrosshairText.TextSize = 14
    CrosshairText.Font = Enum.Font.SourceSans
    CrosshairText.TextXAlignment = Enum.TextXAlignment.Left
    CrosshairText.Parent = CrosshairButton
    
    -- Button click handler
    CrosshairButton.MouseButton1Click:Connect(function()
        CrosshairPreview.Image = url
        
        -- Find and update the actual crosshair in the game
        local gameUI = game:GetService("Players").LocalPlayer.PlayerGui
        local crosshairUI = gameUI:FindFirstChild("Crosshair")
        
        if crosshairUI and crosshairUI:FindFirstChild("Crosshair") then
            local crosshairImage = crosshairUI.Crosshair
            if crosshairImage:IsA("ImageLabel") then
                crosshairImage.Image = url
            end
        else
            print("Crosshair UI not found. Path may have changed.")
        end
    end)
end

-- Status text
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 1, -20)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ready to use"
StatusText.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.SourceSans
StatusText.Parent = ContentFrame

-- Make UI draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close and minimize functionality
local minimized = false
local originalSize = MainFrame.Size

CloseButton.MouseButton1Click:Connect(function()
    TextureChangerUI:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        -- Restore
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = originalSize})
        tween:Play()
        
        ContentFrame.Visible = true
        MinimizeButton.Text = "−"
    else
        -- Minimize
        originalSize = MainFrame.Size
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 30)})
        tween:Play()
        
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    end
    
    minimized = not minimized
end)

-- Try to find and check the crosshair on load
task.spawn(function()
    wait(1) -- Wait for UI to load
    local gameUI = game:GetService("Players").LocalPlayer.PlayerGui
    local crosshairUI = gameUI:WaitForChild("Crosshair", 5)
    
    if crosshairUI and crosshairUI:FindFirstChild("Crosshair") then
        StatusText.Text = "Crosshair found successfully"
        StatusText.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StatusText.Text = "Crosshair not found. Path may have changed."
        StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
