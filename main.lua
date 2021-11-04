local eventsclass = shared.eventsclass

local hook = hookmetamethod

local hidden = {
    Archivable = false,
    ClassName = 'hidden',
    DataCost = math.huge,
    Name = 'Hidden',
    Parent = game,
    RobloxLocked = false,
    Changed = eventsclass:CreateEvent('changed _ hidden'),
    AncestryChanged = eventsclass:CreateEvent('AncestryChanged _ hidden'),
}

local mt = {
    __type = 'Instance',
    __tostring = function()
        return hidden.Name or hidden.ClassName
    end,
}

function hidden:Destroy()
   hidden.Changed:DisconnectAll()
   hidden.AncestryChanged:DisconnectAll()
   firesignal(game.ChildRemoved, hidden)
   firesignal(game.DescendantRemoving, hidden)
   
   hidden = nil 
end

setmetatable(hidden, mt)

old = hook(game, '__index', newcclosure(function(...)
    local self, index = ...
    if index == 'hidden' and hidden then
        return hidden
    end
    return old(...)
end))
firesignal(game.ChildAdded, hidden)
firesignal(game.DescendantAdded, hidden)
