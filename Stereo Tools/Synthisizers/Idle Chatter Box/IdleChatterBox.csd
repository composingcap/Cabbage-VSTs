<Cabbage>
form caption("Idle Chatter Box") size(400, 100), colour("grey"), pluginid("chtr")
keyboard bounds(142, 10, 250, 80)
rslider bounds(8, 10, 80, 40) text("Grain Period") range(0.03125, 1, 0.25, 1, 0.03125)  channel("period") trackercolour("black") textcolour("black")
rslider bounds(8, 50, 80, 40) text("Grain Length") range(0.03125, 1, 0.125, 1, 0.03125)  channel("len") trackercolour("black") textcolour("black")
rslider bounds(70, 10, 80, 40) text("Random") range(0, 1, 0, 1, 0.0675)  channel("periodR") trackercolour("black") textcolour("black")
rslider bounds(70, 50, 80, 40) text("Random") range(0, 1, 0, 1, 0.0675)  channel("lenR") trackercolour("black") textcolour("black")
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
    event "i", 2, 0, kLength*(kBPM/60), p4, p5
endif

endin

instr 2

kTime random 0,1
iTime = i(kTime)

kPitch cpsmidinn p4

aEnv adsr 0.1*p3, 0.25*p3, 0.5, 0.65*p3  

kRmsr,kRmso,kErr,kCps lpread iTime,"FemVoice.lpc"
kRmso *= 0.00001	

aSig  buzz kRmso, kPitch, int(sr/2/kCps), 1 
aOut  lpreson aSig

aOut clip aOut, 0, 1
aOut = aOut*aEnv*p5
outs aOut, aOut


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f1 0 4096 10 1
</CsScore>
</CsoundSynthesizer>
