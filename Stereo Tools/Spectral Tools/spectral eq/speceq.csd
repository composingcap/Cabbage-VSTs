<Cabbage>
form caption("SpectralEQ") size(1008, 210), colour(47, 79, 79), pluginid("speq") identchannel("formID")
combobox text("fft size") channel("fftSize")  items("512","1024", "2048", "4096", "8192") value(4) bounds(8,8,80,20)
label text("fft size") bounds(100, 12, 80, 10) align("left")
button text("Randomize") channel("rand") bounds(175,5,80,20) value(1)
button text("zero table") channel("zero") bounds (175,28,80,20)
combobox items("Gaussian","Poisson","Uniform","Linear","Exponential") bounds(255,5,80,20) channel("rType")
gentable tablenumber(101) bounds(8,50,992, 140) amprange(0,2, 101, 0.01) identchannel("table") tablegridcolour(0,0,0,0) tablecolour:N(72, 209, 204) tablebackgroundcolour(27, 59, 59)
label text("Click on the table to draw!") bounds(8,35,140,12) align("left")
button text("store to user defined table") bounds(350,5,150,20) channel("uTabS")
nslider text("User Table") bounds(500,10,50,30) range(1,10,1,1,1) channel("uTab")
groupbox text("tween") bounds(700,0,300,45){
nslider channel("beg") range(1,10,1,1,1) bounds(8,22,20,20) value(2)
nslider channel ("end")range(1,10,1,1,1) bounds(272,22,20,20) value(3)
hslider channel ("tween") bounds(38,22,242,20) range(0,1,0,1,0.001)
}
filebutton text("save table list") bounds(550,5,75,20) channel("save") file("specEqDef.speceq") value(0) mode("save")
filebutton text("load table list") bounds(550,25,75,20) channel("load") file("specEqDef.speceq") value(0) mode("file") populate("*.speceq")
label bounds(627,28,70,15) identchannel("filename_id") align("left") text(" ")
label bounds(0,195,1000,12) align("right") text("© Christopher Poovey 2018")


</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d
</CsOptions>
<CsInstruments>
; Initialize the global variables.
ksmps = 128
nchnls = 2
0dbfs = 1


instr update
    ;Gui Data
    kMouseX chnget "MOUSE_X"
    kMouseY chnget "MOUSE_Y"
    kMouseLeft chnget "MOUSE_DOWN_LEFT"
    iGuiX = 992
    iGuiY= 140
    kRand init 0
    kZero chnget "zero"


    kFftSize chnget "fftSize"
    kRand chnget "rand"
    kZero chnget "zero"
    kFlat chnget "flat"

    iBands init 100 ;Number of bands must be declaired before run
    ;Variable for tweening
    kUTab chnget "uTab"
    kUTabS chnget "uTabS"
    kUTabR chnget "uTabR"
    kTween chnget "tween"
    SloadFile chnget "load"
    SsaveFile chnget "save"


    iTables = 10 ;Number of user defined tables
    iCount = 0


    if changed(kFftSize)==1 then
        turnoff2 1, 0, 0
        reinit makeArray
    endif

    iRandomTypes[] fillarray 6, 11, 1, 2, 4 ;Types of randomness

    giTab ftgen 101, 0, -iBands, 2, 0 ;generate band table

    ;Create the user defined tables
    until iCount >= iTables do
        giUTab ftgen 200+iCount+1, 0, -iBands, 2, 0
        iCount += 1
    od

   

    makeArray:
        giFftSize = pow(2,i(kFftSize)+8)
        kFftFilter[] init giFftSize
        kBeg[] init giFftSize
        kEnd[] init giFftSize
        kTweened[] init giFftSize
        iclock rtclock
        giTab ftgen 102, 0, -(giFftSize+1), 2, 1
        event_i "i", 1, 0, pow(9999,9999)
    rireturn
    
    
    if changed(SloadFile)==1 then
        event "i", "loadUTabs", 0, 0.5
        endif 
    if changed(SsaveFile)==1 then
        event "i", "saveUTabs", 0, 0.5
        endif 


    if changed(kUTabS) == 1 then ;Store selected table
        reinit saveTab
        saveTab:
            iTabU = chnget("uTab")
            tableicopy iTabU+200, 101
            
        gkTabR init 0    
        rireturn
        endif
    if changed(kUTab) == 1 || gkTabR==1 then ;Read selected table
    
        gkTabR = 0
        reinit readTab
        
        readTab:
            iTabU = chnget("uTab")
            tableicopy  101 ,iTabU+200         
            chnset	"tablenumber(101)", "table"
            
        rireturn
        endif

    if changed(kTween) == 1 then ;Tween between 2 tables
        reinit morph
        morph:
            iTabB = 200+chnget("beg")
            copyf2array kBeg, iTabB
            iTabE = 200+chnget("end")
            copyf2array kEnd, iTabE
        

        kBeg *= 1-kTween
        kEnd *= kTween
        kTweened = kBeg+kEnd
        kCount = 0

        copya2ftab kTweened, 101
        chnset	"tablenumber(101)", "table"
        rireturn

    endif

    if changed(kRand) == 1 then
        reinit makeRandTab
        makeRandTab:
        iRType chnget "rType"
        giTab ftgen 101, 0, -iBands, 21, iRandomTypes[iRType], 1
        chnset	"tablenumber(101)", "table"

        rireturn
   endif
   
   if changed(kZero) == 1 then
    reinit zero
    zero:
        giTab ftgen 101, 0, -iBands, 2, 0
        chnset	"tablenumber(101)", "table"
    rireturn
    endif


    ;Code for translating mouse position to bands
    if (kMouseLeft == 1) then
        if ((kMouseX >= 8) && (kMouseX <=1000)) then
            if ((kMouseY >= 50) && (kMouseY <=190)) then
            kPos = floor((kMouseX-8)/iGuiX*iBands)
            tablew 2-((kMouseY-50)/iGuiY)*2, kPos, 101
            chnset	"tablenumber(101)", "table"
            endif
        endif
    endif


    


    updateTable:

    kthisBin = 0

    until kthisBin >= giFftSize do
        kthisBand = floor(pow(kthisBin/(giFftSize),0.9)*iBands*2.1)
        kBinVal table kthisBand, 101
        kFftFilter[kthisBin] = abs(kBinVal)*2
        kthisBin += 1
    od
    copya2ftab kFftFilter, 102
  



endin

instr saveUTabs
    Sname chnget "save"
    Sname strcat Sname, ".speceq"
    chnset Sname, "load"

    ftsave Sname, 1, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210
    
    
endin   

instr loadUTabs
    Sname chnget "load"
    prints Sname
    ftload Sname, 1, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210  
    gkTabR = 1
      


endin  

instr 1
    ;fft filter
    aIn1 inch 1
    aIn2 inch 2

    fIn1 pvsanal aIn1, giFftSize, giFftSize/6, giFftSize, 0
    fIn2 pvsanal aIn2, giFftSize, giFftSize/6, giFftSize, 0
    kDepth init 1
    fEq1 pvsmaska fIn1,102,kDepth
    fEq2 pvsmaska fIn2,102,kDepth
    aOut1 pvsynth fEq1
    aOut2 pvsynth fEq2

    outs aOut1, aOut2
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i "update" 0 z
i "loadUTabs" 0.1 0.1





</CsScore>
</CsoundSynthesizer>