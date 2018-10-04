function spawnACralwer(townid, townid2)
    x, y, z = Spring.GetUnitPosition(townid)
    p1x, p1y, p1z = Spring.GetUnitPosition(townid2)
    cra = spCreateUnit("gCrawlerFeeder", p1x, p1y, p1z, 1, _gaiaTeam)
    Spring.GiveOrderToUnit(cra, CMD.MOVE, { x, y, z }, { "shift" })
    return cra
end

function spawnThreeTowns()

    tables = Spring.GetTeamList()
    pos = {}
    for i = 1, #tables, 1 do
        tid, _, _, _, side, _, _, _ = Spring.GetTeamInfo(tables[i])
        if tid and (string.lower(side) == "centrail" or string.lower(side) == "journeyman") then
            X, Y, Z = Spring.GetTeamStartPosition(tid)
            if X then
                pos[tables[i]] = {}
                pos[tables[i]] = { x = X, y = Y, z = Z }
            end
        end
    end

    max = 0
    teamA, teamB = 0, 0

    for k, _ in pairs(pos) do
        for ki, _ in pairs(pos) do
            dist = math.sqrt((pos[k].x - pos[ki].x) ^ 2 + (pos[k].y - pos[ki].y) ^ 2 + (pos[k].z - pos[ki].z) ^ 2)
            if max < dist then
                teamA = k
                teamB = ki
                max = dist
            end
        end
    end

    if (teamA == teamB) then
        pos[teamA] = { x = math.ceil(Game.mapSizeX * 0.8), y = 0, z = math.ceil(Game.mapSizeZ * 0.8) }
        pos[teamB] = { x = math.ceil(Game.mapSizeX * 0.2), y = 0, z = math.ceil(Game.mapSizeZ * 0.2) }
    end

    --midx,midy,midz=(pos[teamA].x+pos[teamB].x)/2,0,(pos[teamA].z+pos[teamB].z)/2
    midx, midy, midz = Game.mapSizeX / 2, 0, Game.mapSizeZ / 2
    m = (-1 * midx) / midz




    spCreateUnit("gdecfields", midx, midy, midz, 1, _gaiaTeam)
    if math.random(0, 6) == 2 then
        --S-pCreateUnit("gdecstonecircle",midx+350,midy,midz-350,1, _gaiaTeam)
    end
    id1 = spCreateUnit("gkiva", midx, midy, midz, 0, _gaiaTeam)


    halfway = Game.mapSizeX * 0.20

    kx, kz = midx + halfway, (midz + halfway * math.random(-1, 1))
    id2 = spCreateUnit("gkiva", kx, midy, kz, 0, _gaiaTeam)
    spCreateUnit("gdecfields", kx, midy, kz, 1, _gaiaTeam)

    kx, kz = midx - halfway, (midx - halfway * math.random(-1, 1))
    id3 = spCreateUnit("gkiva", kx, midy, kz, 0, _gaiaTeam)
    spCreateUnit("gdecfields", kx, midy, kz, 1, _gaiaTeam)

    return id1, id2, id3
end

function Mission4Crawler(frame)
    --MissionFunctionTable[3][]


    --test for one player beeing combine, one beeing journeys
    if MissionFunctionTable == nil or MissionFunctionTable[4] == nil then return true end
    if MissionFunctionTable[4][2] == nil then MissionFunctionTable[4][2] = frame end
    if MissionFunctionTable[4][3] == nil then
        MissionFunctionTable[4][3] = {}
        MissionFunctionTable[4][3] = 0
    end
    if boolDebug == true then
        cout("Mission @::", MissionFunctionTable[4][3])
        cout("MissionTime::", frame - MissionFunctionTable[4][2])
    end

    mT = frame - MissionFunctionTable[4][2]

    if MissionFunctionTable[4][3] == 0 then
        cout("JW_MiniMIssion:: Mission 4 started")
        strings = "The Province Aarnon, contains several prosperous villages. The downtoarth townfolks is nice, hardworking." ..
                "They earned what they got." ..
                "- Which is why we are planning to rob, rape and pilver them blind, torch the town and stripmine there sacred burrial grounds.." ..
                ".. all for the cause of causes - bitches and riches. We expect no resistance, except from the other guys across the valley, who basically do the same" ..
                ".. but having a better PR-Department, call it police action, nation building or not-unlike-your-mother-words-are-cheap." ..
                "One last thing. Know that the sisterhood of the Crystallforrest is traversing the landscape,terraforming, rebuilding destroyed settlements." ..
                "If- they see you going 'Yes-we-Khan' on some villagers, they will rile up the whole planet- drag you before a interdimensional-court." ..
                " So no wittnesses.. not even if they have a cute smile or a nice ass. "
        T = prepSpeach(strings, Name, charPerLine, Alpha, DefaultSleepByline)
        say(T, 25000, NameColour, TextColour, OptionString, UnitID)
        spPlaySound("sounds/Missions/missionBriefing.ogg", 1)
        MissionFunctionTable[4][3] = MissionFunctionTable[4][3] + 1
    end

    if MissionFunctionTable[4][3] == 1 then
        -- spawn the three towns
        id1, id2, id3 = spawnThreeTowns()
        --S-pawn the crawler
        CrawlerID = spawnACralwer(id1, id3)
        Spring.SetUnitNeutral(CrawlerID, true)
        Spring.SetUnitAlwaysVisible(id1, true)
        Spring.SetUnitAlwaysVisible(id2, true)
        Spring.SetUnitAlwaysVisible(id3, true)

        MissionFunctionTable[4][4] = { town1 = id1, town2 = id2, town3 = id3, Crawler = CrawlerID }
        GG.Mission4Table = {}
        GG.Mission4Table[id1] = id1
        GG.Mission4Table[id2] = id2
        GG.Mission4Table[id3] = id3
        GG.Mission4Table[CrawlerID] = CrawlerID

        --Preparations Route ConditionRacist Sandmandala
        boolMission4Watch = true
        MissionFunctionTable[4][3] = MissionFunctionTable[4][3] + 1
        return false
    end

    if MissionFunctionTable[4][3] == 2 then
        if Spring.GetUnitIsDead(MissionFunctionTable[4][4].Crawler) == true then return true end
        ux, uy, uz = Spring.GetUnitPosition(MissionFunctionTable[4][4].Crawler)



        --Town 2 is down
        if Spring.GetUnitIsDead(MissionFunctionTable[4][4].town2) == true then
            local Tab = GG.Mission4Table[MissionFunctionTable[4][4].town2]
            px, py, pz = Tab.x, Tab.y, Tab.z
            Spring.GiveOrderToUnit(MissionFunctionTable[4][4].Crawler, CMD.MOVE, { px, py, pz })
            if (math.abs(px - ux + pz - uz) < 120) then
                MissionFunctionTable[4][4].town2 = spCreateUnit("gkiva", Tab.x, Tab.y, Tab.z, 0, _gaiaTeam)
                GG.Mission4Table[MissionFunctionTable[4][4].town2] = Tab
            end
        end

        --Town 3 is down
        if Spring.GetUnitIsDead(MissionFunctionTable[4][4].town3) == true then
            local Tab = GG.Mission4Table[MissionFunctionTable[4][4].town3]
            px, py, pz = Tab.x, Tab.y, Tab.z
            Spring.GiveOrderToUnit(MissionFunctionTable[4][4].Crawler, CMD.MOVE, { px, py, pz })
            if (math.abs(px - ux + pz - uz) < 120) then
                MissionFunctionTable[4][4].town3 = spCreateUnit("gkiva", Tab.x, Tab.y, Tab.z, 0, _gaiaTeam)
                GG.Mission4Table[MissionFunctionTable[4][4].town3] = Tab
            end
        end



        --Town 1 is down
        if Spring.GetUnitIsDead(MissionFunctionTable[4][4].town1) == true then
            Tab = GG.Mission4Table[MissionFunctionTable[4][4].town1]
            px, py, pz = Tab.x, Tab.y, Tab.z
            Spring.GiveOrderToUnit(MissionFunctionTable[4][4].Crawler, CMD.MOVE, { px, py, pz })
            if (math.abs(px - ux + pz - uz) < 120) then
                MissionFunctionTable[4][4].town1 = spCreateUnit("gkiva", Tab.x, Tab.y, Tab.z, 0, _gaiaTeam)
                GG.Mission4Table[MissionFunctionTable[4][4].town1] = Tab
            end
        end

        return false
    end

    return true
    -- return true -- the final Case everytime it gribs- the mission ends
end


Mission4Table = {}
ThatsAHorribleThingToSay = {
    "Mission: Cauterize, Sterilize, Desinfect!",
    "You can run, but you can not hide. Because your skin stayed here ",
    "Democracy and atrocities dont exlude each other. Anyone of a diffrent opinion and still having a hand please raise it..",
    "Nothing against stress like the sacking of a city - though the sight aint pretty-",
    "Article 4, Paragraph 5 of the Centrail War Convention explicitly forbids.. law from having the last word!",
    "Chug! Chug! Chug! Drink till you dont give a fuck, wheres the platin at that you stuck- up the pooper? tell the trooper!",
    "Raise arms, take aim! FIRE! Now, next on the list.. question the prisoners.. shiit!",
    "I know newbie, they dont look like rebells. But then why run and hide, if they were not?",
    "Dont burn the sheds, before the whine cellars are emptyied.",
    "Imagine the pain in the ass to find all this stuff, but ring the warbell, and every fool the bell tolds assembles its valueluaables in one spot.",
    "For civilisation, for culture, for all the values we hold high! For irony!",
    "Lets make this intersting for both of us. Everytime i come, one of your beloved walks away with his life. Game, set, go..",
    "Even babarians can be health aware. Raping everyone on the bodys of there beloveds, is so much better for the knees",
    "Search the houses. If it reflects light, whack it, if it still reflects light, sack it.",
    "Cattle. Check. Furniture. Check. Slaves. Check. Rape,Murder, Torture.Check",
    "Let them go. Then set the fields on fire! Let them run! Run forrest, run! Then set the forrest on fire!",
    "Life is short, brutal und unfair. Man is man a wulf. Give the hideouts away, and get on with it-",
    "You know, if there is resistance, if the food fights and screams, its improves the taste. Dont just lay there..",
    "Its like shopping, just without the paying part. And its one-way. And afterwards there is no shop and shopkeeper..",
    "Okay, everbody line up. He who gives aways the most neighbours riches, will be spared!",
    "The whoreroar, the whoreroar!",
    "Now if we left somebody alive to tell, that would be glorifying violence!",
    "Try to see the good side of this. Three generations down the road, you would be butchering each other..",
    "Ah, this brings back lovely memories. 16 years ago, at that very spot, i was allready raping your mother..",
    "Pray louder peasants, god is deaf from all the guns.",
    "One would expect of them to learn, not to use wood for buildings to barricade oneself in.. but with the no-survivor-bias",
    "Quit standing around, this is a disciplined operation, no smoking breaks during raids!",
    "All that in a honest hour of jerking. Im so proud of you son!",
    "Hey, hey, im not just any looter, im a trained professional. Got a Master in Thieving, Rape and Robbing, even stole a certificate. And its property-owner-transfer - not robbery!",
    "You know, i m thinking about training one of those peasants, to do the looting for me, and retire.",
    "5 out of 6 persons, enjoy a good gangbang.",
    "Look at your horse, your horse was amazing!",
    "Golden Teeths, the seem like a good investment for hard times.. Then the hard times facefist you, so you chew on the hard times.",
    "One of those days, were the most popular maiden in town, becomes the town in the most popular maiden.",
    "Okay, those of you who have deadly diseases, and are not fit for organ donation, step forward..",
    "Help, help - is there a Doctor in the House? Preferable one that is not house.",
    "Two hands, three holes, what a dilema.",
    "You know, when i was young, our farm got robbed and everyone else killed. And now we get back. It is not the same town, not the same robber, hell im not even on the right side..",
    "I know, they  promised you, if you good faithfull lives, you would go to heaven. \n" ..
            "And guess what- he bought himself a ticket out with your donations.",
    "Impaling is so babaric, burrying alive so much work, shooting them is conventional - tough choices, anybody suggestions?",
    "Remember what your authoritys said- pluck your nose - and bam- evil man everywhere. Now, lets not point fingers- but..",
    "Arr, antoher of those towns. Keep the womanfolk on the fields and sell the goats as lust-slaves.",
    "For some its just corpse-kama-sutra, but for others its the longest fucking with aerchologists, since the invention of culture.",
    "Sometimes you just come to late, word of mouth was there first, and all the murder, thiefing, raping and torching is done by the locals. Well at least they left the blame behind",
    "You think cynism makes for good jokes? No, cynism makes for dead critics. And dead critics make for good jokes.",
    "The times are hard, until you robbed enough to pay your own historian and can afford to have a good time.",
    "And we proof once again, that salt water burns orange on a stake. Its the natrium - not the witches.",
}

boolMission4Watch = false
function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)

    if boolMission4Watch == true and GG.Misson4Table and GG.Misson4Table[unitID] ~= nil then
        --Crime and (not) Punishment
        --attacking the crawler
        if unitID == MissionFunctionTable[4][4].Crawler then
            Spring.UseTeamResource(attackerTeam, "metal", 666)
            Spring.UseTeamResource(attackerTeam, "energy", 666)
        else
            Spring.AddTeamResource(attackerTeam, "metal", damage)
            Spring.AddTeamResource(attackerTeam, "energy", damage)
        end

        --Thats a horrible Thing to say
        if math.random(0, 12) == 6 then
            T = prepSpeach(ThatsAHorribleThingToSay[math.floor(math.random(1, #ThatsAHorribleThingToSay))], Name, charPerLine, Alpha, DefaultSleepByline)
            say(T, 25000, NameColour, TextColour, OptionString, UnitID)
            spPlaySound("sounds/Missions/missionBriefing.ogg", 1)
        end
    end
end
	