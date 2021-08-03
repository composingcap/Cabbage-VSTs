<Cabbage>
form caption("2D WavetablePad") size(400, 300), colour(58, 110, 182), pluginid("def1")
keyboard bounds(8, 158, 381, 95)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

;instrument will be triggered by keyboard widget
instr 1
    iPitch cpsmidinn p4
    iVel = pow(p4/127,2)
    iFt = 
    kEnv madsr .1, .2, .6, .4
    awt1 loscilx kEnv, iPitch, 


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z

</CsScore>
</CsoundSynthesizer>
