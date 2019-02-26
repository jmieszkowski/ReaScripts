function Main()
  
  -- this tables contain words that script uses to filter, feel free to add your own words!
  -- BUT BE CAREFUL, script doesn`t use full-match, it`s more like "does the track name contains this word?"
  -- e.g. if track name is kick12345-abcdefg-159846 it will match with "kick" from namesOfDrumTracks
  -- so if you add for example "T" as a word in same table, it wouldn`t work correctly!
  -- size of letters doesn`t matter
  namesOfDrumTracks = {"kick","snare", "tom","hi hat", "perc", "crash", "OH", "SN", "ride", "hat", "SD", "BD", "HH"}
  namesOfVocalTracks = {"voc", "vox", "choir", "vc"}
  namesOfGuitarTracks = {"GTR", "guitar", "GIT", "GT"}
  namesOfStringTracks = {"violin", "cello", "viola"}
  namesOfBassTracks = {"bass","808", "bas"}
  namesOfLoopsTracks = {"loop"}
  namesOfSynthTracks = {"synth", "synthesizer"}
  namesOfPianoTracks = {"keys", "piano"}
  
  -- this variables contain names of parent(folder) tracks
  -- edit them if you want, by putting a word between quotation marks ""
  -- e.g. default: drumsParentTrackName = "DRUMS" 
  --      edited:  drumsParentTrackName = "MY DRUMS"
  guitarsParentTrackName = "GUITARS"
  stringsParentTrackName = "STRINGS"
  loopsParentTrackName = "LOOPS"
  synthsParentTrackName = "SYNTHS"
  pianosParentTrackName = "PIANOS"
  bassParentTrackName = "BASSES"
  drumsParentTrackName = "DRUMS"
  vocalsParentTrackName = "VOCALS"
  
  
  -- whoever you are, better DON`T change it!
  commandID = reaper.NamedCommandLookup("_SWS_MAKEFOLDER")-- this variable holds the sws command ID
  
  -- whoever you are, better DON`T change it!
  tracksIndexesThatUserSelected = {} -- that table holds indexes of tracks that user selected + parent tracks that are created
                                     -- by the script
  
  
  -- THIS SECTION FROM HERE ----------------------------------------------------------------
  -- is used to insert indexes of all tracks that user selected, to table(tracksToSelect)    
                                                                 
  numberOfTracks = reaper.CountSelectedTracks(0)
                                          
  for i = 0,numberOfTracks-1,1 do
    track = reaper.GetTrack(0,i) 
    index = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER")
    table.insert(tracksIndexesThatUserSelected,index)
    reaper.SetMediaTrackInfo_Value(track,"I_SELECTED",0) 
  end                                        
  -- TO HERE --------------------------------------------------------------------------------
  
  -- this is actual call of function that creates folder
  
  createFolder(tracksIndexesThatUserSelected, namesOfStringTracks, stringsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfLoopsTracks, loopsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfSynthTracks, synthsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfPianoTracks, pianosParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfGuitarTracks, guitarsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfBassTracks, bassParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfDrumTracks, drumsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfVocalTracks, vocalsParentTrackName)
  
  end
  

-- function creates folder from tracks which names suits to specific table (e.g. namesOfDrumTracks)
function createFolder(tracksToSelect,tableWithTrackNames, nameOfParentTrack)
  local isAnyTrackAddedToThisGroup = false
  
  for i = 0, tableLength(tracksToSelect)-1, 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track, "")
    
    if contains(tableWithTrackNames, track_name) then
      reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",1)
      isAnyTrackAddedToThisGroup = true
    end
  end
  
  if isAnyTrackAddedToThisGroup == true then -- validate if there is any track of this group, don`t want to create empty folder
    reaper.InsertTrackAtIndex(0,0) -- insert track at the begining of the project, it will be parent track
    table.insert(tracksToSelect,tableLength(tracksToSelect)) -- insert one more element to this table, it holds indexes of 
                                                           -- all tracks that are currently in this project
          
    local parent_track = reaper.GetTrack(0,0) -- take this track which i just inserted
  
    reaper.GetSetMediaTrackInfo_String(parent_track, "P_NAME" ,nameOfParentTrack, true)
    reaper.SetMediaTrackInfo_Value(parent_track, "I_SELECTED", 1)
    reaper.ReorderSelectedTracks(1,1) -- reorder all selected tracks, i need this, because sws - make folder from selected tracks
                                    -- works only for tracks that are directly in touch with each other
    reaper.SetMediaTrackInfo_Value(parent_track, "I_FOLDERCOMPACT", 2)
                                
    reaper.Main_OnCommandEx(commandID, 0, 0) -- it executes sws make folder from selected tracks
  end
  clearSelect(tracksToSelect) -- clear selects, this function have already made a folder for selected tracks, so there is no need
                              -- to hold them selected
end

-- function unselects all tracks that are currently selected
-- without this script doesn`t work, because it creates folder from selected tracks, so they have to be unselected
-- after script creates a folder from them
function clearSelect(tracksToSelect)
  for i = 0, tableLength(tracksToSelect)-1, 1 do
    track = reaper.GetTrack(0, i)
    reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",0)
  end
end

-- function gets table and returns its length
-- i used it to program loops
function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
    return count
end
  
-- function checks if table contains specific string
-- i used it to check if table contains track name
-- for example if namesOfDrumsTracks contains "kick"(track name)
function contains(tab,name)
  for i=1, tableLength(tab),1 do
   if string.match(string.upper(name), string.upper(tab[i])) then -- i convert strings to uppercase letters because
    return true                                                   -- it eliminates the problem with comparison strings
   end                                                            -- with lowercase and uppercase letters :)
  end
  return false
end




Main()
