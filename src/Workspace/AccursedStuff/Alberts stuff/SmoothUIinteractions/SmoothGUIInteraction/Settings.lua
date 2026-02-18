-- Made by bluepear_2, no need for credits.

local Settings = {
	
	--**NOTE** If you dont want certain buttons to tween, then remove their "Button" tag.
	
	-- MOUSEENTER--
	--Basically when the mouse hovers over the UI.
	multipliedSize = 1.1, -- This is how much bigger your UI will be when hovered, the higher the value is, the bigger, the fewer the value, the smaller.
	hoverSoundEnabled = false, -- False means that it wont play a sound when hovered, True means that it will play a sound when hovered.
	hoverSound = workspace, -- This is where your'e going to identify the sound that is going to play when hovered.
	hoverTextEnabled = false, -- False means that your Textbuttons text will not change when hovered, True means that it will change.
	hoverText = {
		-- This table handles the Textbuttons that will display the text, copy and paste line 11 for more buttons, delete the ones you DONT need.
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", "HOVER_TEXT",
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", "HOVER_TEXT",
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", "HOVER_TEXT"
		
	}, 
	hoverColorEnabled = true, -- False means that the color of the button will change when hovering.
	hoverColors = {
		-- This table handles the Textbuttons, Imagebuttons that will display a different color when hovered, copy and paste line 19 for more buttons, delete the ones you DONT need.
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", Color3.new(1, 1, 1),-- Choose your color
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", Color3.new(1, 1, 1),
		"YOUR_TEXTBUTTON,IMAGEBUTTON_NAME_GOES_HERE", Color3.new(1, 1, 1),
		
	},
	hoverColorTweeningEnabled = true, -- False means that the colors wont transition when hovered, true means that it will.
	enterTweeningDuration = 0.1, -- How long the animation will take to reach its target size when hovering.
	
	--MOUSELEAVE--
	--Basically when the mouse leaves the UI.
	
	leaveTweeningDuration = 0.1, -- How long the animation will take to reach its target size when the mouse stops hovering.
	
	--MOUSEBUTTON1DOWN--
	--Basically when the mouse clicks and holds at the ui, changing the properties below will affect normal clicks.
	clickSoundEnabled = false, -- False means that it wont play a sound when clicked, True means that it will play a sound when clicked.
	clickSound = workspace, -- This is where your'e going to identify the sound that is going to play when clicked.
	clickTweeningDuration = 0.09 -- How long the animation will take to reach its target size when the mouse clicks something.
	--*Adding colors for each click can be quite chaotic, and also impossible, as Tweenservice cant run twice on the same object.
	
	--**NOTE** YOU CAN CHANGE THE HOVER IMAGE IN THE IMAGEBUTTON'S PROPERTIES!
}

return Settings
