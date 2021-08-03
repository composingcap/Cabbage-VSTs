<Cabbage>
form caption("grainBurst") size(400, 300), colour(58, 110, 182), pluginid("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0.5, 1, .01), text("Gain"), trackercolour("lime"), outlinecolour(0, 0, 0, 50), textcolour("black")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1


instr 1
// i 1 start dur tab len pos amp
iLen = p3
iTab = p4
iPos = p5
iAmp = p6

iTranspose = pow(2,p7/12)

iSampStart = (tableng(iTab) * iPos) % 1

aGrain loscilx iAmp, iTranspose, iTab, 2, iSampStart  


kEnv adsr 0.2*iLen, 0.6*iLen, 1, 0.2*iLen

aOut = aGrain*kEnv*chnget("gain")


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z

</CsScore>
</CsoundSynthesizer>
