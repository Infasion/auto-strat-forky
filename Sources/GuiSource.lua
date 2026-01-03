local user_input_service = game:GetService("UserInputService")
local local_player = game.Players.LocalPlayer
local gui_parent = gethui and gethui() or game:GetService("CoreGui")

local old_gui = gui_parent:FindFirstChild("TDSGui")
if old_gui then old_gui:Destroy() end

local tds_gui = Instance.new("ScreenGui")
tds_gui.Name = "TDSGui"
tds_gui.Parent = gui_parent
tds_gui.ResetOnSpawn = false
tds_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local main_frame = Instance.new("Frame")
main_frame.Name = "MainFrame"
main_frame.Parent = tds_gui
main_frame.Size = UDim2.new(0, 380, 0, 320)
main_frame.Position = UDim2.new(0.5, -190, 0.5, -160)
main_frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main_frame.BorderSizePixel = 0
main_frame.Active = true

local main_corner = Instance.new("UICorner", main_frame)
main_corner.CornerRadius = UDim.new(0, 10)

local main_stroke = Instance.new("UIStroke", main_frame)
main_stroke.Color = Color3.fromRGB(55, 55, 65)
main_stroke.Thickness = 1.5
main_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local header_frame = Instance.new("Frame", main_frame)
header_frame.Size = UDim2.new(1, 0, 0, 45)
header_frame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
header_frame.BorderSizePixel = 0

local header_corner = Instance.new("UICorner", header_frame)
header_corner.CornerRadius = UDim.new(0, 10)

local header_mask = Instance.new("Frame", header_frame)
header_mask.Size = UDim2.new(1, 0, 0, 10)
header_mask.Position = UDim2.new(0, 0, 1, -10)
header_mask.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
header_mask.BorderSizePixel = 0
header_mask.ZIndex = 0

local title_label = Instance.new("TextLabel", header_frame)
title_label.Size = UDim2.new(1, -50, 1, 0)
title_label.Position = UDim2.new(0, 15, 0, 0)
title_label.Text = "PURE STRATEGY"
title_label.TextColor3 = Color3.fromRGB(255, 255, 255)
title_label.BackgroundTransparency = 1
title_label.Font = Enum.Font.GothamBold
title_label.TextSize = 15
title_label.TextXAlignment = Enum.TextXAlignment.Left

local exit_button = Instance.new("TextButton", header_frame)
exit_button.Size = UDim2.new(0, 24, 0, 24)
exit_button.Position = UDim2.new(1, -35, 0.5, -12)
exit_button.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
exit_button.Text = "×"
exit_button.TextColor3 = Color3.fromRGB(255, 255, 255)
exit_button.Font = Enum.Font.GothamBold
exit_button.TextSize = 18
exit_button.AutoButtonColor = true
Instance.new("UICorner", exit_button).CornerRadius = UDim.new(1, 0)
exit_button.MouseButton1Click:Connect(function() tds_gui:Destroy() end)

local log_container = Instance.new("Frame", main_frame)
log_container.Size = UDim2.new(1, -24, 1, -95)
log_container.Position = UDim2.new(0, 12, 0, 55)
log_container.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
log_container.BorderSizePixel = 0

Instance.new("UICorner", log_container).CornerRadius = UDim.new(0, 8)

local console_scrolling = Instance.new("ScrollingFrame", log_container)
console_scrolling.Name = "Console"
console_scrolling.Size = UDim2.new(1, -10, 1, -10)
console_scrolling.Position = UDim2.new(0, 5, 0, 5)
console_scrolling.BackgroundTransparency = 1
console_scrolling.BorderSizePixel = 0
console_scrolling.ScrollBarThickness = 2
console_scrolling.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
console_scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

local log_layout = Instance.new("UIListLayout", console_scrolling)
log_layout.Padding = UDim.new(0, 4)

local footer_frame = Instance.new("Frame", main_frame)
footer_frame.Size = UDim2.new(1, 0, 0, 35)
footer_frame.Position = UDim2.new(0, 0, 1, -35)
footer_frame.BackgroundTransparency = 1

local status_text = Instance.new("TextLabel", footer_frame)
status_text.Size = UDim2.new(0.5, -15, 1, 0)
status_text.Position = UDim2.new(0, 15, 0, 0)
status_text.BackgroundTransparency = 1
status_text.Text = "● <font color='#00ff96'>Idle</font>"
status_text.TextColor3 = Color3.fromRGB(200, 200, 200)
status_text.Font = Enum.Font.GothamMedium
status_text.RichText = true
status_text.TextSize = 11
status_text.TextXAlignment = Enum.TextXAlignment.Left

local clock_label = Instance.new("TextLabel", footer_frame)
clock_label.Size = UDim2.new(0.5, -15, 1, 0)
clock_label.Position = UDim2.new(0.5, 0, 0, 0)
clock_label.BackgroundTransparency = 1
clock_label.Text = "TIME: 00:00:00"
clock_label.TextColor3 = Color3.fromRGB(120, 120, 130)
clock_label.Font = Enum.Font.GothamBold
clock_label.TextSize = 10
clock_label.TextXAlignment = Enum.TextXAlignment.Right

local function toggle_gui()
    main_frame.Visible = not main_frame.Visible
end

user_input_service.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Delete or input.KeyCode == Enum.KeyCode.LeftAlt then
        toggle_gui()
    end
end)

local is_dragging, drag_input, drag_start, start_pos
header_frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        is_dragging = true
        drag_start = input.Position
        start_pos = main_frame.Position
    end
end)

user_input_service.InputChanged:Connect(function(input)
    if is_dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - drag_start
        main_frame.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
    end
end)

user_input_service.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then is_dragging = false end
end)

local session_start = tick()
task.spawn(function()
    while task.wait(1) do
        if not tds_gui.Parent then break end
        local elapsed = tick() - session_start
        local h, m, s = math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), math.floor(elapsed % 60)
        clock_label.Text = string.format("TIME: %02d:%02d:%02d", h, m, s)
    end
end)

shared.AutoStratGUI = {
    Console = console_scrolling,
    bckpattern = main_frame,
    Status = function(new_status)
        status_text.Text = "● <font color='#00ff96'>" .. tostring(new_status) .. "</font>"
    end
}
