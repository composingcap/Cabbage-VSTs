<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginid("def1")
gentable tablenumber(10) amprange(0,1,10,0.01) active(0) bounds(8,8,100,100) fill(0) outlinethickness(4)
keyboard bounds(8, 200, 381, 95) 
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

;instrument will be triggered by keyboard widget
instr 1


kEnv madsr .1, .2, .6, .4
aOut vco2 p5, p4
outs aOut*kEnv, aOut*kEnv
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f1 0 200 7 0 200 1
f2 0 100 7 1 100 0.5
f3 0 100 19 1 0.2 0 0.5
f10 0 1025 18 1 0 1 2 200 1 3 300 1
</CsScore>
</CsoundSynthesizer>
