-- Dead Rails Crosshair Changer
-- Created for Dead Rails game only

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Crosshair IDs
local crosshairs = {
    {name = "Crosshair 1", id = "358650041"},
    {name = "Crosshair 2", id = "17459159283"},
    {name = "Crosshair 3", id = "95285133056919"}
}

-- GUI Elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local CrosshairList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local DefaultButton = Instance.new("TextButton")

-- Variables
local isDragging = false
local dragStart = nil
local startPos = nil
local currentCrosshair = nil
local originalCrosshair = nil
local originalCrosshairParent = nil
local customCrosshair = nil

-- Core UI Setup
ScreenGui.Name = "CrosshairChangerGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.ClipsDescendants = true
MainFrame.Active = true

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Size = UDim2.new(1, -60, 1, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "Crosshair Changer"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 18

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.Size = UDim2.new(1, 0, 1, -30)

CrosshairList.Name = "CrosshairList"
CrosshairList.Parent = ContentFrame
CrosshairList.Active = true
CrosshairList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CrosshairList.BorderSizePixel = 0
CrosshairList.Position = UDim2.new(0, 10, 0, 10)
CrosshairList.Size = UDim2.new(1, -20, 1, -20)
CrosshairList.CanvasSize = UDim2.new(0, 0, 0, 0)
CrosshairList.ScrollBarThickness = 6

UIListLayout.Parent = CrosshairList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Create Crosshair Button
local function CreateCrosshairButton(name, id, index)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    container.BorderSizePixel = 0
    container.Size = UDim2.new(1, -10, 0, 60)
    container.LayoutOrder = index
    container.Parent = CrosshairList
    
    local previewFrame = Instance.new("Frame")
    previewFrame.Name = "Preview"
    previewFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    previewFrame.BorderSizePixel = 0
    previewFrame.Position = UDim2.new(0, 5, 0, 5)
    previewFrame.Size = UDim2.new(0, 50, 0, 50)
    previewFrame.Parent = container
    
    local previewImage = Instance.new("ImageLabel")
    previewImage.Name = "PreviewImage"
    previewImage.BackgroundTransparency = 1
    previewImage.Position = UDim2.new(0, 5, 0, 5)
    previewImage.Size = UDim2.new(1, -10, 1, -10)
    previewImage.Image = "rbxassetid://" .. id
    previewImage.Parent = previewFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 65, 0, 5)
    nameLabel.Size = UDim2.new(1, -135, 0, 20)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = container
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Name = "IDLabel"
    idLabel.BackgroundTransparency = 1
    idLabel.Position = UDim2.new(0, 65, 0, 25)
    idLabel.Size = UDim2.new(1, -135, 0, 20)
    idLabel.Font = Enum.Font.SourceSans
    idLabel.Text = "ID: " .. id
    idLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    idLabel.TextSize = 14
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Parent = container
    
    local selectButton = Instance.new("TextButton")
    selectButton.Name = "SelectButton"
    selectButton.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
    selectButton.BorderSizePixel = 0
    selectButton.Position = UDim2.new(1, -60, 0.5, -15)
    selectButton.Size = UDim2.new(0, 50, 0, 30)
    selectButton.Font = Enum.Font.SourceSansBold
    selectButton.Text = "Apply"
    selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectButton.TextSize = 14
    selectButton.Parent = container
    
    selectButton.MouseButton1Click:Connect(function()
        ApplyCrosshair(id)
    end)
    
    return container
end

-- Default Crosshair Button
DefaultButton.Name = "DefaultButton"
DefaultButton.Parent = CrosshairList
DefaultButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DefaultButton.BorderSizePixel = 0
DefaultButton.Size = UDim2.new(1, -10, 0, 40)
DefaultButton.Font = Enum.Font.SourceSansBold
DefaultButton.Text = "Restore Default Crosshair"
DefaultButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DefaultButton.TextSize = 16
DefaultButton.LayoutOrder = 0

DefaultButton.MouseButton1Click:Connect(function()
    RestoreDefaultCrosshair()
end)

-- Functions to handle crosshair swapping
function CheckForCrosshair()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not playerGui then
        warn("PlayerGui not found")
        return false
    end
    
    local crosshairGui = playerGui:FindFirstChild("Crosshair")
    if not crosshairGui then
        warn("Crosshair GUI not found")
        return false
    end
    
    originalCrosshair = crosshairGui
    originalCrosshairParent = crosshairGui.Parent
    return true
end

function ApplyCrosshair(id)
    if not CheckForCrosshair() then
        return
    end
    
    -- Remove existing custom crosshair if present
    if customCrosshair then
        customCrosshair:Destroy()
        customCrosshair = nil
    end
    
    -- Hide original crosshair
    if originalCrosshair then
        originalCrosshair.Enabled = false
    end
    
    -- Create new crosshair
    customCrosshair = Instance.new("ScreenGui")
    customCrosshair.Name = "CustomCrosshair"
    customCrosshair.ResetOnSpawn = false
    customCrosshair.Parent = game:GetService("CoreGui")
    
    local crosshairImage = Instance.new("ImageLabel")
    crosshairImage.Name = "CrosshairImage"
    crosshairImage.BackgroundTransparency = 1
    crosshairImage.Position = UDim2.new(0.5, -25, 0.5, -25)
    crosshairImage.Size = UDim2.new(0, 50, 0, 50)
    crosshairImage.Image = "rbxassetid://" .. id
    crosshairImage.Parent = customCrosshair
    
    currentCrosshair = id
    
    -- Feedback notification
    ShowNotification("Crosshair applied: " .. id)
end

function RestoreDefaultCrosshair()
    if originalCrosshair then
        originalCrosshair.Enabled = true
    end
    
    if customCrosshair then
        customCrosshair:Destroy()
        customCrosshair = nil
    end
    
    currentCrosshair = nil
    
    ShowNotification("Default crosshair restored")
end

function ShowNotification(text)
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notification.BorderSizePixel = 0
    notification.Position = UDim2.new(0.5, -100, 0.8, 0)
    notification.Size = UDim2.new(0, 200, 0, 40)
    notification.Parent = ScreenGui
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "NotificationText"
    notificationText.BackgroundTransparency = 1
    notificationText.Position = UDim2.new(0, 5, 0, 0)
    notificationText.Size = UDim2.new(1, -10, 1, 0)
    notificationText.Font = Enum.Font.SourceSans
    notificationText.Text = text
    notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationText.TextSize = 16
    notificationText.Parent = notification
    
    -- Fade out after 2 seconds
    spawn(function()
        wait(2)
        for i = 1, 10 do
            notification.BackgroundTransparency = i / 10
            notificationText.TextTransparency = i / 10
            wait(0.05)
        end
        notification:Destroy()
    end)
end

-- Dragging Functionality
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Initialize crosshair buttons
for i, crosshair in ipairs(crosshairs) do
    CreateCrosshairButton(crosshair.name, crosshair.id, i)
end

-- Update canvas size
CrosshairList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)

-- Check if we're in the right game
local function CheckGame()
    if game.PlaceId ~= 326546526 then  -- Assuming this is Dead Rails PlaceId
        ShowNotification("Warning: This script is designed for Dead Rails only.")
    end
end

-- Check if crosshair exists when player loads
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    CheckForCrosshair()
    
    -- Reapply current crosshair if one was selected
    if currentCrosshair then
        ApplyCrosshair(currentCrosshair)
    end
end)

-- Initial setup
CheckGame()
if LocalPlayer.Character then
    CheckForCrosshair()
end

-- Clean up when script is terminated
local function cleanup()
    RestoreDefaultCrosshair()
    if ScreenGui then
        ScreenGui:Destroy()
    end
end

return cleanup
