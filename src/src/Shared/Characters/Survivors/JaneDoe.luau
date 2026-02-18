local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Character = require(ReplicatedStorage.Classes.Character)
local Types = require(ReplicatedStorage.Classes.Types)
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Ability = require(ReplicatedStorage.Classes.Ability)

local BehaviorsModule = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Survivors.NoobBehavior)

local function HealBurger(self)
    if RunService:IsServer() then
        BehaviorsModule.HealBurger(self)
    end
end

local function Epicsauce(self)
    if RunService:IsServer() then
        BehaviorsModule.Epicsauce(self)
    end
end

local Noob: Types.Survivor = Character.CreateSurvivor({
    Config = {
        Name = "Jane Doe",
        Quote = "Hes a new player, he doesn't know what'll happen",
		Render = "rbxassetid://113019846359245",
		Price = 850,

        --Origin = {
        --    TooltipText = "no im not original",
        --    Icon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		--},
		
		AnimationIDs = {
			IdleAnimation = "rbxassetid://122422760251608",
			WalkAnimation = "rbxassetid://139796943045102",
			RunAnimation = "rbxassetid://73720317039555",
		},
    },

    FacialExpressions = {
        Default = "rbxassetid://00",
        Hurt = "rbxassetid://00",
        Limping = "rbxassetid://00",
        Dead = "rbxassetid://00"
    },

    GameplayConfig = {
        Abilities = {
            -- yes the exact stats are fucking hardcoded in, fight me later over it
            HealBurger = Ability.New({
                Name = "HealBurger",
                InputName = "FirstAbility",
                Cooldown = 30,
                Behaviour = HealBurger
            }),

            Epicsauce = Ability.New({
                Name = "Epicsauce",
                InputName = "SecondAbility",
                Cooldown = 45,
                Behaviour = Epicsauce
            }),
            --burger
            --epicsauce
            --idk twin
        }
    },
})

Noob.Config.Description = {
    {
        Type = "Separator",
        Text = "GENERAL INFO",
    },
    {
        Type = "Header",
        Text = Noob.Config.Name:upper(),
    },
    {
        Type = "Quote",
        Text = "\""..Noob.Config.Quote.."\""
    },
    {
        Type = "Text",
        Text = "guy man. "
            .."starter character so is good. "
            .."197",
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
    --        "Health: "..tostring(Noob.GameplayConfig.Health),
    --        "Base Speed: "..tostring(Noob.GameplayConfig.BaseSpeed),
    --        "Sprint Speed: "..tostring(math.round(Noob.GameplayConfig.BaseSpeed * Noob.GameplayConfig.SprintSpeedMultiplier * 10) / 10),
    --        "Max Stamina: "..tostring(Noob.GameplayConfig.StaminaProperties.MaxStamina),
    --        "Stamina Loss per second: "..tostring(Noob.GameplayConfig.StaminaProperties.StaminaDrain),
    --        "Stamina Gain per second: "..tostring(Noob.GameplayConfig.StaminaProperties.StaminaGain),
    --    },
    --},
    --{
    --    Type = "Separator",
    --    Text = "PASSIVES",
    --},
    --{
    --    Type = "Header",
    --    Text = Noob.GameplayConfig.Abilities.BodyArmor.Name:upper(),
    --},
    --{
    --    Type = "Quote",
    --    Text = "\"Diamond armor, full set!\" -Minecraft Steve",
    --},
    --{
    --    Type = "Text",
    --    Text = "Every time Noob gets hit, he gets <b>Resistance V</b> for 1 second, acting as invincibility frames.",
    --    Image = "http://www.roblox.com/asset/?id=113412520",
    --},
    --{
    --    Type = "Separator",
    --    Text = "ABILITIES",
    --},
    --{
    --    Type = "Header",
    --    Text = Noob.GameplayConfig.Abilities.Blindside.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Noob picks up a flashbang grenade and throws it after "..tostring(Noob.GameplayConfig.Abilities.Blindside.ThrowDelay)..
    --        " seconds, triggering it after "..tostring(Noob.GameplayConfig.Abilities.Blindside.TriggerDelay)..
    --        " seconds and inflicting the killer <b>Blindness</b> for "..tostring(Noob.GameplayConfig.Abilities.Blindside.FlashTime)..
    --        " seconds if they're in a "..tostring(Noob.GameplayConfig.Abilities.Blindside.FlashRadius)..
    --        " stud radius.",
    --},
    --{
    --    Type = "Header",
    --    Text = Noob.GameplayConfig.Abilities.Reload.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Noob reloads his gun, getting <b>Slowness "..Utils.Math.IntToRoman(Noob.GameplayConfig.Abilities.Reload.SlownessLevel)..
    --        "</b> for "..tostring(Noob.GameplayConfig.Abilities.Reload.Duration).." seconds.",
    --},
    --{
    --    Type = "Header",
    --    Text = Noob.GameplayConfig.Abilities.Justice.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = {
    --        "Noob shoots forward "
    --        ..tostring(Noob.GameplayConfig.Abilities.Justice.HitboxLength).." studs. If it hits the killer, they get stunned for "
    --        ..tostring(Noob.GameplayConfig.Abilities.Justice.StunTime).." seconds and receive "
    --        ..tostring(Noob.GameplayConfig.Abilities.Justice.Damage).." damage.",
    --        "This ability's charge is obtained through <b>Reload</b>."
    --    },
    --},

    
}

return Noob
