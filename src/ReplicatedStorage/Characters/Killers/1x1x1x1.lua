local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local SoundService = game:GetService("SoundService")
local ServerStorage = game:GetService("ServerStorage")

local CommonFunctions = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions) or nil
local PlayerSpeedManager = RunService:IsServer() and require(game:GetService("ServerScriptService").Managers.PlayerManager.PlayerSpeedManager) or nil
local Character = require(ReplicatedStorage.Classes.Character)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Types = require(ReplicatedStorage.Classes.Types)
local Utils = require(ReplicatedStorage.Modules.Utils)
local Sounds = require(ReplicatedStorage.Modules.Sounds)

local Info = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local MasterSoundGroup = SoundService.SoundGroups.Master
local SoundFolder = SoundService.TempSounds
local BehaviorsModule = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Killers["1x1x1x1Behavior"])
print(BehaviorsModule)

local function TripleSlashBehavior(self : Types.Ability)
    print("triple slash")
    if RunService:IsServer() then
        BehaviorsModule.TripleSlash(self)
    end
end

local function ShockwaveBehavior(self : Types.Ability)
    if RunService:IsServer() then
        BehaviorsModule.Shockwave(self)
    end
end

local function UnstableEyeBehavior(self : Types.Ability)
    if RunService:IsServer() then
        BehaviorsModule.UnstableEye(self)
    end
end

--local function DataAnchorBehaviour(self: Types.Ability)
--    if RunService:IsServer() then
--        if self.Setup then
--            self.OwnerProperties.Character:PivotTo(self.PositionInfo)
        
--            if self.TeleporterInstance then
--                self.TeleporterInstance:Destroy()
--            end
        
--            self.PositionInfo = nil
--            self.Setup = false
--        else
--            self.Setup = true
        
--            self:AddConnection(task.delay(0.75, function()
--                self.DevicePosition = self.OwnerProperties.Character.HumanoidRootPart.Position - Vector3.new(0, 3 * self.OwnerProperties.Character:GetScale(), 0)
--                Sounds.PlaySound(self.PlaceSound, {
--                    Position = self.DevicePosition,
--                    RollOffMaxDistance = 35,
--                    RollOffMinDistance = 12,
--                    Name = self.Name,
--                    SoundGroup = SoundService.SoundGroups.Master.SFX,
--                })
--            end))
--            self:AddConnection(task.delay(0.917, function()
--                local TpInstance = self.CharModule.Config.TeleporterPrefab:Clone()
--                TpInstance:PivotTo(CFrame.new(self.DevicePosition))
--                TpInstance.Parent = workspace.Map.InGame
--                self.PositionInfo = self.OwnerProperties.Character:GetPivot()
--                self.TeleporterInstance = TpInstance
--            end))
--        end
--    else
--        if self.Setup then
--            self.Cooldown = self.FirstCooldown
--            self.Setup = false
--        else
--            self.Cooldown = self.SecondCooldown
--            self.Setup = true
        
--            self.OwnerProperties.SpeedManager:AddSpeedFactor(self.Name, 0)
        
--            self:PlayUseAnimation()
--            self:AddConnection(task.delay((self.UseAnimationTrack.Length or 1.7) + 0.4, function()
--                self.OwnerProperties.SpeedManager:RemoveSpeedFactor(self.Name)
--            end))
--        end
--    end
--end

--local function CallbackPingBehaviour(self: Types.Ability)
--    if RunService:IsServer() then
--        PlayerSpeedManager.AddSpeedFactor(self.Owner, self.Name, 0.18)
--        self.OwnerProperties.Character:SetAttribute("PreventSlash", true)

--        self:AddConnection(task.delay(self.Duration, function()
--            PlayerSpeedManager.RemoveSpeedFactor(self.owner, self.Name)
--            self.OwnerProperties.Character:SetAttribute("PreventSlash", false)
--        end))

--        return
--    end
--    task.defer(function()
--        local Sound = Instance.new("Sound")
--        Sound.Name = self.Name
--        Sound.SoundId = self.UseSound
    
--        --muffling all audio except for the callback ping sound
--        local Equalizer = Instance.new("EqualizerSoundEffect")
--        Equalizer.LowGain = -10
--        Equalizer.MidGain = 15
--        Equalizer.HighGain = 80
--        Equalizer.Parent = Sound
    
--        Sound.Parent = SoundFolder
    
--        Sound:Play()
--        Debris:AddItem(Sound, Sound.TimeLength + 1)
--    end)

--    self.OwnerProperties.FOVManager:AddFOVFactor(self.Name, 0.6)

--    task.defer(function()
--        local Equalizer = Instance.new("EqualizerSoundEffect")
--        Equalizer.LowGain = 0
--        Equalizer.HighGain = 0
--        Equalizer.MidGain = 0
--        Equalizer.Parent = MasterSoundGroup
--        TweenService:Create(Equalizer, Info, {LowGain = 10, MidGain = -15, HighGain = -80}):Play()

--        self:AddConnection(task.delay(self.Duration, function()
--            TweenService:Create(Equalizer, Info, {LowGain = 0, MidGain = 0, HighGain = 0}):Play()
        
--            self:AddConnection(task.delay(1, function()
--                Equalizer:Destroy()
--            end))
--        end))
--    end)

--    self:AddConnection(task.delay(self.Duration, function()
--        self.OwnerProperties.FOVManager:RemoveFOVFactor(self.Name)
--    end))

--    --shows all players' aura
--    for _, plr: Model in Utils.Character.GetCharactersWithRoles(false).Survivor or {} do
--        Utils.Player.RevealPlayerAura(plr, self.Duration)
--    end
--end

--function OverchargeBehaviour(self: Types.Ability)
--    if RunService:IsServer() then
--        CommonFunctions.ApplyEffect({
--            TargetHumanoid = self.OwnerProperties.Character:FindFirstChildWhichIsA("Humanoid"),
--            EffectSettings = {
--                Name = "Speed", 
--                Level = self.SpeedLevel, 
--                Duration = self.SpeedDuration
--            }
--        })

--        self:AddConnection(task.delay(self.SpeedDuration, function()
--            CommonFunctions.ApplyEffect({
--                TargetHumanoid = self.OwnerProperties.Character:FindFirstChildWhichIsA("Humanoid"),
--                EffectSettings = {
--                    Name = "Slowness", 
--                    Level = self.SlownessLevel, 
--                    Duration = self.SlownessDuration
--                }
--            })
--        end))
    
--        return
--    end
--end

--Character Definition
local _1x1x1x1: Types.Killer = Character.CreateKiller({
    Config = {
		Name = "1x1x1x1",
		Quote = "1x1x1x1",
		Render = "rbxassetid://135318203151705",
        Price = 1,

        Origin = {
			TooltipText = "1x1x1x1",
            Icon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        },

        

        AnimationIDs = {
            IdleAnimation = "rbxassetid://87431148823078",
            WalkAnimation = "rbxassetid://135521700365704",
            RunAnimation = "rbxassetid://135521700365704",
        },
    },
    
    GameplayConfig = {
        Abilities = {

            --Slash
            Slash = require(ReplicatedStorage.Classes.Ability.Slash).New({
                Duration = 0.5 -- this was way too
            }),

            TripleSlash = Ability.New({
                Name = "Triple Slash",
                InputName = "FirstAbility",
                Cooldown = 15,
                Behaviour = TripleSlashBehavior
            }),

            Shockwave = Ability.New({
                Name = "Shockwave",
                InputName = "SecondAbility",
                Cooldown = 25,
                Behaviour = ShockwaveBehavior
            }),

            UnstableEye = Ability.New({
                Name = "Unstable Eye",
                InputName = "ThirdAbility",
                Cooldown = 30,
                Behaviour = UnstableEyeBehavior
            }),

            --DataAnchor = Ability.New({
            --    Name = "Data Anchor",

            --    FirstCooldown = 3,
            --    SecondCooldown = 20,

            --    Cooldown = 3,

            --    InputName = "FirstAbility",

            --    PlayUseAnimationOnUse = false,
            --    UseAnimation = "rbxassetid://124469822398680",
            --    PlaceSound = "rbxassetid://5556648575",

            --    TeleporterInstance = nil,
            --    Setup = false,
            --    PositionInfo = CFrame.new(),

            --    Behaviour = DataAnchorBehaviour,
            --}),

            --CallbackPing = Ability.New({
            --    Name = "Callback Ping",
            --    Duration = 3,
            --    InputName = "ThirdAbility",
            --    Cooldown = 32.5,
            --    UseSound = "rbxassetid://72568635961241",
            --    Behaviour = CallbackPingBehaviour,
            --}),

            --Overcharge = Ability.New({
            --    Name = "Overcharge",
            --    Cooldown = 45,
            --    InputName = "FourthAbility",
            --    SpeedDuration = 3.2,
            --    SpeedLevel = 3,
            --    SlownessDuration = 1.5,
            --    SlownessLevel = 3,
            --    Duration = 4.7,
            --    DisableSlashOnPerform = false,
            --    Behaviour = OverchargeBehaviour,
            --}),
        },
    },
})

local _1x1x1x1NameLabel = "<font color=\"rgb(180, 180, 180)\">".._1x1x1x1.Config.Name.."</font>"
_1x1x1x1.Config.Description = {
    {
        Type = "Separator",
        Text = "GENERAL INFO",
    },
    {
        Type = "Header",
        Text = _1x1x1x1.Config.Name:upper(),
    },
    {
        Type = "Quote",
        Text = "\"".._1x1x1x1.Config.Quote.."\"",
    },
    {
        Type = "Text",
        Text = "Once a law enforcement automaton built to enforce order, now a void-born executioner of silence. "..
            _1x1x1x1NameLabel.." hunts those who trespass forbidden truths, warping space to pursue them through shadows. "..
            "With a surge of corrupted energy, he blinks across distance, accelerates beyond human reach, and rends with anomalous force. "..
            "None can hide — his gaze pierces walls, his touch unravels existence itself.",
    },
    {
        Type = "Header",
        Text = "STATS",
    },
    {
        Type = "Text",
        Text = {
            "Difficulty: ★★★☆☆",
            -- "Difficulty: 6 7",
            "Health: "..tostring(_1x1x1x1.GameplayConfig.Health),
            "Base Speed: "..tostring(_1x1x1x1.GameplayConfig.BaseSpeed),
            "Sprint Speed: "..tostring(math.round(_1x1x1x1.GameplayConfig.BaseSpeed * _1x1x1x1.GameplayConfig.SprintSpeedMultiplier * 10) / 10),
            "Max Stamina: "..tostring(_1x1x1x1.GameplayConfig.StaminaProperties.MaxStamina),
            "Stamina Loss per second: "..tostring(_1x1x1x1.GameplayConfig.StaminaProperties.StaminaDrain),
            "Stamina Gain per second: "..tostring(_1x1x1x1.GameplayConfig.StaminaProperties.StaminaGain),
        },
    },
    {
        Type = "Separator",
        Text = "ABILITIES",
    },
    {
        Type = "Header",
        Text = _1x1x1x1.GameplayConfig.Abilities.Slash.Name:upper(),
    },
    {
        Type = "Text",
        Text = _1x1x1x1NameLabel.." performs a basic slash, dealing "..tostring(_1x1x1x1.GameplayConfig.Abilities.Slash.Damage).." damage.",
        Image = "rbxassetid://9759886280",
    },
    --{
    --    Type = "Header",
    --    Text = _1x1x1x1.GameplayConfig.Abilities.CallbackPing.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = _1x1x1x1NameLabel.." slows down for "..tostring(_1x1x1x1.GameplayConfig.Abilities.CallbackPing.Duration).." seconds, revealing to him the aura of every single visible & alive survivor in the match that doesn't have <b>Undetectable</b>.",
    --},
    --{
    --    Type = "Header",
    --    Text = _1x1x1x1.GameplayConfig.Abilities.DataAnchor.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = {
    --        _1x1x1x1NameLabel.." places a device on the floor, visible to everyone clearly but undestructible.",
    --        "If this ability is used a second time, ".._1x1x1x1NameLabel.." will be teleported to this device instantly, destroying it in the process.",
    --    },
    --},
    --{
    --    Type = "Header",
    --    Text = _1x1x1x1.GameplayConfig.Abilities.Overcharge.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = _1x1x1x1NameLabel.." overloads his systems with electricity, giving him <b>Speed "..Utils.Math.IntToRoman(_1x1x1x1.GameplayConfig.Abilities.Overcharge.SpeedLevel).."</b> for "..tostring(_1x1x1x1.GameplayConfig.Abilities.Overcharge.SpeedDuration).." seconds. "..
    --    "When the effect wears off, his systems will exhaust briefly, inflicting him with <b>Slowness "..Utils.Math.IntToRoman(_1x1x1x1.GameplayConfig.Abilities.Overcharge.SlownessLevel).."</b> for "..tostring(_1x1x1x1.GameplayConfig.Abilities.Overcharge.SlownessDuration).." seconds.",
    --},
}

return _1x1x1x1
