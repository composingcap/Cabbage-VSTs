<Cabbage>
form caption("Idle Chatter Box") size(400, 180), colour("grey"), pluginid("chtr")
bundle("Atari.lpc", "BassClarinetSounds.lpc", "Child.lpc", "FemVoice.lpc", "Italian.lpc", "Medevil.lpc", "OboeMultiphonics.lpc", "Protection.lpc", "Xavier.lpc") 
keyboard bounds(142, 10, 250, 80)
rslider bounds(8, 10, 80, 40) text("Grain Period") range(0.03125, 1, 0.25, 1, 0.03125)  channel("period") trackercolour("black") textcolour("black")
rslider bounds(8, 50, 80, 40) text("Grain Length") range(0.03125, 1, 0.125, 1, 0.03125)  channel("len") trackercolour("black") textcolour("black")
rslider bounds(70, 10, 80, 40) text("Random") range(0, 1, 0, 1, 0.0675)  channel("periodR") trackercolour("black") textcolour("black")
rslider bounds(70, 50, 80, 40) text("Random") range(0, 1, 0, 1, 0.0675)  channel("lenR") trackercolour("black") textcolour("black")
combobox channel("lpcFile") items("FemVoice", "Atari", "Child", "Italian", "Medevil", "Protection", "Xavier", "OboeMultiphonics", "BassClarinetSounds") mode(1) bounds(8,100,75,14)
groupbox text("grain envelope") bounds(100,100,130,70){
    label bounds(15,25,150,17) text("A    D    S    R") align("left")
    rslider bounds(10,40,20,20) channel("gA") range(0.01,1,0.2,1,0.01)
    rslider bounds(40,40,20,20) channel("gD") range(0.01,1,0.2,1,0.01)
    rslider bounds(70,40,20,20) channel("gS") range(0, 1, 0.5, 1, 0.01)
    rslider bounds(100,40,20,20) channel("gR") range(0.01,1,0.2,1,0.01)

}

groupbox text("voice envelope") bounds(250,100,130,70){
    label bounds(15,25,150,17) text("A    D    S    R") align("left")
    rslider bounds(10,40,20,20) channel("vA") range(0.01,5,0.5,0.5,0.01)
    rslider bounds(40,40,20,20) channel("vD") range(0.01,5,0.5,0.5,0.01)
    rslider bounds(70,40,20,20) channel("vS") range(0, 1, 0.75, 1, 0.01)
    rslider bounds(100,40,20,20) channel("vR") range(0.01,5,1,0.5,0.01)

}

bundle("FemVoice.lpc")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1



;instrument will be triggered by keyboard widget
instr 1

Sitems[] fillarray "FemVoice", "Atari", "Child", "Italian", "Medevil", "Protection", "Xavier", "OboeMultiphonics", "BassClarinetSounds"
kname chnget "lpcFile" 
gSname sprintfk "%s.lpc", Sitems[kname-1]

iA chnget "vA"
iD chnget "vD"
iS chnget "vS"
iR chnget "vR"


kEnv madsr iA, iD, iS, iR

iLen init 16 ;Length in seconds
kRatio chnget "period"
kRatioR chnget "periodR"
kRatio = limit(kRatio+random(-kRatioR,kRatioR), 0.0675, 2) 

kBPM chnget "HOST_BPM"

kLength chnget "len"
kLengthR chnget "lenR"
kLength = limit(kLength+random(-kLengthR,kLengthR), 0.0675, 2) 

if kBPM == 0 then
    kBPM = 120
endif

kFreq = 1/kRatio*(kBPM/60)

kTrig metro kFreq 

if kTrig == 1 then
    event "i", 2, 0, kLength*(kBPM/60), p4, p5, kEnv
endif



endin

instr 2



kTime random 0,1
iTime = i(kTime)

iA chnget "gA"
iD chnget "gD"
iS chnget "gS"
iR chnget "gR"

iADSRTotal = iA+iD+iR

kPitch cpsmidinn p4

aEnv adsr (iA/iADSRTotal)*p3, (iD/iADSRTotal)*p3, iS, (iD/iADSRTotal)*p3  

kRmsr,kRmso,kErr,kCps lpread iTime, gSname
kRmso *= 0.00001	

aSig  buzz kRmso, kPitch, int(sr/2/kCps), 1 
aOut  lpreson aSig

aOut clip aOut, 0, 1
aOut = aOut*aEnv*p5
aEnv clfilt a(p6), 15, 0, 1
aOut *= aEnv*0.75

outs aOut, aOut

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f1 0 4096 10 1
</CsScore>
</CsoundSynthesizer>
