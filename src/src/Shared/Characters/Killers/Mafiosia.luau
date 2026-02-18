local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local SoundService = game:GetService("SoundService")

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

--This killer might also be scrapped

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
local Mafiosia: Types.Killer = Character.CreateKiller({
    Config = {
		Name = "Mafioso",
		Quote = "Who the hell invited this guy",
		Render = "rbxassetid://104863269332560",
        Price = 10000,

        Origin = {
			TooltipText = "Originates From Frozen Soul (DG)",
           Icon = "rbxassetid://103901904214064",
        },

        TeleporterPrefab = script.NullexTeleporter,

        AnimationIDs = {
            IdleAnimation = "rbxassetid://80822449179790",
            WalkAnimation = "rbxassetid://108358384740054",
            RunAnimation = "rbxassetid://83714568409210",
        },
    },
    
    GameplayConfig = {
        Abilities = {

            --Slash
            Slash = require(ReplicatedStorage.Classes.Ability.Slash).New({
                Duration = 0.35,
                UseAnimation = "rbxassetid://113267778065989",
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

local MafiosiaNameLabel = "<font color=\"rgb(180, 180, 180)\">"..Mafiosia.Config.Name.."</font>"
Mafiosia.Config.Description = {
    {
        Type = "Separator",
        Text = "GENERAL INFO",
    },
    {
        Type = "Header",
        Text = Mafiosia.Config.Name:upper(),
    },
    {
        Type = "Quote",
        Text = "\""..Mafiosia.Config.Quote.."\"",
    },
    {
        Type = "Text",
        Text = "A Entitled Mafia Leader under Eunoia's Lead,"..
         "  he is currently scrapped and only useable by developers.",
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
            "Health: "..tostring(Mafiosia.GameplayConfig.Health),
            "Base Speed: "..tostring(Mafiosia.GameplayConfig.BaseSpeed),
            "Sprint Speed: "..tostring(math.round(Mafiosia.GameplayConfig.BaseSpeed * Mafiosia.GameplayConfig.SprintSpeedMultiplier * 10) / 10),
            "Max Stamina: "..tostring(Mafiosia.GameplayConfig.StaminaProperties.MaxStamina),
            "Stamina Loss per second: "..tostring(Mafiosia.GameplayConfig.StaminaProperties.StaminaDrain),
            "Stamina Gain per second: "..tostring(Mafiosia.GameplayConfig.StaminaProperties.StaminaGain),
        },
    },
    {
        Type = "Separator",
        Text = "ABILITIES",
    },
    {
        Type = "Header",
        Text = Mafiosia.GameplayConfig.Abilities.Slash.Name:upper(),
    },
    {
        Type = "Text",
        Text = MafiosiaNameLabel.." performs a basic slash, dealing "..tostring(Mafiosia.GameplayConfig.Abilities.Slash.Damage).." damage.",
        Image = "rbxassetid://9759886280",
    },
    --{
    --    Type = "Header",
    --    Text = Mafiosia.GameplayConfig.Abilities.CallbackPing.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = MafiosiaNameLabel.." slows down for "..tostring(Mafiosia.GameplayConfig.Abilities.CallbackPing.Duration).." seconds, revealing to him the aura of every single visible & alive survivor in the match that doesn't have <b>Undetectable</b>.",
    --},
    --{
    --    Type = "Header",
    --    Text = Mafiosia.GameplayConfig.Abilities.DataAnchor.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = {
    --        MafiosiaNameLabel.." places a device on the floor, visible to everyone clearly but undestructible.",
    --        "If this ability is used a second time, "..MafiosiaNameLabel.." will be teleported to this device instantly, destroying it in the process.",
    --    },
    --},
    --{
    --    Type = "Header",
    --    Text = Mafiosia.GameplayConfig.Abilities.Overcharge.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = MafiosiaNameLabel.." overloads his systems with electricity, giving him <b>Speed "..Utils.Math.IntToRoman(Mafiosia.GameplayConfig.Abilities.Overcharge.SpeedLevel).."</b> for "..tostring(Mafiosia.GameplayConfig.Abilities.Overcharge.SpeedDuration).." seconds. "..
    --    "When the effect wears off, his systems will exhaust briefly, inflicting him with <b>Slowness "..Utils.Math.IntToRoman(Mafiosia.GameplayConfig.Abilities.Overcharge.SlownessLevel).."</b> for "..tostring(Mafiosia.GameplayConfig.Abilities.Overcharge.SlownessDuration).." seconds.",
    --},
}

return Mafiosia
