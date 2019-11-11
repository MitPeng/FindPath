require("path")

if monster == nil then monster = {} end
-- 怪物出生
function monster:born(monster_name, born_point_name)
    local born_point = Entities:FindByName(nil, born_point_name)
    local monster = CreateUnitByName(monster_name, born_point:GetOrigin(),
                                     false, nil, nil, DOTA_TEAM_BADGUYS)
    monster:AddNewModifier(nil, nil, "modifier_phased", {duration = 0.1})
    return monster
end
-- 刷怪
-- 怪物名称，怪物行走路径点
-- local path_corners = {
--     "shuaguai_1", "shuaguai_2", "shuaguai_3", "shuaguai_4", "shuaguai_5",
--     "shuaguai_6"
-- }
function monster:shua_guai(monster_name, path_corners)

    local born_point_name = path_corners[1]
    local monster = monster:born(monster_name, born_point_name)
    path:find_path(monster, path_corners)

end
