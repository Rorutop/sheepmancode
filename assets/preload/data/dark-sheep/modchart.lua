local wavy = false
local wavestop = false
local waveside1 = false
local waveside2 = false
local waveside3 = false
local waveside4 = false
local invishud = false
local camSide = false
local camSideEnable = false
local sway = false
function start (song)
    showOnlyStrums = true -- remove all huds
    strumLine2Visible =  false
    strumLine1Visible =  false
    mustHit = true

end

function update()
    -- SHIT IT NEVER FUCKING WORK I WONT MAKE CAMSIDE TO SIDE UNTIL SOMEONE FOUND HOW
    if camSide == true and camSideEnable == true then
        tweenCameraPos(20, 0, 1)
    else if camSide == false and camSideEnable == true then
        tweenCameraPos(-20, 0, 1)
    end
end
    if wavy == true then
        local currentBeat = (songPos / 1000)*(bpm/190)
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
    if invishud == true then
       for i = 0,3 do
                if getActorAlpha(i) ~= 0 then 
                    setActorAlpha(0,i)
                end
            end
        end
    if sway == true then
        camHudAngle = 5 * math.sin(currentBeat / 2)
    end
    if waveside1 == true then
        local currentBeat = (songPos / 1000)*(bpm/50)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 50 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end

    if waveside2 == true then
        local currentBeat = (songPos / 1000)*(bpm/50)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 35 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end

    if waveside3 == true then
        local currentBeat = (songPos / 1000)*(bpm/50)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 25 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
        
    if waveside4 == true then
        local currentBeat = (songPos / 1000)*(bpm/50)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 70 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
end
function beatHit(beat)
    if beat % 4 == 0 then
    camSide = not camSide
    end
end
function stepHit(step)
    if step == 2 then
        mustHit = false
    end
    if curStep == 3 then
        tweenCameraZoomOut(0.9, 3)
    end
    if step > 37 then
        showOnlyStrums = false
        strumLine2Visible =  true
        strumLine1Visible =  true
        tweenCameraZoomOut(0.44, 0.5)
	end
    if step == 37 then
        wavy = true
        sway = true
    end
    if step == 291 then
        wavy = false
        wavestop = true
    end

        -- Waveside start

        if step == 453 then -- 1
            waveside1 = true
        end
        if step == 455 then -- 1
            waveside2 = true
            waveside1 = false
        end
        if step == 458 then -- 1
            waveside3 = true
            waveside2 = false
        end
    
        if step == 462 then -- 2
            waveside1 = true
            waveside3 = false
        end
        if step == 464 then -- 2
            waveside2 = true
            waveside1 = false
        end
        if step == 466 then -- 2
            waveside3 = true
            waveside2 = false
        end
        
        if step == 469 then -- 3
            waveside1 = true
            waveside3 = false
        end
        if step == 471 then -- 3
            waveside2 = true
            waveside1 = false
        end
        if step == 473 then -- 3
            waveside3 = true
            waveside2 = false
        end
        
        if step == 477 then -- 4
            waveside1 = true
            waveside3 = false
        end
        if step == 481 then -- 4
            waveside1 = false
            waveside4 = true
        end
    
        if step == 485 then -- 1
            waveside1 = true
            waveside4 = false
        end
        if step == 487 then -- 1
            waveside2 = true
            waveside1 = false
        end
        if step == 490 then -- 1
            waveside3 = true
            waveside2 = false
        end
    
        if step == 494 then -- 2
            waveside1 = true
            waveside3 = false
        end
        if step == 496 then -- 2
            waveside2 = true
            waveside1 = false
        end
        if step == 498 then -- 2
            waveside3 = true
            waveside2 = false
        end
        
        if step == 502 then -- 3
            waveside1 = true
            waveside3 = false
        end
        if step == 504 then -- 3
            waveside2 = true
            waveside1 = false
        end
        if step == 506 then -- 3
            waveside3 = true
            waveside2 = false
        end
        
        if step == 509 then -- 4
            waveside1 = true
            waveside3 = false
        end
        if step == 514 then -- 4
            waveside1 = false
            waveside4 = true
        end
    
        if step == 517 then
            waveside3 = true
            waveside4 = false
        end

        -- Waveside END
    if step == 571 then
        waveside3 = false
        wavestop = true
    end
    if step == 580 then
        waveside3 = false
        wavestop = false
        wavy = true
    end
    if step == 837 then
        wavy = false
        wavestop = true
    end
    if step == 1460 then
        wavestop = false
    end


        --[[
            fuck you kade this downscroll == true shit doesnt work

            if you wanna find how to make the switching note shit, go to playstate.hx, and find "movenote"

            CREDIT TO vs TAEYAI and Rematch of Yourself mod for the tweenpos and playerstrums

     if curStep > 1450 and curStep < 1600 then
        tweenPos(1, 380, 50 , 0.4, done)
        tweenPos(3, 165, 50 , 0.4, done)
        tweenPos(7, 804, 50 , 0.4, done)
        tweenPos(5, 1020, 50, 0.4, done)
    if curStep > 1601 and curStep < 1718 then
        tweenPos(1, 190, 50, 0.5, done)
        tweenPos(3, 380, 50, 0.5, done)
        
        tweenPos(2, 250, 170, 0.5, done)
        tweenPos(6, 825, 170, 0.5, done)
        tweenPos(5, 885, 50, 0.5, done)
        tweenPos(7, 1020, 50, 0.5, done)
        tweenAngle(0, -180, 0.5, done)
        tweenAngle(3, 180, 0.5, done)
        tweenAngle(4, -180, 0.5, done)
        tweenAngle(7, 180, 0.5, done)
        ]]--
    if step == 1733 then
        wavy = true
    end
    if step == 1981 then
        wavy = false
        wavestop = true
    end
    -- Waveside start (again)

    if step == 1989 then -- 1
        wavestop = false
        waveside1 = true
    end
    if step == 1989 then -- 1
        waveside2 = true
        waveside1 = false
    end
    if step == 1997 then -- 1
        waveside3 = true
        waveside2 = false
    end

    if step == 1997 then -- 2
        waveside1 = true
        waveside3 = false
    end
    if step == 1999 then -- 2
        waveside2 = true
        waveside1 = false
    end
    if step == 2002 then -- 2
        waveside3 = true
        waveside2 = false
    end
    
    if step == 2005 then -- 3
        waveside1 = true
        waveside3 = false
    end
    if step == 2007 then -- 3
        waveside2 = true
        waveside1 = false
    end
    if step == 2010 then -- 3
        waveside3 = true
        waveside2 = false
    end
    
    if step == 2013 then -- 4
        waveside1 = true
        waveside3 = false
    end
    if step == 2018 then -- 4
        waveside1 = false
        waveside4 = true
    end

    if step == 2021 then -- 1
        waveside1 = true
        waveside4 = false
    end
    if step == 2024 then -- 1
        waveside2 = true
        waveside1 = false
    end
    if step == 2026 then -- 1
        waveside3 = true
        waveside2 = false
    end

    if step == 2029 then -- 2
        waveside1 = true
        waveside3 = false
    end
    if step == 2031 then -- 2
        waveside2 = true
        waveside1 = false
    end
    if step == 2034 then -- 2
        waveside3 = true
        waveside2 = false
    end
    
    if step == 2037 then -- 3
        waveside1 = true
        waveside3 = false
    end
    if step == 2040 then -- 3
        waveside2 = true
        waveside1 = false
    end
    if step == 2043 then -- 3
        waveside3 = true
        waveside2 = false
    end
    
    if step == 2046 then -- 4
        waveside1 = true
        waveside3 = false
    end
    if step == 2050 then -- 4
        waveside1 = false
        waveside4 = true
    end

    if step == 2053 then
        waveside3 = true
        waveside4 = false
    end

    -- Waveside END
    if step == 2109 then
        wavestop = true
        waveside3 = false
    end
    --ANOTHER ONE!
    if step == 2117 then -- 1
        waveside1 = true
        wavestop = false
    end
    if step == 2121 then -- 1
        waveside3 = true
        waveside1 = false
    end

    if step == 2125 then -- 2
        waveside1 = true
        waveside3 = false
    end
    if step == 2129 then -- 2
        waveside3 = true
        waveside1 = false
    end
    if step == 2133 then -- 3
        waveside1 = true
        wavestop = false
    end
    if step == 2137 then -- 3
        waveside3 = true
        waveside1 = false
    end
    if step == 2141 then -- 4
        waveside1 = true
        waveside3 = false
    end
    if step == 2144 then -- 4
        waveside1 = false
        waveside4 = true
    end
    if step == 2149 then -- 1
        waveside1 = true
        waveside4 = false
    end
    if step == 2153 then -- 1
        waveside3 = true
        waveside1 = false
    end

    if step == 2157 then -- 2
        waveside1 = true
        waveside3 = false
    end
    if step == 2161 then -- 2
        waveside3 = true
        waveside1 = false
    end
    if step == 2165 then -- 3
        waveside1 = true
        wavestop = false
    end
    if step == 2169 then -- 3
        waveside3 = true
        waveside1 = false
    end
    if step == 2173 then -- 4
        waveside1 = true
        waveside3 = false
    end
    if step == 2177 then -- 4
        waveside1 = false
        waveside4 = true
    end
    -- WAVESIDE END!!!
    if step == 2181 then
        waveside4 = false
        waveside3 = true
    end
    if step == 2237 then
        wavestop = true
        waveside3 = false
    end
    if step == 2245 then
        wavestop = false
        wavy = true
    end
end

print("Mod Chart script loaded :)")