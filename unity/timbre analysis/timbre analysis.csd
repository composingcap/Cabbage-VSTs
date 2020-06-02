<Cabbage>
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginid("def1")
nslider channel("centroid") range(0,100000,0,1) text("centroid") bounds(20,10,70,50)
nslider channel("pitch") range(0,100000,0,1) text("pitch") bounds(20,70,70,50)
nslider channel("amp") range(0,100000,0,1) text("amp") bounds(120,10,70,50)

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

ifftsize = 1024
ioverlap = 4
iwindowsize = ifftsize
iwindow = 1
 
kthresh = 0.01
kGain chnget "gain"
a1, a2 inch 1, 2

aenv follow a1+a2, 0.05 

kenv = k(aenv)


fftin pvsanal a1+a2, ifftsize, iwindowsize/ioverlap, iwindowsize, iwindow
ktrig metro iwindowsize/ioverlap
fftin pvsmooth fftin, .1, .1

if ktrig == 1 then
        kcentroid pvscent fftin
        kpitch, kamp pvspitch fftin, 0.01
endif



chnset kcentroid, "centroid" 
chnset kpitch, "pitch" 
chnset kamp, "amp" 


endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
