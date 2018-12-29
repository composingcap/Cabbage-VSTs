<Cabbage>
form caption("Spectral Delay") size(1208, 510), colour(58, 110, 182), pluginid("spdl") colour(47, 79, 79)
filebutton text("load table list") bounds(1000,8,80,30) channel("loadFile") file("SpecDelDef.specdel") value(0) mode("file") populate("*.specdel")
filebutton text("save table list") bounds(1100,8,80,30) channel("saveFile") file("SpecDelDef.specdel") value(0) mode("save")
image bounds(8,50,1200,150)colour(0,0,0,0){
    label text("A") bounds(5,20,20,20)
    label text("M") bounds(5,50,20,20)
    label text("P") bounds(5,80,20,20)
    gentable tablenumber(101) bounds(50,0,942, 140) amprange(0,1, 101, 0.01) identchannel("ampTab") tablegridcolour(0,0,0,0) tablecolour:N(72, 209, 204) tablebackgroundcolour(27, 59, 59)
    combobox  channel("ampGenMethod") bounds(1000,120,50,20) items("rand","gaus","cos","slope", "zero")
    hslider channel("ampGenArg") identchannel("ampGenArg_ID")  range(0,1,0.5,1, 0.01), bounds(1050,120,60,20) visible(0)
    label identchannel("ampGenArgText"), text(" "), bounds (1110,125,50,10) align("left")
    button text("Gen") channel("ampGen") bounds(1150,120,30,20)
    nslider text("user table") channel ("ampUTab")range(1,20,1,1,1) bounds(1000,0,80,30)
    button text("recall") channel("ampTabRecall") bounds(1080,15,80,15)
    button text("store") channel("ampTabStore") bounds(1080,0,80,15)
    xypad bounds(1030,32,120, 85) rangex(0,1,0) rangey(0,1,0) channel("ampTweenX","ampTweenY")
    nslider bounds(995,32,30,20) range(1,20,1,1,1) channel("ampTween1")
    nslider bounds(995,92,30,20) range(1,20,2,1,1) channel("ampTween2")
    nslider bounds(1155,32,30,20) range(1,20,3,1,1) channel("ampTween3")
    nslider bounds(1155,92,30,20) range(1,20,4,1,1) channel("ampTween4")
}

image bounds(8,200,1200,150)colour(0,0,0,0){
    label text("D") bounds(5,20,20,20)
    label text("E") bounds(5,50,20,20)
    label text("L") bounds(5,80,20,20)    
    gentable tablenumber(102) bounds(50,0,942, 140) amprange(0,1, 102, 0.01) identchannel("delTab") tablegridcolour(0,0,0,0) tablecolour:N(72, 209, 204) tablebackgroundcolour(27, 59, 59)
    combobox  channel("delGenMethod") bounds(1000,120,50,20) items("rand","gaus","cos","slope", "zero")
    hslider channel("delGenArg") identchannel("delGenArg_ID")  range(0,1,0.5,1, 0.01), bounds(1050,120,60,20) visible(0)
    label identchannel("delGenArgText"), text(" "), bounds (1110,125,50,10) align("left")
    button text("Gen") channel("delGen") bounds(1150,120,30,20)
    nslider text("user table") channel ("delUTab")range(1,20,1,1,1) bounds(1000,0,80,30) value(5)
    button text("recall") channel("delTabRecall") bounds(1080,15,80,15)
    button text("store") channel("delTabStore") bounds(1080,0,80,15)
    xypad bounds(1030,32,120, 85) rangex(0,1,0) rangey(0,1,0) channel("delTweenX","delTweenY")
    nslider bounds(995,32,30,20) range(1,20,5,1,1) channel("delTween1")
    nslider bounds(995,92,30,20) range(1,20,6,1,1) channel("delTween2")
    nslider bounds(1155,32,30,20) range(1,20,7,1,1) channel("delTween3")
    nslider bounds(1155,92,30,20) range(1,20,8,1,1) channel("delTween4")
    
}

image bounds(8,350,1200,150) colour(0,0,0,0){
    label text("F") bounds(5,20,20,20)
    label text("") bounds(5,50,20,20)
    label text("B") bounds(5,80,20,20)   
    gentable tablenumber(103) bounds(50,0,942, 140) amprange(0,1, 103, 0.01) identchannel("fbTab") tablegridcolour(0,0,0,0) tablecolour:N(72, 209, 204) tablebackgroundcolour(27, 59, 59)
    combobox  channel("fbGenMethod") bounds(1000,120,50,20) items("rand","gaus","cos","slope", "zero")
    hslider channel("fbGenArg") identchannel("fbGenArg_ID")  range(0,1,0.5,1, 0.01), bounds(1050,120,60,20) visible(0)
    label identchannel("fbGenArgText"), text(" "), bounds (1110,125,50,10) align("left")
    button text("Gen") channel("fbGen") bounds(1150,120,30,20)
    nslider text("user table") channel ("fbUTab")range(1,20,1,1,1) bounds(1000,0,80,30) value(9)
    button text("recall") channel("fbTabRecall") bounds(1080,15,80,15)
    button text("store") channel("fbTabStore") bounds(1080,0,80,15)
    xypad bounds(1030,32,120, 85) rangex(0,1,0) rangey(0,1,0) channel("fbTweenX","fbTweenY")
    nslider bounds(995,32,30,20) range(1,20,9,1,1) channel("fbTween1")
    nslider bounds(995,92,30,20) range(1,20,10,1,1) channel("fbTween2")
    nslider bounds(1155,32,30,20) range(1,20,11,1,1) channel("fbTween3")
    nslider bounds(1155,92,30,20) range(1,20,12,1,1) channel("fbTween4")
}
}
label bounds(0,495,1200,12) align("right") text("© Christopher Poovey 2018")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 128 ; needs a high ksrate due the the large amount of data. This is set the the overlap size and CANNOT be greater
nchnls = 2
0dbfs = 1


instr update
    ;gui info 
    kMouseX chnget "MOUSE_X"
    kMouseY chnget "MOUSE_Y"
    kMouseLeft chnget "MOUSE_DOWN_LEFT"
    iGuiX = 942
    iGuiY= 140
    iGuiAmpY= 50
    iGuiDelY= 200
    iGuiFbY= 350

    iBands = 50
    giFftSize init 2048
    
    kFftFilter[] init giFftSize
    kFftDel[] init giFftSize
    kFftFb[] init giFftSize
    
    Sload chnget "loadFile"
    Ssave chnget "saveFile"
   
    
    
    giWindowSize = giFftSize
    giTabSize = giWindowSize+2
    giOverlap = 4
    
    iTween1[] init giTabSize
    iTween2[] init giTabSize
    iTween3[] init giTabSize
    iTween4[] init giTabSize
    iTweenR[] init giTabSize
    kUTable init 0
    kFtTarget init 0    
    iCount = 0
    iNUTables= 20
    
    until iCount >= iNUTables do
        giTab ftgen 501+iCount, 0, -iBands, 2, 0
        iCount += 1
        od 
    
    

    giTab ftgen 101, 0, -iBands, 2, 0
    tableicopy  101, 501  
    giTab ftgen 201, 0, giTabSize, 2, 0

    giTab ftgen 102, 0, -iBands, 2, 0 
    tableicopy  102, 505  
    giTab ftgen 202, 0, giTabSize, 2, 0
      
    giTab ftgen 103, 0, -iBands, 2, 0
    tableicopy  103, 509
    giTab ftgen 203, 0, giTabSize, 2, 0  

    if changed(Ssave)==1 then
        event "i", "saveTab", 0, -1
        endif

    if changed(Sload)==1 then
        event "i", "loadTab", 0, -1
        endif    
   
   event_i "i", "loadTab", 0, 0.1    

    
    event_i "i", "SpecDelay", 0, pow(9999,9999)
    
    kAmpTweenX chnget "ampTweenX"
    kAmpTweenY chnget "ampTweenY"
    
    if changed(kAmpTweenX,kAmpTweenY) == 1 then
        reinit AmpTabInit
        AmpTabInit:
            iTweenX = i(kAmpTweenX)
            iTweenY = i(kAmpTweenY)
            copyf2array iTween1, 500+chnget("ampTween1") 
            copyf2array iTween2, 500+chnget("ampTween2") 
            copyf2array iTween3, 500+chnget("ampTween3") 
            copyf2array iTween4, 500+chnget("ampTween4") 
            iTween1 *= ((1-iTweenX)*iTweenY)
            iTween3 *= (iTweenX*iTweenY)
            iTween2 *= ((1-iTweenX)*(1-iTweenY))
            iTween4 *= (iTweenX*(1-iTweenY))
            
            iTweenR = iTween1+iTween2+iTween3+iTween4
            
            copya2ftab iTweenR, 101            
            chnset	"tablenumber(101)", "ampTab"                                    
            rireturn    
    endif
        
    
    
    kDelTweenX chnget "delTweenX"
    kDelTweenY chnget "delTweenY"
    
    if changed(kDelTweenX,kDelTweenY) == 1 then
        reinit delTabInit
        delTabInit:
            iTweenX = i(kDelTweenX)
            iTweenY = i(kDelTweenY)
            copyf2array iTween1, 500+chnget("delTween1") 
            copyf2array iTween2, 500+chnget("delTween2") 
            copyf2array iTween3, 500+chnget("delTween3") 
            copyf2array iTween4, 500+chnget("delTween4") 
            iTween1 *= ((1-iTweenX)*iTweenY)
            iTween3 *= (iTweenX*iTweenY)
            iTween2 *= ((1-iTweenX)*(1-iTweenY))
            iTween4 *= (iTweenX*(1-iTweenY))
            
            iTweenR = iTween1+iTween2+iTween3+iTween4
            
            copya2ftab iTweenR, 102            
            chnset	"tablenumber(102)", "delTab"                                    
            rireturn    
    endif
    
    kFbTweenX chnget "fbTweenX"
    kFbTweenY chnget "fbTweenY"    
    
    if changed(kFbTweenX,kFbTweenY) == 1 then
        reinit FbTabInit
        FbTabInit:
            iTweenX = i(kFbTweenX)
            iTweenY = i(kFbTweenY)
            copyf2array iTween1, 500+chnget("fbTween1") 
            copyf2array iTween2, 500+chnget("fbTween2") 
            copyf2array iTween3, 500+chnget("fbTween3") 
            copyf2array iTween4, 500+chnget("fbTween4") 
            iTween1 *= ((1-iTweenX)*iTweenY)
            iTween3 *= (iTweenX*iTweenY)
            iTween2 *= ((1-iTweenX)*(1-iTweenY))
            iTween4 *= (iTweenX*(1-iTweenY))
            
            iTweenR = iTween1+iTween2+iTween3+iTween4
            
            copya2ftab iTweenR, 103            
            chnset	"tablenumber(103)", "fbTab"                                    
            rireturn    
    endif

        
   
    kAmpGenMethod chnget "ampGenMethod"
    kAmpGen chnget "ampGen"
    
    if changed(kAmpGenMethod) == 1 then
        if kAmpGenMethod == 3 then ; cos
            chnset "visible(1)", "ampGenArg_ID"
            
            chnset "text(\"cycles\")", "ampGenArgText"

            
        elseif kAmpGenMethod == 4 then
            chnset "visible(1)", "ampGenArg_ID"
            chnset "text(\"slope\")", "ampGenArgText"  
                  
        else
            chnset "visible(0)", "ampGenArg_ID"
            chnset "text(\" \")", "ampGenArgText"
            
        endif
    endif
    
    if changed(kAmpGen)==1 then
        kFtTarget = 101
        kgenarg chnget "ampGenArg"
        kGenMethod= kAmpGenMethod
        reinit generateTable
        endif
        
    kDelGenMethod chnget "delGenMethod"
    kDelGen chnget "delGen"
    
    if changed(kDelGenMethod) == 1 then
        if kDelGenMethod == 3 then ; cos
            chnset "visible(1)", "delGenArg_ID"
            
            chnset "text(\"cycles\")", "delGenArgText"

            
        elseif kDelGenMethod == 4 then
            chnset "visible(1)", "delGenArg_ID"
            chnset "text(\"slope\")", "delGenArgText"  
                  
        else
            chnset "visible(0)", "delGenArg_ID"
            chnset "text(\" \")", "delGenArgText"
            
        endif
    endif

    if changed(kDelGen)==1 then
        kFtTarget = 102
        kgenarg chnget "delGenArg"
        kGenMethod= kDelGenMethod
        reinit generateTable
        endif
        
        
    kFbGenMethod chnget "fbGenMethod"
    kFbGen chnget "fbGen"
    
    if changed(kFbGenMethod) == 1 then
        if kFbGenMethod == 3 then ; cos
            chnset "visible(1)", "fbGenArg_ID"
            
            chnset "text(\"cycles\")", "fbGenArgText"

            
        elseif kFbGenMethod == 4 then
            chnset "visible(1)", "fbGenArg_ID"
            chnset "text(\"slope\")", "fbGenArgText"  
                  
        else
            chnset "visible(0)", "fbGenArg_ID"
            chnset "text(\" \")", "fbGenArgText"
            
        endif
    endif

    if changed(kFbGen)==1 then
        kFtTarget = 103
        kgenarg chnget "fbGenArg"
        kGenMethod= kFbGenMethod
        reinit generateTable
        endif           
         
   generateTable:
        igenarg= i(kgenarg)
        iFtTarget = i(kFtTarget)
        iGenMethod = i(kGenMethod)
        if iGenMethod == 1 then ;Uniform Random
            itab ftgen iFtTarget, 0, -iBands, 21, 1 

        elseif iGenMethod == 2 then ;Gaus
           itab ftgen iFtTarget, 0, -iBands, 21, 6            

        elseif iGenMethod == 3 then ;cos
                  icount = 0
                  irandphase=random(0,6.28)
                  irandsharp=random(0.1,5)
            until icount >= iBands do 
            
                tableiw pow((1+cos((icount/iBands)*6.28*(igenarg*10+0.25)+irandphase))*0.5,irandsharp), icount,iFtTarget
                icount += 1            
            od
        elseif iGenMethod == 4 then ;sone
            itab ftgen iFtTarget, 0, -iBands, "sone", 1-igenarg,igenarg 
        
        
        elseif iGenMethod == 5 then ;zero
            itab ftgen iFtTarget, 0, -iBands, 2, 0            
       endif
        chnset	"tablenumber(101)", "ampTab"
        chnset	"tablenumber(102)", "delTab"
        chnset	"tablenumber(103)", "fbTab" 
        rireturn
    
    ;Store tables 
    kAmpTabStore chnget "ampTabStore"
    if changed(kAmpTabStore)==1 then
        
        kFtTarget = 101
        kUTable chnget "ampUTab"
        reinit storeTable
        endif

    kDelTabStore chnget "delTabStore"
    if changed(kDelTabStore)==1 then
        
        kFtTarget = 102

        kUTable chnget "delUTab"
        reinit storeTable
        endif

    kFbTabStore chnget "fbTabStore"
    if changed(kFbTabStore)==1 then
        
        kFtTarget = 103
        kUTable chnget "fbUTab"
        reinit storeTable
        endif
        
   if 0==1 then     
    storeTable:
    iFtTarget = i(kFtTarget)
    iUTable = i(kUTable)+500
    tableicopy iUTable, iFtTarget
    rireturn    
   
   endif
 
   ;Recall Tables  
    kAmpTabRecall chnget "ampTabRecall"
    if changed(kAmpTabRecall)==1 then
        
        kFtTarget = 101
        kUTable chnget "ampUTab"
        reinit recallTable
        endif

    kDelTabRecall chnget "delTabRecall"
    if changed(kDelTabRecall)==1 then
        
        kFtTarget = 102

        kUTable chnget "delUTab"
        reinit recallTable
        endif

    kFbTabRecall chnget "fbTabRecall"
    if changed(kFbTabRecall)==1 then
        
        kFtTarget = 103
        kUTable chnget "fbUTab"
        reinit recallTable
        endif
        
   if 0==1 then     
    recallTable:
    iFtTarget = i(kFtTarget)
    iUTable = i(kUTable)+500
    tableicopy iFtTarget,iUTable
    chnset	"tablenumber(101)", "ampTab"
    chnset	"tablenumber(102)", "delTab"
    chnset	"tablenumber(103)", "fbTab"
    rireturn    
   
   endif
   
    
    updateTables:
    
        if (kMouseLeft == 1) then
            if ((kMouseX >= 58) && (kMouseX <=1000)) then
               
                if ((kMouseY >= iGuiAmpY) && (kMouseY <=iGuiAmpY+140)) then
                kPos = floor((kMouseX-58)/iGuiX*iBands)
                tablew 1-((kMouseY-iGuiAmpY)/iGuiY), kPos, 101
                chnset	"tablenumber(101)", "ampTab"
                endif
            endif
        endif
        
        
        
        if (kMouseLeft == 1) then
            if ((kMouseX >= 58) && (kMouseX <=1000)) then
                
                if ((kMouseY >= iGuiDelY) && (kMouseY <=iGuiDelY+140)) then
                kPos = floor((kMouseX-58)/iGuiX*iBands)
                tablew 1-((kMouseY-iGuiDelY)/iGuiY), kPos, 102
                chnset	"tablenumber(102)", "delTab"
                endif
            endif
        endif
        
        
        if (kMouseLeft == 1) then
            if ((kMouseX >= 58) && (kMouseX <=1000)) then
                
                if ((kMouseY >= iGuiFbY) && (kMouseY <=iGuiFbY+140)) then
                kPos = floor((kMouseX-58)/iGuiX*iBands)
                tablew 1-((kMouseY-iGuiFbY)/iGuiY), kPos, 103
                chnset	"tablenumber(103)", "fbTab"
                endif
            endif
        endif
        
        

        kthisBin = 0

        until kthisBin >= giTabSize do
            kthisBand = floor(pow(kthisBin/(giFftSize),0.9)*iBands*2.1)
            kBinVal table kthisBand, 101
            kFftFilter[kthisBin] = abs(kBinVal)
            kBinVal table kthisBand, 102
            kFftDel[kthisBin] = abs(kBinVal)
            kBinVal table kthisBand, 102
            kFftFb[kthisBin] = abs(kBinVal)
            kthisBin += 2 ; only effect amplitude 
        od
        copya2ftab kFftFilter, 201
        copya2ftab kFftFilter, 202
        copya2ftab kFftFilter, 203


endin

instr SpecDelay
    ;Convert time to freq domain
    kIn1[] init giTabSize
    kOut1[] init giTabSize
    
    kIn2[] init giTabSize
    kOut2[] init giTabSize
    
    kAmp[] init giTabSize

    
    kFb[] init giTabSize
    kFbFrame1[] init giTabSize
    kFbFrame2[] init giTabSize
    
    giIn1 ftgen 204, 0, giTabSize, 2, 0   
    giOut1 ftgen 206, 0, giTabSize, 2, 0     
    giIn2 ftgen 205, 0, giTabSize, 2, 0   
    giOut2 ftgen 207, 0, giTabSize, 2, 0
    
    iWintype = 1
    
    aIn1 inch 1
    fIn1 pvsanal aIn1, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype
    
    aIn2 inch 2
    fIn2 pvsanal aIn2, giWindowSize, giWindowSize/giOverlap, giWindowSize, iWintype
    
    ;Convert pvs to an array    
    kFrame1 pvs2tab kIn1, fIn1  
    kFrame2 pvs2tab kIn2, fIn2
    kFrame= kFrame1+kFrame2
    
    ;Spectral Delay Magic 
  
    if changed(kFrame)==1 then
        
        copyf2array kAmp, 201
        ;202 is used for delays
        copyf2array kFb, 203
        
        kIn1 *= kAmp
        kIn1 += kFbFrame1
        copya2ftab kIn1, 204
        vecdelay 206, 204, 202, giWindowSize, 1
        copyf2array kOut1, 206
        kFbFrame1 = kOut1*(kFb*0.9) 
        
        kIn2 *= kAmp
        kIn2 += kFbFrame2
        copya2ftab kIn2, 205    
        vecdelay 207, 205, 202, giWindowSize, 1
        copyf2array kOut2, 207
        kFbFrame2 = kOut2*(kFb*0.9) 
    endif
        
      
    

    
    
    
    ;Resynthisis 
    fOut1 tab2pvs kOut1, giWindowSize/(giOverlap), giWindowSize, iWintype
    fOut2 tab2pvs kOut2, giWindowSize/(giOverlap), giWindowSize, iWintype
    
    aOut1 pvsynth fOut1
    aOut2 pvsynth fOut2

    outs aOut1, aOut2

    

endin

instr saveTab
    Ssave chnget "saveFile"
    Ssave strcat Ssave, ".specdel"
    ftsave Ssave, 1, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520 
    chnset Ssave, "loadFile"
    turnoff    
endin

instr loadTab
    Sload chnget "loadFile" 
    prints Sload
    ftload Sload, 1, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520 
    tableicopy 101, 500+chnget("ampUTab")
    tableicopy 102, 500+chnget("delUTab")
    tableicopy 103, 500+chnget("fbUTab")
    turnoff    
endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i "update" 0 z

</CsScore>
</CsoundSynthesizer>
