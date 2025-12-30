local allowedUsers = {
    [game.Players.LocalPlayer.UserId] = true
}

local p = game.Players.LocalPlayer
if not allowedUsers[p.UserId] then
    p:Kick("No access to AndyxHub")
    return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/andyxxtheboss/andyxhub/main/romania.lua"))()
