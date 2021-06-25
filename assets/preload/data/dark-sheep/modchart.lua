local wavy = false
local arrowswitch1 = false
local waveshit = false

function update()
    if wavy == true then
        local currentBeat = (songPos / 1000)*(bpm/190)
        for i=0,7 do
            setActorX(_G['defaultStrum'..i..'X'] + 20 * math.sin((currentBeat + i*0.25) * math.pi), i)
            setActorY(_G['defaultStrum'..i..'Y'] + 20 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
     end
    if arrowswitch1 == true then
        for i = 0,0,0.25 do
        setActorX(_G["defaultStrum"..2+i.."X"],0)
        setActorY(_G["defaultStrum"..0+i.."X"],2)
    end
   end
   if waveshit == true then
        for i = 0,7 do
            setActorX(_G['defaultStrum'..i..'X']+(math.cos(os.clock())*12),i)
            setActorY(_G['defaultStrum'..i..'Y']+(math.sin(os.clock())*12),i)
        end
    end

end

function stepHit(step)
    if step == 37 then
        wavy = true
    end
    if step == 291 then
        wavy = false
        waveshit = true
    end
    if step == 580 then
        wavy = true
        waveshit = false
    end
end

print("Mod Chart script loaded :)")