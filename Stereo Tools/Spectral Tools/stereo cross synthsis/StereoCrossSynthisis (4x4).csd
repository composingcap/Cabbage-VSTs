<Cabbage>
form caption("Stereo Cross Synthisis") size(150, 120), colour(47, 79, 79), pluginid("strx")

    rslider text("amp mix") channel("cross.amp") bounds(20,8,50,50) range(0,1,0,1,0.001)
    rslider text("freq mix") channel("cross.freq") bounds(80,8,50,50) range(0,1,1,1,0.001)
    combobox text("fft size") channel("fftSize")  items("512","1024", "2048", "4096", "8192") value(4) bounds(8,70,80,20)
    label text("fft size") bounds(77,75,80,15)  
    label bounds(8,104,590,10) align("left") text("© Christopher Poovey 2018")



</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 128
nchnls = 4
0dbfs = 1


instr 1
    kWindowSize chnget "fftSize"
    if changed(kWindowSize)==1 then
        reinit windowSize
        windowSize:    
            giWindowSize = i(kWindowSize)
            giTabSize  = giWindowSize+2
            giOverlap = 8
            iWintype = 0
        rireturn
        endif 
    giWindowSize init 4096
            giTabSize  = giWindowSize+2
            giOverlap = 8
            iWintype = 0
    
    kcrossAmp chnget "cross.amp"
    kcrossFreq chnget "cross.freq"
    ;Left Channels
    aIn1 inch 1
    fIn1 pvsanal aIn1, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype, 0
    aIn3 inch 3
    fIn3 pvsanal aIn3, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype, 0    
    fMorph1 pvsmorph fIn1, fIn3, kcrossAmp, kcrossFreq   
    fMorph3 pvsmorph fIn3, fIn1, kcrossAmp, kcrossFreq   

    ;Right Channels
    aIn2 inch 2
    fIn2 pvsanal aIn2, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype, 0
    aIn4 inch 4
    fIn4 pvsanal aIn3, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype, 0    
    fMorph2 pvsmorph fIn2, fIn4, kcrossAmp, kcrossFreq      
    fMorph4 pvsmorph fIn4, fIn2, kcrossAmp, kcrossFreq   

    fSmooth1 pvsmooth fMorph1, 0.1, 0.1 
    fSmooth2 pvsmooth fMorph2, 0.1, 0.1 
    fSmooth3 pvsmooth fMorph3, 0.1, 0.1 
    fSmooth4 pvsmooth fMorph4, 0.1, 0.1 
    
    aOut1 pvsynth fSmooth1
    aOut2 pvsynth fSmooth2
    aOut3 pvsynth fSmooth3
    aOut4 pvsynth fSmooth4
    
    outq aOut1, aOut2, aOut3, aOut4
    

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
