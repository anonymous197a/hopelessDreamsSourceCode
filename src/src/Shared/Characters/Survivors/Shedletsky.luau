local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local Ability = require(ReplicatedStorage.Classes.Ability)
local Character = require(ReplicatedStorage.Classes.Character)
local Types = require(ReplicatedStorage.Classes.Types)

local BehaviorModule = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Survivors.ShedletskyBehavior)

local function SwingBehavior(self)
    if RunService:IsServer() then
        BehaviorModule.Swing(self)
    end
end

local function ChickenBehavior(self)
    if RunService:IsServer() then
        BehaviorModule.Chicken(self)
    end
end

local function SwitchBehavior(self)
    if RunService:IsServer() then
        BehaviorModule.Switch(self)
    end
end

local Shedletsky: Types.Survivor = Character.CreateSurvivor({
    Config = {
        Name = "Shedletsky",
        Quote = "Blame John",
		Render = "rbxassetid://83121895268677",
		Price = 500,

       -- Origin = {
       --     TooltipText = "no im not original",
        --    Icon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		--},
		
		AnimationIDs = {
			IdleAnimation = "rbxassetid://122422760251608",
			WalkAnimation = "rbxassetid://139796943045102",
			RunAnimation = "rbxassetid://73720317039555",
		},

	},
	
	FacialExpressions = {
		Default = "rbxassetid://14301710584",
		Hurt = "rbxassetid://73822195337615",
		Limping = "rbxassetid://139846732878850",
		Dead = "rbxassetid://119335625920830"
	},

    GameplayConfig = {
        
        Abilities = {

            Swing = Ability.New({
                Name = "Swing",
                InputName = "FirstAbility",
                Cooldown = 40,
                Behaviour = SwingBehavior
            }),

            Chicken = Ability.New({
                Name = "Chicken",
                InputName = "SecondAbility",
                Cooldown = 40,
                Behaviour = ChickenBehavior
            }),

            Switch = Ability.New({
                Name = "Swing",
                InputName = "ThirdAbility",
                Cooldown = 1,
                Behaviour = SwitchBehavior
            }),

            --burger
            --epicsauce
            --idk twin
        }
    }
})

Shedletsky.Config.Description = {
    {
        Type = "Separator",
        Text = "GENERAL INFO",
    },
    {
        Type = "Header",
        Text = Shedletsky.Config.Name:upper(),
    },
    {
        Type = "Quote",
        Text = "\""..Shedletsky.Config.Quote.."\""
    },
    {
        Type = "Text",
        Text = "Initially a simple soldier that managed to turn the military upside-down with his leadership. "
            .."After some altercations in a company he got hired in as a guard against anomalies, he managed to survive a fatal accident and become one of the peak soldiers in the army. "
            .."He's been intensely trained for years and has experience with handguns and flash grenades, using them as efficiently as possible and purchasing the tools with most quality.",
    },
    {
        Type = "Header",
        Text = "STATS",
    },
    --{
    --    Type = "Text",
    --    Text = {
    --        "Difficulty: ★★★☆☆",
    --        -- "Difficulty: 6 7",
    --        "Health: "..tostring(Shedletsky.GameplayConfig.Health),
    --        "Base Speed: "..tostring(Shedletsky.GameplayConfig.BaseSpeed),
    --        "Sprint Speed: "..tostring(math.round(Shedletsky.GameplayConfig.BaseSpeed * Shedletsky.GameplayConfig.SprintSpeedMultiplier * 10) / 10),
    --        "Max Stamina: "..tostring(Shedletsky.GameplayConfig.StaminaProperties.MaxStamina),
    --        "Stamina Loss per second: "..tostring(Shedletsky.GameplayConfig.StaminaProperties.StaminaDrain),
    --        "Stamina Gain per second: "..tostring(Shedletsky.GameplayConfig.StaminaProperties.StaminaGain),
    --    },
    --},
    --{
    --    Type = "Separator",
    --    Text = "PASSIVES",
    --},
    --{
    --    Type = "Header",
    --    Text = Shedletsky.GameplayConfig.Abilities.BodyArmor.Name:upper(),
    --},
    --{
    --    Type = "Quote",
    --    Text = "\"Diamond armor, full set!\" -Minecraft Steve",
    --},
    --{
    --    Type = "Text",
    --    Text = "Every time Shedletsky gets hit, he gets <b>Resistance V</b> for 1 second, acting as invincibility frames.",
    --    Image = "http://www.roblox.com/asset/?id=113412520",
    --},
    --{
    --    Type = "Separator",
    --    Text = "ABILITIES",
    --},
    --{
    --    Type = "Header",
    --    Text = Shedletsky.GameplayConfig.Abilities.Blindside.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Shedletsky picks up a flashbang grenade and throws it after "..tostring(Shedletsky.GameplayConfig.Abilities.Blindside.ThrowDelay)..
    --        " seconds, triggering it after "..tostring(Shedletsky.GameplayConfig.Abilities.Blindside.TriggerDelay)..
    --        " seconds and inflicting the killer <b>Blindness</b> for "..tostring(Shedletsky.GameplayConfig.Abilities.Blindside.FlashTime)..
    --        " seconds if they're in a "..tostring(Shedletsky.GameplayConfig.Abilities.Blindside.FlashRadius)..
    --        " stud radius.",
    --},
    --{
    --    Type = "Header",
    --    Text = Shedletsky.GameplayConfig.Abilities.Reload.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Shedletsky reloads his gun, getting <b>Slowness "..Utils.Math.IntToRoman(Shedletsky.GameplayConfig.Abilities.Reload.SlownessLevel)..
    --        "</b> for "..tostring(Shedletsky.GameplayConfig.Abilities.Reload.Duration).." seconds.",
    --},
    --{
    --    Type = "Header",
    --    Text = Shedletsky.GameplayConfig.Abilities.Justice.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = {
    --        "Shedletsky shoots forward "
    --        ..tostring(Shedletsky.GameplayConfig.Abilities.Justice.HitboxLength).." studs. If it hits the killer, they get stunned for "
    --        ..tostring(Shedletsky.GameplayConfig.Abilities.Justice.StunTime).." seconds and receive "
    --        ..tostring(Shedletsky.GameplayConfig.Abilities.Justice.Damage).." damage.",
    --        "This ability's charge is obtained through <b>Reload</b>."
    --    },
    --},
}

return Shedletsky
