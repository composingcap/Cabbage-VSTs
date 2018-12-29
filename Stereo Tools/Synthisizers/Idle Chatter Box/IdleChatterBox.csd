<Cabbage>
form caption("Idle Chatter Box") size(358, 100), colour("grey"), pluginid("chtr")
keyboard bounds(100, 10, 250, 80)
rslider bounds(8, 10, 80, 80) text("Voices per Second") range(0.1, 50, 8, 0.5, 0.1)  channel("freq") trackercolour("black") textcolour("black")
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
kFreq chnget "freq"

kTime randh 1, kFreq, p4
kTime = abs(kTime)
kPitch cpsmidinn p4
kEnv madsr .1, .1, .6, .1

kRmsr,kRmso,kErr,kCps lpread kTime,"FemVoice.lpc"
kRmso *= 0.00001	

aSig  buzz kRmso, kPitch, int(sr/2/kCps), 1 
aOut  lpreson aSig

aOut clip aOut, 0, 1
outs aOut*kEnv*p5, aOut*kEnv*p5

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f1 0 4096 10 1
</CsScore>
</CsoundSynthesizer>
