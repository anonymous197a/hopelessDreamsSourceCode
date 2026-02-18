-- Made by bluepear_2, no need for credits.
local CollectionService = game:GetService("CollectionService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local buttons = CollectionService:GetTagged("Button")
local Settings = require(script.Settings)
local debounce = {}

-- Function to handle tweening for button
local function handleButton(button)
	
	debounce[button] = false -- Create a debounce so the tween doesnt happen when it's not suppoused to
	
	local originalSize = button.Size -- We need to record the original size, so we can tween back to it.
	local multipliedSize = Settings.multipliedSize -- Look in the Settings module script for this.
	local originalText 
	local originalColor = button.BackgroundColor3
	
	if button:IsA("TextButton") then -- Quick litte if statement to see if the button is a Textbutton or not.
	   originalText = button.Text
	end
		
		button.MouseButton1Down:Connect(function()

			-- Basically the same thing as the rest, but this time, we`ll use MouseButton1Down so when the player clicks and holds, it`ll just shrink rather than coming in and back.
			local tweenInfo = TweenInfo.new(
				Settings.clickTweeningDuration, -- Time taken for a full animation
				Enum.EasingStyle.Linear, -- Animation Style
				Enum.EasingDirection.InOut, -- Animation Type
				0, -- Number of repeats
				false, -- No reversing, for click and hold effect.
				0 -- Delay between animations
			)

			local tween = tweenService:Create(button, tweenInfo, {Size = originalSize})
			tween:Play()
			
			if Settings.clickSoundEnabled == true then

				local function playsound()
					Settings.clickSound:Play()
					wait(1)
				end
				task.spawn(playsound)
			end

			tween.Completed:Wait() -- Wait for the tween to complete

		end)

		button.MouseButton1Up:Connect(function()

			local TargetSize = UDim2.new(originalSize.X.Scale * multipliedSize, 0, originalSize.Y.Scale * multipliedSize, 0)
			-- Basically the same thing as the rest, but this time, we`ll use MouseButton2Down so when the player clicks off, it`ll go back to the normal size.
			local tweenInfo = TweenInfo.new(
				0.09, -- Time taken for a full animation
				Enum.EasingStyle.Linear, -- Animation Style
				Enum.EasingDirection.InOut, -- Animation Type
				0, -- Number of repeats
				false, -- No reversing, for click and hold effect.
				0 -- Delay between animations
			)

			local tween = tweenService:Create(button, tweenInfo, {Size = TargetSize})
			tween:Play()

			tween.Completed:Wait() -- Wait for the tween to complete

		end)

		--Function for when the mouse hovers over the GUI--
		button.MouseEnter:Connect(function()

			if not debounce[button] then
				debounce[button] = true

				local TargetSize = UDim2.new(originalSize.X.Scale * multipliedSize, 0, originalSize.Y.Scale * multipliedSize, 0)

				local tweenInfo = TweenInfo.new(
					Settings.enterTweeningDuration, -- Time taken for a full animation
					Enum.EasingStyle.Linear, -- Animation Style
					Enum.EasingDirection.InOut, -- Animation Type
					0, -- Number of repeats
					false, -- Reverse?
					0 -- Delay between animations
				)

				local tween = tweenService:Create(button, tweenInfo, {Size = TargetSize})
				tween:Play()
				-- DO NOT MESS WITH THE CODE BELOW UNLESS YOU KNOW WHAT YOU'RE DOING!
				-- THIS HANDLES THE SETTINGS, LOOK IN THE SETTINGS MODULE TO CUSTOMIZE.
				if Settings.hoverSoundEnabled == true then
					Settings.hoverSound:Play()
				end
				if Settings.hoverTextEnabled == true then

					for i = 1, #Settings.hoverText, 2 do
						local buttonName = Settings.hoverText[i]
						local hoverTextValue = Settings.hoverText[i + 1]

						if button.Name == buttonName then

							button.MouseEnter:Connect(function()
								button.Text = hoverTextValue
							end)

							button.MouseLeave:Connect(function()
								button.Text = originalText -- Reset to the original button name
							end)

							break
						end
					end
				end
				
				if Settings.hoverColorEnabled == true then
					
					for i = 1, #Settings.hoverColors, 2 do
						local buttonName = Settings.hoverColors[i]
						local hoverColorValue = Settings.hoverColors[i + 1]
						
						if button.Name == buttonName then
							
							local function tweenColor(targetColor)
								local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
								local tween = tweenService:Create(button, tweenInfo, {BackgroundColor3 = targetColor})
								tween:Play()
							end

							
							button.MouseEnter:Connect(function()
								if Settings.hoverColorTweeningEnabled == true then
									tweenColor(hoverColorValue) 
								else
									button.BackgroundColor3 = hoverColorValue 
								end
							end)

							
							button.MouseLeave:Connect(function()
								if Settings.hoverColorTweeningEnabled == true then
									tweenColor(originalColor) 
								else
									button.BackgroundColor3 = originalColor 
								end
							end)

							break
						end
					end
				end
				
				-- THIS HANDLES THE SETTINGS, LOOK IN THE SETTINGS MODULE TO CUSTOMIZE.
				-- DO NOT MESS WITH THE CODE ABOVE UNLESS YOU KNOW WHAT YOU'RE DOING!
				tween.Completed:Wait() -- Wait for the tween to complete before allowing further actions

			end
		end)
		--Function for when the mouse leaves the GUI--
		button.MouseLeave:Connect(function()

			if debounce[button] then

				local tweenInfo = TweenInfo.new(
					Settings.leaveTweeningDuration, -- Time taken for a full animation
					Enum.EasingStyle.Linear, -- Animation Style
					Enum.EasingDirection.InOut, -- Animation Type
					0, -- Number of repeats
					false, -- Reverse?
					0 -- Delay between animations
				)

				local tween = tweenService:Create(button, tweenInfo, {Size = originalSize})
				tween:Play()
				
				-- DO NOT MESS WITH THE CODE BELOW UNLESS YOU KNOW WHAT YOU'RE DOING!
				-- THIS HANDLES THE SETTINGS, LOOK IN THE SETTINGS MODULE TO CUSTOMIZE.
				if Settings.leaveSoundEnabled == true then
					Settings.leaveSound:Play()
				end

				-- THIS HANDLES THE SETTINGS, LOOK IN THE SETTINGS MODULE TO CUSTOMIZE.
				-- DO NOT MESS WITH THE CODE ABOVE UNLESS YOU KNOW WHAT YOU'RE DOING!
				
				tween.Completed:Wait() -- Wait for the tween to complete
				debounce[button] = false -- Reset debounce
		   end
	end)
end

-- Loop through all buttons tagged with "Button"
for _, button in ipairs(buttons) do
	handleButton(button)
end

-- Automatically handle newly added buttons tagged with "Button"
CollectionService:GetInstanceAddedSignal("Button"):Connect(function(button)
	handleButton(button)
end)
