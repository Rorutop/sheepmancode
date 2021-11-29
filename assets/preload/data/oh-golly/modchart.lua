local wavy = false
local wavestop = false
function update()
    if wavy == true then
        local currentBeat = (songPos / 1000)*(bpm/140)
        for i=0,7 do
            setActorX(_G['defaultStrum'..i..'X'] + 20 * math.sin((currentBeat + i*0.25) * math.pi), i)
            setActorY(_G['defaultStrum'..i..'Y'] + 20 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
     end
    if wavestop == true then
        for i = 0,7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.5, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.5, 'setDefault')
        end
    end
end
function stepHit(step)
if step == 512 then
    wavy = true
end
if step == 630 then
    wavy = false
    wavestop = true
end
if step == 639 then
    wavestop = false
end 
end