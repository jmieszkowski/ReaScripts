# ReaScripts
Scripts for Reaper DAW

## 1. Set the color of selected tracks from their parent tracks
    Script colors selected tracks to their parent track`s color
   #### How to use:
    Select tracks that you want to color (you don`t have to unselect parent tracks) > run the script 
    
![Alt Text](https://github.com/jmieszkowski/ReaScripts/blob/master/gifs/set_track_color_github.gif)
        


      
      
      

## 2. Create folders from selected tracks 
    Script groups selected tracks according to thier names
   #### How to use:
    Select tracks that you want to group > run the script
    
![Alt Text](https://github.com/jmieszkowski/ReaScripts/blob/master/gifs/create_folder_github.gif)
#### Customization
##### Adding new words to tables
Basically what the script does, is taking track name and compares to table of strings. Tables are defined at the beginning of the script and can be edited - you can add some word, and if tracks name matches it, he will be added to some group.

```lua
  -- name of the table                                  words in table         
  namesOfDrumTracks = {"kick","snare", "tom","hi hat", "perc", "crash", "OH", "SN", "ride", "hat", "SD", "BD", "HH"}
```
e.g. You want to add tracks with name "KCK" to "DRUMS" folder, but it is not currently implemented. You just have to add "KCK" to the table. 

```lua
  namesOfDrumTracks = {"kick","snare", "tom","hi hat", "perc", "crash", "OH", "SN", "ride", "hat", "SD", "BD", "HH", "KCK"}
```
##### If track name matches any word in table namesOfDrumTracks he will be assigned to drums folder. If track name matches any word in table namesOfVocalTracks he will be assigned to vocal folder etc.
##### Important things:
script does not use full-match, it is more like "does the track name contains this word?".
e.g. if track name is kick12345-abcdefg-159846 it will match with "kick" from namesOfDrumTracks.
So if you add for example "T" as a word in same table, it would not work correctly, because it will match any track name which contains "T". Size of letters doesn not matter

##### Changing name of created folder
After defining tables, there is a section, where names of folder(parent) tracks are defined.
```lua
  guitarsParentTrackName = "GUITARS"
  stringsParentTrackName = "STRINGS"
  loopsParentTrackName = "LOOPS"
  synthsParentTrackName = "SYNTHS"
  pianosParentTrackName = "PIANOS"
  bassParentTrackName = "BASSES"
  drumsParentTrackName = "DRUMS"
  vocalsParentTrackName = "VOCALS"
```
e.g. if you want to set name of vocals parent track to for example "VOX". You just have to change the string to "VOX".
```lua
     vocalsParentTrackName = "VOX"
```

##### Adding your own table
You are able to create your own table, and that means you will have new folder of tracks, which track name matched words from this table. 
###### The syntax is:
```lua
    name_of_the_table = {"word1", "word2", "word3"}
```
e.g. if you want to create the table with names of the coolest guys you know, it would look like this :)
```lua
    theCoolestGuysYouKnow = {"jmieszkowski", "Jedrek", "Mieszkowski"}
```
And then you have to create variable containing name of parent track. Just add it after all parent track names(drumsParentTrackName,vocalsParentTrackName etc.)
```lua
    coolestGuysParentTrackName = "COOLEST GUYS"
```
This is not the end yet. Last think you have to do is actually call function, which creates the folder with your tracks. Just find this section of code and add your code as i did below
```lua
  createFolder(tracksIndexesThatUserSelected, namesOfStringTracks, stringsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfLoopsTracks, loopsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfSynthTracks, synthsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfPianoTracks, pianosParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfGuitarTracks, guitarsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfBassTracks, bassParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfDrumTracks, drumsParentTrackName)
  createFolder(tracksIndexesThatUserSelected, namesOfVocalTracks, vocalsParentTrackName)
  --            don`t change it!                name of table           name of parent track
  createFolder(tracksIndexesThatUserSelected, theCoolestGuysYouKnow, coolestGuysParentTrackName)
  
```
 And thats all! Enjoy!

     

