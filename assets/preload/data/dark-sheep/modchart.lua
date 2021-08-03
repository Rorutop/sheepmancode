local wavy = false
local arrowswitch1 = false
local wavestop = false
local waveshit = false
local invishud = false

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
   if wavestop == true then
        for i = 0,7 do
            setActorX(_G['defaultStrum'..i..'X']+(math.cos(os.clock())*0),i)
            setActorY(_G['defaultStrum'..i..'Y']+(math.sin(os.clock())*0),i)
        end
    end
    if invishud == true then
       for i = 0,3 do
                if getActorAlpha(i) ~= 0 then 
                    setActorAlpha(0,i)
                end
            end
        end
    if waveshit == true then
        local currentBeat = (songPos / 1000)*(bpm/60)
        for i = 2,0,2 do
            setActorX(_G['defaultStrum'..i..'X']+(math.cos(os.clock())*0),i)
            setActorY(_G['defaultStrum'..i..'Y']+(math.sin(os.clock())*2),i)
        end
    end
        
end

function stepHit(step)
    if still then
        setCamZoom(1.30)
        setHudZoom(1.07)
    end
    if step >= -3 and effectnum == 0 then
        effectnum = 1
        showOnlyStrums = true
        tweenCameraZoomOut(1.30,55,"fixcamzoom")
        tweenHudZoomOut(1.07,55,"fixcamzoom")
    elseif step >= 32 and effectnum == 1 then
        effectnum = 2
        for i = 0,7 do
            tweenFadeIn(i,0,0.03)
        end
        tweenFadeIn(white,1,0.3,"unpop")
    elseif step >= 37 and effectnum == 3 then
        effectnum = 4
        for i = 0,7 do
            tweenFadeIn(i,1,1.5)
        end
    elseif step >= 37 and effectnum == 4 then
        effectnum = 5
        showOnlyStrums = false
        end

    if step == 37 then
        wavy = true
    end
    if step == 291 then
        wavy = false
        wavestop = true
    end
    if step == 580 then
        wavy = true
        wavestop = false
    end
    if step == 837 then
        wavy = false
        wavestop = true
    end
    if curStep > 1477 and curStep < 1600 then
        wavestop = false
        tweenPos(1, 380, 50, 0.1, done)
        tweenPos(3, 165, 50, 0.1, done)
        tweenPos(7, 804, 50, 0.1, done)
        tweenPos(5, 1020, 50, 0.1, done)
    end
    if curStep > 1600 and curStep < 1718 then
        tweenPos(1, 220, 50, 1, done)
        tweenPos(3, 380, 50, 1, done)
        tweenPos(2, 220, 170, 1, done)
        tweenPos(6, 855, 50, 1, done)
        tweenPos(5, 855, 170, 1, done)
    if step == 1718 then
        wavestop = true
    end
    end
end
-- 1600

print("Mod Chart script loaded :)")