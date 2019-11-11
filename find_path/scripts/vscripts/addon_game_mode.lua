require("timers")
require("monster")
require("test")
-- Generated from template

if TestGameMode == nil then TestGameMode = class({}) end

function Precache(context)
    --[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
    GameRules.Event = TestGameMode()
    GameRules.Event:InitGameMode()
end

function TestGameMode:InitGameMode()
    print("Template addon is loaded.")
    GameRules:GetGameModeEntity().path_corners =
        {
            "shuaguai_1", "shuaguai_2", "shuaguai_3", "shuaguai_4",
            "shuaguai_5", "shuaguai_6"
        }
    -- 监听游戏进度
    ListenToGameEvent("game_rules_state_change",
                      Dynamic_Wrap(TestGameMode, "OnGameRulesStateChange"), self)
    -- 设置金钱每次增长
    GameRules:SetGoldPerTick(0)
    -- 设置金钱增长间隔
    GameRules:SetGoldTickTime(-1)
    -- 设置为真时，所有物品当处于任意商店范围内时都能购买到，包括秘密商店物品
    GameRules:SetUseUniversalShopMode(true)
    -- 设置选择英雄时间
    GameRules:SetHeroSelectionTime(10)
    -- 设置决策时间
    GameRules:SetStrategyTime(0)
    -- 设置展示时间
    GameRules:SetShowcaseTime(0)
    -- 设置游戏准备时间
    GameRules:SetPreGameTime(3.0)
    -- 设置不能买活
    GameRules:GetGameModeEntity():SetBuybackEnabled(false)
    -- 设置战争迷雾不可见
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
    -- 设置每个队伍人数
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 4)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
    GameRules:GetGameModeEntity():SetThink("OnThink", self, "GlobalThink", 2)
end

function TestGameMode:OnGameRulesStateChange(keys)
    print("OnGameRulesStateChange")

    -- 获取游戏进度
    local newState = GameRules:State_Get()

    -- 游戏开始
    if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        print("start game")
    end
end

-- Evaluate the state of the game
function TestGameMode:OnThink()
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        -- print( "Template addon script is running." )
        print("shuaguai_" .. GameRules:GetGameTime())
        -- test:shua_guai("xiong_guai")

        monster:shua_guai("xiong_guai",
                          GameRules:GetGameModeEntity().path_corners)
    elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
        return nil
    end
    return 1
end
