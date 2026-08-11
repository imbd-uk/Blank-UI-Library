--!nocheck
--//Global Variables
local Userinput = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')


local UI = {}

function UI:Validate(defaults, info)
	for i, v in pairs(defaults) do
		if info[i] == nil then
			info[i] = v
		end
	end
	return info
end

function UI:Tween(T: {Object: Instance, Properties: { [string]: any }, Time : number, EasingStyle: Enum.EasingStyle, EasingDirection : Enum.EasingDirection})
	local Tweeninfo = TweenInfo.new(T.Time, T.EasingStyle, T.EasingDirection, 0, false, 0)
	return TweenService:Create(T.Object, Tweeninfo, T.Properties)
end

function UI:Create(info)
	
	info = UI:Validate({
		Name = "UI Library",
		KeyCode = Enum.KeyCode.LeftAlt,
	}, info or {})
	
	
	local data = {}
	data.Connections = {}
	data.SliderConnection = nil
	data.CurrentTab = nil
	do
	data.UI =  Instance.new("ScreenGui")
	data.UI.Name = "UI Library"
	data.UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	data.UI.ResetOnSpawn = false
	
	data.Background =  Instance.new("Frame")
	data.Background.Name = "Background"
	data.Background.Parent = data.UI
	data.Background.AnchorPoint = Vector2.new(0.5, 0.5)
	data.Background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	data.Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
	data.Background.BorderSizePixel = 0
	data.Background.Position = UDim2.new(0.5, 0, 0.5, 0)
	data.Background.Size = UDim2.new(0.400000006, 0, 0.5, 0)
	
	data.Tabs = Instance.new("Frame")
	data.Tabs.Name = "Tabs"
	data.Tabs.Parent = data.Background
	data.Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	data.Tabs.BackgroundTransparency = 1.000
	data.Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	data.Tabs.BorderSizePixel = 0
	data.Tabs.Size = UDim2.new(0.300000012, 0, 1, 0)
	
	data.TabsUIListLayout = Instance.new("UIListLayout")
	data.TabsUIListLayout.Parent = data.Tabs
	data.TabsUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	data.TabsUIListLayout.Padding = UDim.new(0.0250000004, 0)
	
	data.TabsUIPadding = Instance.new("UIPadding")
	data.TabsUIPadding.Parent = data.Tabs
	data.TabsUIPadding.PaddingTop = UDim.new(0.150000006, 0)
	
	data.Frame_2 = Instance.new("Frame")
	data.Frame_2.Parent = data.Background
	data.Frame_2.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	data.Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	data.Frame_2.BorderSizePixel = 0
	data.Frame_2.Position = UDim2.new(0.300000012, 0, 0, 0)
	data.Frame_2.Size = UDim2.new(0.00150000001, 0, 1, 0)
	
	data.Name = Instance.new("TextLabel")
	data.Name.Name = "Name"
	data.Name.Parent = data.Background
	data.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	data.Name.BackgroundTransparency = 1.000
	data.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
	data.Name.BorderSizePixel = 0
	data.Name.Size = UDim2.new(0.300000012, 0, 0.100000001, 0)
	data.Name.Font = Enum.Font.SourceSans
	data.Name.Text = info.Name
	data.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
	data.Name.TextSize = 18.000
	data.Name.TextXAlignment = Enum.TextXAlignment.Left
	
	data.UIPadding_2 = Instance.new("UIPadding")
	data.UIPadding_2.Parent = data.Name
	data.UIPadding_2.PaddingLeft = UDim.new(0.0500000007, 0)
	
	data.UICorner_2 = Instance.new("UICorner")
	data.UICorner_2.Parent = data.Background
	data.UICorner_2.CornerRadius = UDim.new(0.00499999989, 0)
	end
	
	data.CanDrag = true
	data.IsDragging = false
	local dragInput 
	local startingPoint
	local oldPosition
	
	local function Update(input)
		local delta = input.Position - startingPoint
		data.Background.Position = UDim2.new(oldPosition.X.Scale, oldPosition.X.Offset + delta.X, oldPosition.Y.Scale, oldPosition.Y.Offset + delta.Y)
	end
	
	table.insert(data.Connections, data.Background.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			data.IsDragging = true
			startingPoint = input.Position
			oldPosition = data.Background.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					data.IsDragging = false
				end
			end)
		end
	end))
	
	table.insert(data.Connections, data.Background.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end))
	
	table.insert(data.Connections, Userinput.InputChanged:Connect(function(input, gp)
		if input == dragInput and data.IsDragging and data.CanDrag then
			Update(input)
		end
	end))
	
	table.insert(data.Connections, Userinput.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == info.KeyCode then
			data.Background.Visible = not data.Background.Visible
		end
	end))

	function data:Tab(info)
		info = UI:Validate({
			Name = "Home",
			Icon = "rbxassetid://113155099981633",
		},info or {})
		
		local Tab = {
			Active = false,
			Hover = false,
			
		}
		
		do
		Tab.Frame = Instance.new("Frame")
		Tab.Frame.Name = "Tab1"
		Tab.Frame.Parent = data.Tabs
		Tab.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.Frame.BackgroundTransparency = 1.000
		Tab.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.Frame.BorderSizePixel = 0
		Tab.Frame.Size = UDim2.new(1, 0, 0.100000001, 0)
		
		Tab.indicator = Instance.new("Frame")
		Tab.indicator.Parent = Tab.Frame
		Tab.indicator.AnchorPoint = Vector2.new(0, 0.5)
		Tab.indicator.BackgroundColor3 = Color3.fromRGB(131,131,131)
		Tab.indicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.indicator.BorderSizePixel = 0
		Tab.indicator.Position = UDim2.new(0.0299999993, 0, 0.5, 0)
		Tab.indicator.Size = UDim2.new(0.0250000004, 0, 0.800000012, 0)
		
		Tab.UICorner = Instance.new("UICorner")
		Tab.UICorner.CornerRadius = UDim.new(0.5, 0)
		Tab.UICorner.Parent = 	Tab.indicator
		
		Tab.Icon = Instance.new("ImageLabel")
		Tab.Icon.Name = "Icon"
		Tab.Icon.Parent = Tab.Frame	
		Tab.Icon.AnchorPoint = Vector2.new(0, 0.5)
		Tab.Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.Icon.BackgroundTransparency = 1.000
		Tab.Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.Icon.BorderSizePixel = 0
		Tab.Icon.Position = UDim2.new(0.100000001, 0, 0.5, 0)
		Tab.Icon.Size = UDim2.new(0.25, 0, 0.800000012, 0)
		Tab.Icon.Image = info.Icon
		Tab.Icon.ScaleType = Enum.ScaleType.Fit
		Tab.Icon.ImageColor3 = Color3.fromRGB(131,131, 131)
		
		Tab.TabName = Instance.new("TextLabel")
		Tab.TabName .Name = "TabName"
		Tab.TabName .Parent = Tab.Frame
		Tab.TabName .AnchorPoint = Vector2.new(0, 0.5)
		Tab.TabName .BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.TabName .BackgroundTransparency = 1.000
		Tab.TabName .BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.TabName .BorderSizePixel = 0
		Tab.TabName .Position = UDim2.new(0.449999988, 0, 0.5, 0)
		Tab.TabName .Size = UDim2.new(0.550000012, 0, 0.800000012, 0)
		Tab.TabName .Font = Enum.Font.SourceSans
		Tab.TabName .Text = info.Name
		Tab.TabName .TextColor3 = Color3.fromRGB(131,131,131)
		Tab.TabName .TextSize = 20.000
		Tab.TabName .TextXAlignment = Enum.TextXAlignment.Left
			
		Tab.Holder = Instance.new("Frame")
		Tab.Holder.Name = "Tab1"
		Tab.Holder.Parent = data.Background
		Tab.Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.Holder.BackgroundTransparency = 1.000
		Tab.Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.Holder.BorderSizePixel = 0
		Tab.Holder.Position = UDim2.new(0.300000012, 0, 0, 0)
		Tab.Holder.Size = UDim2.new(0.699999988, 0, 1, 0)
		Tab.Holder.Visible = false
			
		Tab.UIListLayout_2 = Instance.new("UIListLayout")
		Tab.UIListLayout_2.Parent = Tab.Holder
		Tab.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		Tab.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		Tab.UIListLayout_2.Padding = UDim.new(0.0250000004, 0)
			
		Tab.UIPadding_3 = Instance.new("UIPadding")
		Tab.UIPadding_3.Parent = Tab.Holder
		Tab.UIPadding_3.PaddingBottom = UDim.new(0.0500000007, 0)
		Tab.UIPadding_3.PaddingLeft = UDim.new(0.0250000004, 0)
		Tab.UIPadding_3.PaddingRight = UDim.new(0.0500000007, 0)
		Tab.UIPadding_3.PaddingTop = UDim.new(0.0500000007, 0)
		end
		
		local function UpdateTabColor(Colour)
			UI:Tween({
				Object = Tab.TabName,
				Time = 0.15,
				EasingStyle = Enum.EasingStyle.Linear,
				EasingDirection = Enum.EasingDirection.In,
				Properties = {TextColor3 = Colour}
			}):Play()
			
			UI:Tween({
				Object = Tab.indicator,
				Time = 0.15,
				EasingStyle = Enum.EasingStyle.Linear,
				EasingDirection = Enum.EasingDirection.In,
				Properties = {BackgroundColor3 = Colour}
			}):Play()
			
			UI:Tween({
				Object = Tab.Icon,
				Time = 0.15,
				EasingStyle = Enum.EasingStyle.Linear,
				EasingDirection = Enum.EasingDirection.In,
				Properties = {ImageColor3 = Colour}
			}):Play()
		end
		
		function Tab:Activate()
			if not Tab.Active  then
				if data.CurrentTab ~= nil then
					data.CurrentTab:Deactivate()
				end
				
				Tab.Active = true
				Tab.Holder.Visible = true
				data.CurrentTab = Tab
				UpdateTabColor(Color3.fromRGB(255,255,255))
			end
		end
		
		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Tab.Holder.Visible =false
				UpdateTabColor(Color3.fromRGB(131,131, 131))
			end
		end
		
		function Tab:Section(info)
			info = UI:Validate({
				Name = "Section",
			}, info or {})
			
			local Section  = {}
			
			do
				Section.Frame = Instance.new("Frame")
				Section.Frame.Name = "Section1"
				Section.Frame.Parent = Tab.Holder
				Section.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				Section.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Section.Frame.BorderSizePixel = 0
				Section.Frame.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
				Section.Frame.Size = UDim2.new(0.5, 0, 1, 0)
				
				Section.UICorner = Instance.new("UICorner", Section.Frame)
				
				Section.Name = Instance.new("TextLabel")
				Section.Name.Name = "SectionName"
				Section.Name.Parent = Section.Frame
				Section.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Section.Name.BackgroundTransparency = 1.000
				Section.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Section.Name.BorderSizePixel = 0
				Section.Name.Size = UDim2.new(1, 0, 0.100000001, 0)
				Section.Name.Font = Enum.Font.SourceSans
				Section.Name.Text = info.Name
				Section.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
				Section.Name.TextSize = 18.000
				
				Section.UIStroke = Instance.new("UIStroke", Section.Frame)
				Section.UIStroke.Color = Color3.fromRGB(63,63,63)
				
				Section.ScrollingFrame = Instance.new("ScrollingFrame")
				Section.ScrollingFrame.Parent = Section.Frame
				Section.ScrollingFrame.Active = true
				Section.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Section.ScrollingFrame.BackgroundTransparency = 1.000
				Section.ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Section.ScrollingFrame.BorderSizePixel = 0
				Section.ScrollingFrame.Position = UDim2.new(0, 0, 0.100000001, 0)
				Section.ScrollingFrame.Size = UDim2.new(1, 0, 0.899999976, 0)
				Section.ScrollingFrame.ScrollBarThickness = 0
				
				Section.UIListLayout_3 = Instance.new("UIListLayout")
				Section.UIListLayout_3.Parent = Section.ScrollingFrame
				Section.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
				Section.UIListLayout_3.Padding = UDim.new(0.00999999978, 0)
				
			end
			
			function Section:Button(info)
				info = UI:Validate({
					Name = "Button",
					Callback = function()
						print('Pressed')
					end,
				}, info or {})
				
				local Button = {
					Hover = false,
				}
				
				do
					Button.Button = Instance.new("Frame")
					Button.Button.Name = "Button"
					Button.Button.Parent = Section.ScrollingFrame
					Button.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.Button.BackgroundTransparency = 1.000
					Button.Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.Button.BorderSizePixel = 0
					Button.Button.Size = UDim2.new(1, 0, 0.0500000007, 0)
					
					Button.Name_3 = Instance.new("TextLabel")
					Button.Name_3.Name = "Name"
					Button.Name_3.Parent = Button.Button
					Button.Name_3.AnchorPoint = Vector2.new(0, 0.5)
					Button.Name_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.Name_3.BackgroundTransparency = 1.000
					Button.Name_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.Name_3.BorderSizePixel = 0
					Button.Name_3.Position = UDim2.new(0, 0, 0.5, 0)
					Button.Name_3.Size = UDim2.new(1, 0, 0.25, 0)
					Button.Name_3.Font = Enum.Font.SourceSans
					Button.Name_3.Text = "Button"
					Button.Name_3.TextColor3 = Color3.fromRGB(131, 131, 131)
					Button.Name_3.TextSize = 18.000
					Button.Name_3.TextXAlignment = Enum.TextXAlignment.Left
					
					Button.UIPadding_5 = Instance.new("UIPadding")
					Button.UIPadding_5.Parent = Button.Name_3
					Button.UIPadding_5.PaddingLeft = UDim.new(0.0500000007, 0)
					
					Button.ImageLabel_2 = Instance.new("ImageLabel")
					Button.ImageLabel_2.Parent = Button.Button
					Button.ImageLabel_2.AnchorPoint = Vector2.new(1, 0.5)
					Button.ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.ImageLabel_2.BackgroundTransparency = 1.000
					Button.ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.ImageLabel_2.BorderSizePixel = 0
					Button.ImageLabel_2.Position = UDim2.new(1, 0, 0.5, 0)
					Button.ImageLabel_2.Size = UDim2.new(0.200000003, 0, 0.699999988, 0)
					Button.ImageLabel_2.Image = "rbxassetid://117311158703079"
					Button.ImageLabel_2.ImageColor3 = Color3.fromRGB(131, 131, 131)
					Button.ImageLabel_2.ScaleType = Enum.ScaleType.Fit
				end
				
				local function TweenButton(obj, goal, t)
					local tw = UI:Tween({
						Object = obj,
						EasingStyle =   Enum.EasingStyle.Cubic,
						EasingDirection = Enum.EasingDirection.InOut,
						Time = t,
						Properties = goal
					})
					tw:Play()
				end
				
				local function ButtonPressed()
					info.Callback()
					
					TweenButton(Button.Name_3, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
					TweenButton(Button.ImageLabel_2, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
					task.delay(0.1, function()
						TweenButton(Button.Name_3, {TextColor3 = Color3.fromRGB(131 ,131 , 131)}, 0.1)
						TweenButton(Button.ImageLabel_2, {ImageColor3 = Color3.fromRGB(131, 131, 131)}, 0.1)
					end)
				end
				
				function Button:SetCallback(fn)
					info.Callback = fn
				end
				
				table.insert(data.Connections, Button.Button.MouseEnter:Connect(function()
					Button.Hover = true
					TweenButton(Button.Name_3, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.1)
					TweenButton(Button.ImageLabel_2, {ImageColor3 = Color3.fromRGB(180, 180, 180)}, 0.1)
				end))
				
				table.insert(data.Connections, Button.Button.MouseLeave:Connect(function()
					Button.Hover = false
					TweenButton(Button.Name_3, {TextColor3 = Color3.fromRGB(131 ,131 , 131)}, 0.1)
					TweenButton(Button.ImageLabel_2, {ImageColor3 = Color3.fromRGB(131, 131, 131)}, 0.1)
				end))
				
				table.insert(data.Connections, Userinput.InputBegan:Connect(function(input, gp)
				--	if gp then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
						ButtonPressed()
					end
				end))
				
				
				return Button
			end
			
			function Section:Toggle(info)
				info = UI:Validate({
					Name = "Checkbox",
					boolean = false,
					Callback = function(boolean)
						  print(boolean)
					end,	
				}, info or {})
				
				local Toggle = {
					boolean = info.boolean,
					Hover = false,
				}
				
				
				do
					Toggle.Frame =Instance.new("Frame")
					Toggle.Frame.Name = "Checkbox"
					Toggle.Frame.Parent = Section.ScrollingFrame
					Toggle.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Toggle.Frame.BackgroundTransparency = 1.000
					Toggle.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.Frame.BorderSizePixel = 0
					Toggle.Frame.Size = UDim2.new(1, 0, 0.0500000007, 0)
					
					Toggle.Name = Instance.new("TextLabel")
					Toggle.Name.Name = "Name"
					Toggle.Name.Parent = Toggle.Frame
					Toggle.Name.AnchorPoint = Vector2.new(0, 0.5)
					Toggle.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Toggle.Name.BackgroundTransparency = 1.000
					Toggle.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.Name.BorderSizePixel = 0
					Toggle.Name.Position = UDim2.new(0, 0, 0.5, 0)
					Toggle.Name.Size = UDim2.new(1, 0, 0.25, 0)
					Toggle.Name.Font = Enum.Font.SourceSans
					Toggle.Name.Text = info.Name
					Toggle.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
					Toggle.Name.TextSize = 18.000
					Toggle.Name.TextXAlignment = Enum.TextXAlignment.Left
					
					Toggle.UIPadding = Instance.new("UIPadding", Toggle.Name)
					Toggle.UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
					
					Toggle.Box= Instance.new("Frame")
					Toggle.Box.Name = "Box"
					Toggle.Box.Parent = Toggle.Frame
					Toggle.Box.AnchorPoint = Vector2.new(1, 0.5)
					Toggle.Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					Toggle.Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.Box.BorderSizePixel = 0
					Toggle.Box.Position = UDim2.new(.945, 0, 0.5, 0)
					Toggle.Box.Size = UDim2.new(0.0799999982, 0, 0.449999988, 0)
					
					
					Toggle.UICorner = Instance.new("UICorner", Toggle.Box)
					Toggle.UICorner.CornerRadius = UDim.new(0.100000001, 0)
					
					Toggle.ImageLabel = Instance.new("ImageLabel")
					Toggle.ImageLabel.Parent = Toggle.Box
					Toggle.ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Toggle.ImageLabel.BackgroundTransparency = 1.000
					Toggle.ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.ImageLabel.BorderSizePixel = 0
					Toggle.ImageLabel.Size = UDim2.new(1, 0, 1, 0)
					Toggle.ImageLabel.Image = "rbxassetid://76348780980991"
					Toggle.ImageLabel.ImageColor3 = Color3.fromRGB(20, 20, 20)
					Toggle.ImageLabel.ScaleType = Enum.ScaleType.Fit
					Toggle.ImageLabel.Visible = info.boolean
					
					Toggle.UIStroke = Instance.new("UIStroke", Toggle.Box)
					Toggle.UIStroke.Color = Color3.fromRGB(131,131, 131)
					
				end
				
				local function TweenButton(obj, goal, t)
					local tw = UI:Tween({
						Object = obj,
						EasingStyle =   Enum.EasingStyle.Cubic,
						EasingDirection = Enum.EasingDirection.InOut,
						Time = t,
						Properties = goal
					})
					tw:Play()
				end

				local function TogglePressed()
					Toggle.boolean = not Toggle.boolean
					info.Callback(Toggle.boolean)
					
					if Toggle.boolean then
						TweenButton(Toggle.Name, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
						TweenButton(Toggle.ImageLabel, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
						TweenButton(Toggle.Box, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
					else
						TweenButton(Toggle.Name, {TextColor3 = Color3.fromRGB(131, 131, 131)}, 0.1)
						TweenButton(Toggle.ImageLabel, {ImageColor3 = Color3.fromRGB(131, 131, 131)}, 0.1)
						TweenButton(Toggle.Box, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}, 0.1)
					end
				
				end
				
				function Toggle:SetCallback(fn)
				         info.Callback = fn
				end

				table.insert(data.Connections, Toggle.Frame.MouseEnter:Connect(function()
					Toggle.Hover = true
					if Toggle.boolean  then return end
					TweenButton(Toggle.Name, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.1)
					TweenButton(Toggle.Box, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.1)
					TweenButton(Toggle.ImageLabel, {ImageColor3 = Color3.fromRGB(180, 180, 180)}, 0.1)
				end))

				table.insert(data.Connections, Toggle.Frame.MouseLeave:Connect(function()
					Toggle.Hover = false
					if Toggle.boolean  then return end
					TweenButton(Toggle.Name, {TextColor3 = Color3.fromRGB(131 ,131 , 131)}, 0.1)
					TweenButton(Toggle.Box, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}, 0.1)
					TweenButton(Toggle.ImageLabel, {ImageColor3 = Color3.fromRGB(131, 131, 131)}, 0.1)
				end))

				table.insert(data.Connections, Userinput.InputBegan:Connect(function(input, gp)
					--	if gp then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
						TogglePressed()
					end
				end))
				
				return Toggle
			end
			
			function Section:Slider(info)
				print(info)
				info = UI:Validate({
					Name = "Slider",
					Value = 0,
					Min = 0,
					Max = 100,
					Increment = 1,
					Callback = function(value) 
						print(value)
					end,
				}, info or {})
				
				local Slider = {
					Hover = false,
					active = false,
					number = info.Value,
				}
				
				do
					Slider.Frame = Instance.new("Frame")
					Slider.Frame.Name = "Slider"
					Slider.Frame.Parent = Section.ScrollingFrame
					Slider.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Frame.BackgroundTransparency = 1.000
					Slider.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Frame.BorderSizePixel = 0
					Slider.Frame.Size = UDim2.new(1, 0, 0.0500000007, 0)
					
					Slider.Name = Instance.new("TextLabel")
					Slider.Name.Name = "Name"
					Slider.Name.Parent = Slider.Frame
					Slider.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.Name.BackgroundTransparency = 1.000
					Slider.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Name.BorderSizePixel = 0
					Slider.Name.Position = UDim2.new(0, 0, 0.200000003, 0)
					Slider.Name.Size = UDim2.new(1, 0, 0.25, 0)
					Slider.Name.Font = Enum.Font.SourceSans
					Slider.Name.Text = info.Name
					Slider.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
					Slider.Name.TextSize = 18.000
					Slider.Name.TextXAlignment = Enum.TextXAlignment.Left
					
					Slider.UIPadding = Instance.new("UIPadding", Slider.Name)
					Slider.UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
					
					Slider.Back = Instance.new("Frame")
					Slider.Back.Name = "Back"
					Slider.Back.Parent = Slider.Frame
					Slider.Back.AnchorPoint = Vector2.new(0.5, 1)
					Slider.Back.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
					Slider.Back.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Back.BorderSizePixel = 0
					Slider.Back.Position = UDim2.new(0.5, 0, 1, 0)
					Slider.Back.Size = UDim2.new(0.899999976, 0, 0.150000006, 0)
					
					Slider.UICorner = Instance.new("UICorner", Slider.Back)
					Slider.UICorner.CornerRadius = UDim.new(0.100000001, 0)
					
					Slider.Move =  Instance.new("Frame")
					Slider.Move.Name = "Move"
					Slider.Move.Parent = Slider.Back
					Slider.Move.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.Move.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Move.BorderSizePixel = 0
					Slider.Move.Size = UDim2.new(0.5, 0, 1, 0)
					
					Slider.UICorner_6 = Instance.new("UICorner", Slider.Move)
					Slider.UICorner_6.CornerRadius = UDim.new(0.100000001, 0)
					
					Slider.Value = Instance.new("TextLabel")
					Slider.Value.Name = "Slider"
					Slider.Value.Parent = Slider.Frame
					Slider.Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.Value.BackgroundTransparency = 1.000
					Slider.Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.Value.BorderSizePixel = 0
					Slider.Value.Position = UDim2.new(0, 0, 0.200000003, 0)
					Slider.Value.Size = UDim2.new(1, 0, 0.25, 0)
					Slider.Value.Font = Enum.Font.SourceSans
					Slider.Value.Text = Slider.number.."/"..info.Max
					Slider.Value.TextColor3 = Color3.fromRGB(131, 131, 131)
					Slider.Value.TextSize = 18.000
					Slider.Value.TextXAlignment = Enum.TextXAlignment.Right
					
					Slider.UIPadding_9 = Instance.new("UIPadding")
					Slider.UIPadding_9.Parent = Slider.Value
					Slider.UIPadding_9.PaddingRight = UDim.new(0.0500000007, 0)
					
				end
				
				local decimals = tostring(info.Increment):match("%.(%d+)")
				decimals = decimals and #decimals or 0
				local formatString = "%."..decimals.."f"
				
				local function Round(value)
					local num = math.floor((value/ info.Increment)+ 0.5) * info.Increment
					return math.clamp(num, info.Min, info.Max)
				end
				
				local function format(value)
		
					
					local text = string.format(formatString , value)
					
					if decimals > 0 then
						text = text:gsub("0+$",""):gsub("%.$","")
					end
					
					return text
				end
				
				function Slider:SetCallback(fn)
					info.Callback = fn
					
				end
				
				function Slider:GetValue()
					return tonumber(Slider.number)
				end
	
				function Slider:SetValue(v)
					if v == nil then 
						data.CanDrag = false
						data.IsDragging = false
						
						local mousePosition = Userinput:GetMouseLocation()
						local move = math.clamp((mousePosition.X - Slider.Back.AbsolutePosition.X)/ Slider.Back.AbsoluteSize.X, 0, 1)
						local value =  Round(info.Min  + (info.Max - info.Min) * move)
						Slider.Move.Size = UDim2.fromScale(move, 1)
						Slider.Value.Text = format(value).."/"..format(info.Max)
						Slider.number = value
					else
					     v = Round(v)
						Slider.Value.Text = format(v).."/"..format(info.Max)
						Slider.Move.Size = UDim2.fromScale(((v - info.Min)/  (info.Max - info.Min)), 1)
						Slider.number = v
					end
				
					info.Callback(Slider:GetValue())
				end
				
				Slider:SetValue(info.Value)
				
				table.insert(data.Connections, Slider.Frame.MouseEnter:Connect(function()
						Slider.Hover = true
						data.CanDrag = false
				
				end))
				
				table.insert(data.Connections, Slider.Frame.MouseLeave:Connect(function()
				
						Slider.Hover = false
						data.CanDrag = true
				
				end))
				
				table.insert(data.Connections, Userinput.InputBegan:Connect(function(input, gp)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Slider.Hover then
							Slider.active = true
							
							if not data.SliderConnection then
							data.SliderConnection =  RunService.RenderStepped:Connect(function()
							       Slider:SetValue()
							end)
							end
						end
					end
				end))
				
				table.insert(data.Connections, Userinput.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Slider.active = false
						if data.SliderConnection then
							data.SliderConnection:Disconnect()
							data.SliderConnection= nil
							Slider.Hover = false
							data.CanDrag = true
						end
					end
				end))
				
				return Slider
			end
			
			function Section:Keybind(info)
				info = UI:Validate({
					Name = "Keybind",
					Keybind = Enum.KeyCode.G,
					boolean = false,
					Callback = function()
						print('pressed')
					end,
				}, info or {})
				
				local Keybind = {
					Hover  = false,
					Active = false,
					Key = info.Keybind
				}
				
				local WordToNumber = {
					["zero"]  = 0,
					["one"] = 1,
					["two"] = 2,
					["three"] = 3,
					["four"] = 4,
					["five"] = 5,
					["six"] = 6,
					["seven"] = 7,
					["eight"] = 8,
					["nine"] = 9,
				}
				
				do
					Keybind.Frame = Instance.new("Frame")
					Keybind.Frame.Name = "Keybind"
					Keybind.Frame.Parent = Section.ScrollingFrame
					Keybind.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Keybind.Frame.BackgroundTransparency = 1.000
					Keybind.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Keybind.Frame.BorderSizePixel = 0
					Keybind.Frame.Size = UDim2.new(1, 0, 0.0500000007, 0)
					
					Keybind.Name = Instance.new("TextLabel")
					Keybind.Name.Name = "Name"
					Keybind.Name.Parent = Keybind.Frame
					Keybind.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Keybind.Name.BackgroundTransparency = 1.000
					Keybind.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Keybind.Name.BorderSizePixel = 0
					Keybind.Name.Size = UDim2.new(1, 0, 1, 0)
					Keybind.Name.Font = Enum.Font.SourceSans
					Keybind.Name.Text =  info.Name
					Keybind.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
					Keybind.Name.TextSize = 18.000
					Keybind.Name.TextXAlignment = Enum.TextXAlignment.Left
					
					Keybind.NamePadding = Instance.new("UIPadding")
					Keybind.NamePadding.Parent = Keybind.Name
					Keybind.NamePadding.PaddingLeft = UDim.new(0.0500000007, 0)
					
					Keybind.TextBox = Instance.new("TextBox")
					Keybind.TextBox.Parent = Keybind.Frame
					Keybind.TextBox.AnchorPoint = Vector2.new(0, 0.5)
					Keybind.TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Keybind.TextBox.BackgroundTransparency = 1.000
					Keybind.TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Keybind.TextBox.BorderSizePixel = 0
					Keybind.TextBox.Position = UDim2.new(0.850000024, 0, 0.5, 0)
					Keybind.TextBox.Size = UDim2.new(0.100000001, 0, 0.5, 0)
					Keybind.TextBox.Font = Enum.Font.SourceSans
					Keybind.TextBox.Text = info.Keybind.Name
					Keybind.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					Keybind.TextBox.TextScaled = true
					Keybind.TextBox.TextSize = 14.000
					Keybind.TextBox.TextWrapped = true
					Keybind.TextBox.ClearTextOnFocus = false
					Keybind.TextBox.TextEditable = false
					--Keybind.TextBox.Interactable = false
					
					Keybind.TextBoxPadding = Instance.new("UIPadding")
					Keybind.TextBoxPadding.Parent = Keybind.TextBox
					Keybind.TextBoxPadding.PaddingRight = UDim.new(0.0500000007, 0)
					
					Keybind.UICorner = Instance.new("UICorner")
					Keybind.UICorner.CornerRadius = UDim.new(0.100000001, 0)
					Keybind.UICorner.Parent = Keybind.TextBox
					
					Keybind.UIStroke = Instance.new("UIStroke", Keybind.TextBox)
					Keybind.UIStroke.Color = Color3.fromRGB(131,131,131)
					Keybind.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				end
				
				local function convertWordToNum(str: string)
					 return WordToNumber[str:lower()]
				end
				
				local keyChangeConnection = nil
				function Keybind:ChangeKey()
					Keybind.TextBox.Text = "..."
					
					keyChangeConnection = Userinput.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.Keyboard then
							if input.KeyCode == Enum.KeyCode.None then
								return
							end
							Keybind.Key = input.KeyCode
						     if WordToNumber[string.lower(input.KeyCode.Name)] then 
								Keybind.TextBox.Text = convertWordToNum(input.KeyCode.Name)
							else
								Keybind.TextBox.Text = input.KeyCode.Name
							end
							
							keyChangeConnection:Disconnect()
						end
					end)
				
				end
				
				function Keybind:SetCallback(fn)
					   info.Callback = fn
				end
				
				
				table.insert(data.Connections, Keybind.TextBox.MouseEnter:Connect(function()
					Keybind.Hover = true
				end))
				
				table.insert(data.Connections, Keybind.TextBox.MouseLeave:Connect(function()
                         Keybind.Hover = false
				end))
				
				table.insert(data.Connections, Userinput.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Hover then
						Keybind:ChangeKey()
					end
					
					if input.KeyCode == Keybind.Key then
						info.Callback()
					end
				end))
				
				return Keybind
			end
			
			function Section:Textbox(info)
				info = UI:Validate({
					Name =  "Textbox",
					PlaceHolder = 'Enter text',
					Callback= function (text)
						   print(text)
					end,
					
				}, info or {})
				
				local Textbox = {}
				
				do
					Textbox.Frame = Instance.new('Frame')
					Textbox.Frame.Name = "Textbox"
					Textbox.Frame.Parent = Section.ScrollingFrame
					Textbox.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
					Textbox.Frame.BackgroundTransparency = 1.000
					Textbox.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Textbox.Frame.BorderSizePixel = 0
					Textbox.Frame.Size = UDim2.new(1, 0, 0.0500000007, 0)
					--Textbox.Frame.ClipsDescendants = true
					
					Textbox.TextBox = Instance.new("TextBox")
					Textbox.TextBox.Parent = Textbox.Frame
					Textbox.TextBox.ClipsDescendants = true
					Textbox.TextBox.AnchorPoint = Vector2.new(0.5, 1)
					Textbox.TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Textbox.TextBox.BackgroundTransparency = 1.000
					Textbox.TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Textbox.TextBox.BorderSizePixel = 0
					Textbox.TextBox.LayoutOrder = 2
					Textbox.TextBox.Position = UDim2.new(0.5, 0, 1, 0)
					Textbox.TextBox.Size = UDim2.new(0.899999976, 0, 0.5, 0)
					Textbox.TextBox.Font = Enum.Font.Code
					Textbox.TextBox.PlaceholderText = info.PlaceHolder
					Textbox.TextBox.Text = ""
					Textbox.TextBox.TextColor3 = Color3.fromRGB(131, 131, 131)
					Textbox.TextBox.TextSize = 14.000
					Textbox.TextBox.TextStrokeColor3 = Color3.fromRGB(131, 131, 131)
					Textbox.TextBox.TextXAlignment = Enum.TextXAlignment.Left
					
					Textbox.UIPadding = Instance.new("UIPadding", Textbox.TextBox)
					Textbox.UIPadding.Parent = Textbox.TextBox
					Textbox.UIPadding.PaddingLeft = UDim.new(0.0120000001, 0)
					
					Textbox.Name = Instance.new("TextLabel")
					Textbox.Name.Name = "Name"
					Textbox.Name.Parent = Textbox.Frame
					Textbox.Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Textbox.Name.BackgroundTransparency = 1.000
					Textbox.Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Textbox.Name.BorderSizePixel = 0
					Textbox.Name.Size = UDim2.new(1, 0, 0.300000012, 0)
					Textbox.Name.Font = Enum.Font.SourceSans
					Textbox.Name.Text = "Textbox"
					Textbox.Name.TextColor3 = Color3.fromRGB(131, 131, 131)
					Textbox.Name.TextSize = 18.000
					Textbox.Name.TextXAlignment = Enum.TextXAlignment.Left
					
					Textbox.UIPadding_7 = Instance.new('UIPadding')
					Textbox.UIPadding_7.Parent = Textbox.Name
					Textbox.UIPadding_7.PaddingLeft = UDim.new(0.0500000007, 0)
					
					Textbox.UIStroke = Instance.new("UIStroke")
					Textbox.UIStroke.Parent = Textbox.TextBox
					Textbox.UIStroke.Color = Color3.fromRGB(131, 131, 131)
					Textbox.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				end
				
				function Textbox:GetText()
					return Textbox.TextBox.Text
				end
				
				function Textbox:SetCallback(fn)
					  info.Callback = fn
				end
				
				function Textbox:Clear()
					Textbox.TextBox.Text = ""
				end
				
				function Textbox:SetPlaceHolder(placeholder)
					Textbox.TextBox.PlaceholderText = placeholder
				end
				
				table.insert(data.Connections, Textbox.TextBox.FocusLost:Connect(function(enterPressed)
					   info.Callback(Textbox:GetText())
				end))
				
				return Textbox
			end
			
			return Section
		end
		
		if data.CurrentTab == nil then
			  Tab:Activate()
		end
		
		table.insert(data.Connections, Tab.Frame.MouseEnter:Connect(function()
			   Tab.Hover = true
		end))
		
		table.insert(data.Connections, Tab.Frame.MouseLeave:Connect(function()
                 Tab.Hover = false
		end))
		
		table.insert(data.Connections, Userinput.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Hover then
				Tab:Activate()
			end
		end))
		
		
		return Tab
	end
	
	return data
end

local newUi = UI:Create({Name = "UI LIBRARY"})

local tab = newUi:Tab({})
local tab1 = newUi:Tab({})

local section = tab:Section({})

section:Button({
	Name = "Test",
})
section:Toggle({})
section:Slider({})

local key = section:Keybind({
	Keybind =  Enum.KeyCode.F,
})


section:Textbox({})
