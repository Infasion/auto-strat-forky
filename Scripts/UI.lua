local Library = {}

function Library.Init()
    local player = game.Players.LocalPlayer
    local player_gui = player:WaitForChild("PlayerGui")
    local uis = game:GetService("UserInputService")

    local screen_gui = Instance.new("ScreenGui")
    screen_gui.Name = "ModernAutoLogger"
    screen_gui.ResetOnSpawn = false
    screen_gui.Parent = player_gui

    local main_frame = Instance.new("Frame")
    main_frame.Size = UDim2.new(0, 380, 0, 320)
    main_frame.Position = UDim2.new(0.5, -190, 0.5, -160)
    main_frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    main_frame.BorderSizePixel = 0
    main_frame.Active = true
    main_frame.Parent = screen_gui

    local main_corner = Instance.new("UICorner")
    main_corner.CornerRadius = UDim.new(0, 10)
    main_corner.Parent = main_frame

    local main_stroke = Instance.new("UIStroke")
    main_stroke.Color = Color3.fromRGB(55, 55, 65)
    main_stroke.Thickness = 1.5
    main_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    main_stroke.Parent = main_frame

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    header.BorderSizePixel = 0
    header.Parent = main_frame

    local header_corner = Instance.new("UICorner")
    header_corner.CornerRadius = UDim.new(0, 10)
    header_corner.Parent = header

    local header_hide_fix = Instance.new("Frame")
    header_hide_fix.Size = UDim2.new(1, 0, 0, 10)
    header_hide_fix.Position = UDim2.new(0, 0, 1, -10)
    header_hide_fix.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    header_hide_fix.BorderSizePixel = 0
    header_hide_fix.ZIndex = 0
    header_hide_fix.Parent = header

    local header_gradient = Instance.new("UIGradient")
    header_gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
    })
    header_gradient.Rotation = 90
    header_gradient.Parent = header

    local title_text = Instance.new("TextLabel")
    title_text.Size = UDim2.new(1, -50, 1, 0)
    title_text.Position = UDim2.new(0, 15, 0, 0)
    title_text.Text = "AUTOSTRATS LOGGER"
    title_text.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_text.BackgroundTransparency = 1
    title_text.Font = Enum.Font.GothamBold
    title_text.TextSize = 15
    title_text.TextXAlignment = Enum.TextXAlignment.Left
    title_text.Parent = header

    local exit_btn = Instance.new("TextButton")
    exit_btn.Size = UDim2.new(0, 24, 0, 24)
    exit_btn.Position = UDim2.new(1, -35, 0.5, -12)
    exit_btn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    exit_btn.Text = "×"
    exit_btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    exit_btn.Font = Enum.Font.GothamBold
    exit_btn.TextSize = 18
    exit_btn.AutoButtonColor = true
    exit_btn.Parent = header

    local btn_corner = Instance.new("UICorner")
    btn_corner.CornerRadius = UDim.new(1, 0)
    btn_corner.Parent = exit_btn

    exit_btn.MouseButton1Click:Connect(function() screen_gui:Destroy() end)

    local log_container = Instance.new("Frame")
    log_container.Size = UDim2.new(1, -24, 1, -95)
    log_container.Position = UDim2.new(0, 12, 0, 55)
    log_container.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    log_container.BorderSizePixel = 0
    log_container.Parent = main_frame

    local log_corner = Instance.new("UICorner")
    log_corner.CornerRadius = UDim.new(0, 8)
    log_corner.Parent = log_container

    local log_box = Instance.new("ScrollingFrame")
    log_box.Size = UDim2.new(1, -10, 1, -10)
    log_box.Position = UDim2.new(0, 5, 0, 5)
    log_box.BackgroundTransparency = 1
    log_box.BorderSizePixel = 0
    log_box.ScrollBarThickness = 2
    log_box.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
    log_box.CanvasSize = UDim2.new(0, 0, 0, 0)
    log_box.Parent = log_container

    local log_layout = Instance.new("UIListLayout")
    log_layout.Parent = log_box
    log_layout.Padding = UDim.new(0, 4)

    local footer = Instance.new("Frame")
    footer.Size = UDim2.new(1, 0, 0, 35)
    footer.Position = UDim2.new(0, 0, 1, -35)
    footer.BackgroundTransparency = 1
    footer.Parent = main_frame

    local status_label = Instance.new("TextLabel")
    status_label.Size = UDim2.new(0.5, -15, 1, 0)
    status_label.Position = UDim2.new(0, 15, 0, 0)
    status_label.BackgroundTransparency = 1
    status_label.Text = "● <font color='#00ff96'>Idle</font>"
    status_label.TextColor3 = Color3.fromRGB(200, 200, 200)
    status_label.Font = Enum.Font.GothamMedium
    status_label.RichText = true
    status_label.TextSize = 11
    status_label.TextXAlignment = Enum.TextXAlignment.Left
    status_label.Parent = footer

    local time_label = Instance.new("TextLabel")
    time_label.Size = UDim2.new(0.5, -15, 1, 0)
    time_label.Position = UDim2.new(0.5, 0, 0, 0)
    time_label.BackgroundTransparency = 1
    time_label.Text = "TIME: 00:00:00"
    time_label.TextColor3 = Color3.fromRGB(120, 120, 130)
    time_label.Font = Enum.Font.GothamBold
    time_label.TextSize = 10
    time_label.TextXAlignment = Enum.TextXAlignment.Right
    time_label.Parent = footer

    local function log(message)
        local timestamp = os.date("%H:%M:%S")
        local log_entry = Instance.new("TextLabel")
        log_entry.Size = UDim2.new(1, 0, 0, 18)
        log_entry.BackgroundTransparency = 1
        log_entry.Text = string.format("<font color='#555564'>[%s]</font> %s", timestamp, tostring(message))
        log_entry.TextColor3 = Color3.fromRGB(220, 220, 220)
        log_entry.Font = Enum.Font.SourceSans
        log_entry.RichText = true
        log_entry.TextSize = 14
        log_entry.TextXAlignment = Enum.TextXAlignment.Left
        log_entry.Parent = log_box
        
        log_box.CanvasSize = UDim2.new(0, 0, 0, log_layout.AbsoluteContentSize.Y)
        log_box.CanvasPosition = Vector2.new(0, log_layout.AbsoluteContentSize.Y)
    end

    local function status(new_status)
        status_label.Text = "● <font color='#00ff96'>" .. tostring(new_status) .. "</font>"
    end

    local start_time = tick()
    task.spawn(function()
        while task.wait(1) do
            if not screen_gui.Parent then break end
            local elapsed = tick() - start_time
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = math.floor(elapsed % 60)
            time_label.Text = string.format("TIME: %02d:%02d:%02d", h, m, s)
        end
    end)

    local dragging, drag_start, start_pos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            drag_start = input.Position
            start_pos = main_frame.Position
        end
    end)
    uis.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - drag_start
            main_frame.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    return {
        log = log,
        status = status
    }
end

return Library
