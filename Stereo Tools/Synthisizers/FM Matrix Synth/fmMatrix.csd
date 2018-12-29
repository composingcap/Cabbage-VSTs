<Cabbage>
form caption("FM Matrix Synth") size(780, 470), colour("darkgrey"), pluginid("fmcp")

image bounds(550,250,160,25) colour(0,0,0,0){
    combobox bounds(0, 0, 100, 25), channel("combobox"), populate("*.snaps")
    filebutton bounds(100, 0, 60, 25), channel("presets"), text("Save"), mode("snapshot")
}

keyboard bounds(8, 355, 765, 95)

label bounds (50,10,50,15)text("Ratio") align("Centre") fontcolour("black")
#define RATIO nslider bounds(50,10, 50,25) range(0,10,1,1,0.001)

label bounds (128,10,50,15)text("Offset") align("Centre") fontcolour("black")
#define HZ nslider bounds(125,10, 50,25) range(-100,100,0,1,.1)

label bounds (200,10,100,15)text("Waveform")  fontcolour("black")
#define WAVE combobox bounds(200,10,100,25) items("Sin", "Tri","Saw","Square") 

label bounds (315,10,100,15)text("A  D  S  R") fontcolour("black")
#define A rslider bounds(315,10,30,30) range(0.0001,3,0.1,0.5,0.01)
#define D rslider bounds(345,10,30,30) range(0.0001,3,0.1,0.5,0.01)
#define S rslider bounds(375,10,30,30) range(0,1,1,1,0.01)
#define R rslider bounds(405,10,30,30) range(0.0001,3,0.1,0.5,0.01)

label bounds (450,10,25,15)text("Inv") fontcolour("black")
#define INVERT checkbox bounds(445,15,15,15)

label bounds (490,10,25,15)text("Vel") fontcolour("black")
#define VEL rslider bounds (475,10,30,30) range(0,1,1,1,0.01)

#define OUTBOX nslider range(0,1,0,1,0.01)
#define MATNUM nslider range(0,500,0,0.01,0.25)
#define MATBUT button  colour:1("green")



    ;This is the osc module
    image bounds(10,25,530,50) colour("grey"){
        label text("A") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_A") 
        $HZ channel("Offset_A")        
        $WAVE channel("Wave_A")
        $A channel("A_A")
        $D channel("D_A")
        $S channel("S_A")
        $R channel("R_A")
        $INVERT channel("Inv_A")
        $VEL channel("Vel_A")
    }
    image bounds(10,80,530,50) colour("grey"){
        label text("B") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_B")
        $HZ channel("Offset_B")
        $WAVE channel("Wave_B")
        $A channel("A_B")
        $D channel("D_B")
        $S channel("S_B")
        $R channel("R_B")
        $INVERT channel("Inv_B")
        $VEL channel("Vel_B")
    }
    }
    
        }
    image bounds(10,135,530,50) colour("grey"){
        label text("C") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_C")
        $HZ bounds(125,10, 50,25) channel("Offset_C")
        $WAVE channel("Wave_C")
        $A channel("A_C")
        $D channel("D_C")
        $S channel("S_C")
        $R channel("R_C")
        $INVERT channel("Inv_C")
        $VEL channel("Vel_C")
    }
    }
    
        }
    image bounds(10,190,530,50) colour("grey"){
        label text("D") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_D")
        $HZ bounds(125,10, 50,25) channel("Offset_D")
        $WAVE channel("Wave_D")
        $A channel("A_D")
        $D channel("D_D")
        $S channel("S_D")
        $R channel("R_D")
        $INVERT channel("Inv_D")
        $VEL channel("Vel_D")
    }
        image bounds(10,245,530,50) colour("grey"){
        label text("E") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_E")
        $HZ bounds(125,10, 50,25) channel("Offset_E")
        $WAVE channel("Wave_E")
        $A channel("A_E")
        $D channel("D_E")
        $S channel("S_E")
        $R channel("R_E")
        $INVERT channel("Inv_E")
        $VEL channel("Vel_E")
    }
        }
        image bounds(10,300,530,50) colour("grey"){
        label text("F") fontcolour("black") bounds(2,10,25,25)
        $RATIO channel("Ratio_F")
        $HZ bounds(125,10, 50,25) channel("Offset_F")
        $WAVE channel("Wave_F")
        $A channel("A_F")
        $D channel("D_F")
        $S channel("S_F")
        $R channel("R_F")
        $INVERT channel("Inv_F")
        $VEL channel("Vel_F")
    }


            
    }
    
    ;Grid
    label text("Routing Matrix") bounds(550,5,225,20) fontcolour("black")
    image bounds(550, 25,225,210) colour("grey"){
        $MATBUT text("A") bounds(10,10,30,20) channel("Grid_A") value(1)
        $MATNUM bounds(45,10,30,20) channel("Grid_B2A")
        $MATNUM bounds(80,10,30,20) channel("Grid_C2A")
        $MATNUM bounds(115,10,30,20) channel("Grid_D2A")
        $MATNUM bounds(150,10,30,20) channel("Grid_E2A")
        $MATNUM bounds(185,10,30,20) channel("Grid_F2A")
        
        $MATNUM bounds(10,35,30,20) channel("Grid_A2B")        
        $MATBUT text("B") bounds(45,35,30,20) channel("Grid_B")
        $MATNUM bounds(80,35,30,20) channel("Grid_C2B")
        $MATNUM bounds(115,35,30,20) channel("Grid_D2B")
        $MATNUM bounds(150,35,30,20) channel("Grid_E2B")
        $MATNUM bounds(185,35,30,20) channel("Grid_F2B")
        
        $MATNUM bounds(10,60,30,20) channel("Grid_A2C")
        $MATNUM bounds(45,60,30,20) channel("Grid_B2C")
        $MATBUT text("C") bounds(80,60,30,20) channel("Grid_C")
        $MATNUM bounds(115,60,30,20) channel("Grid_D2C")
        $MATNUM bounds(150,60,30,20) channel("Grid_E2C")
        $MATNUM bounds(185,60,30,20) channel("Grid_F2C")

        $MATNUM bounds(10,85,30,20) channel("Grid_A2D")
        $MATNUM bounds(45,85,30,20) channel("Grid_B2D")
        $MATNUM bounds(80,85,30,20) channel("Grid_C2D")
        $MATBUT text("D") bounds(115,85,30,20) channel("Grid_D")
        $MATNUM bounds(150,85,30,20) channel("Grid_E2D")
        $MATNUM bounds(185,85,30,20) channel("Grid_F2D")
        
        $MATNUM bounds(10,110,30,20) channel("Grid_A2E")
        $MATNUM bounds(45,110,30,20) channel("Grid_B2E")
        $MATNUM bounds(80,110,30,20) channel("Grid_C2E")
        $MATNUM bounds(115,110,30,20) channel("Grid_D2E")
        $MATBUT text("E") bounds(150,110,30,20) channel("Grid_E")
        $MATNUM bounds(185,110,30,20) channel("Grid_F2E")
        
        $MATNUM bounds(10,135,30,20) channel("Grid_A2F")
        $MATNUM bounds(45,135,30,20) channel("Grid_B2F")
        $MATNUM bounds(80,135,30,20) channel("Grid_C2F")
        $MATNUM bounds(115,135,30,20) channel("Grid_D2F")
        $MATNUM bounds(150,135,30,20) channel("Grid_E2F")
        $MATBUT text("F") bounds(185,135,30,20) channel("Grid_F")
        
        image bounds(5,160,215,46){
        $OUTBOX bounds(5,2,30,20) channel("Grid_OutLA") value(1)
        $OUTBOX bounds(40,2,30,20) channel("Grid_OutLB")
        $OUTBOX bounds(75,2,30,20) channel("Grid_OutLC")
        $OUTBOX bounds(110,2,30,20) channel("Grid_OutLD")
        $OUTBOX bounds(145,2,30,20) channel("Grid_OutLE")
        $OUTBOX bounds(180,2,30,20) channel("Grid_OutLF")
        
        $OUTBOX bounds(5,25,30,20) channel("Grid_OutRA") value(1)
        $OUTBOX bounds(40,25,30,20) channel("Grid_OutRB")
        $OUTBOX bounds(75,25,30,20) channel("Grid_OutRC")
        $OUTBOX bounds(110,25,30,20) channel("Grid_OutRD")   
        $OUTBOX bounds(145,25,30,20) channel("Grid_OutRE")
        $OUTBOX bounds(180,25,30,20) channel("Grid_OutRF")     
        }
        
     } 

}
   

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

giOscNum = 6
giparamNum = 9
giNoiseNum = 1

gkOscA[] init giOscNum
gkDataA[] init giparamNum
giDataA[] init giparamNum

gkOscB[] init giOscNum
gkDataB[] init giparamNum
giDataB[] init giparamNum

gkOscC[] init giOscNum
gkDataC[] init giparamNum
giDataC[] init giparamNum

gkOscD[] init giOscNum
gkDataD[] init giparamNum
giDataD[] init giparamNum

gkOscE[] init giOscNum
gkDataE[] init giparamNum
giDataE[] init giparamNum


gkOscF[] init giOscNum
gkDataF[] init giparamNum
giDataF[] init giparamNum


gkLeftOut[] init giOscNum
gkRightOut[] init giOscNum

gSparams[] fillarray "Ratio", "Offset", "Wave", "A", "D", "S", "R", "Inv", "Vel"
gSMat[] fillarray "A", "B", "C", "D", "E", "F"

opcode fillData, k[], S[]S
        Sparams[], Sreplace  xin
        
        iLen lenarray Sparams
        kData[] init iLen
        
        kCount = 0
        
        until kCount >= iLen do
            Sname sprintfk "%s_%s", Sparams[kCount], Sreplace
            kData[kCount] chnget Sname
            kCount += 1
        od 
       
       xout kData
   endop

opcode fillDatai, i[], S[]S
        Sparams[], Sreplace  xin
        
        iLen lenarray Sparams
        iData[] init iLen
        
        iCount = 0
        
        until iCount >= iLen do
            Sname sprintf "%s_%s", Sparams[iCount], Sreplace
            iData[iCount] chnget Sname
            iCount += 1
        od 
       
       xout iData
   endop
              
               
opcode fillOsc, k[], S[]Si
        Sparams[], Sreplace, iSubIndex  xin
        
        iLen lenarray Sparams
        kData[] init iLen
        
        kCount = 0
        
        until kCount >= iLen do
            if kCount != iSubIndex then
                Sname sprintfk "Grid_%s2%s", Sparams[kCount], Sreplace
            else
                Sname sprintfk "Grid_%s", Sreplace

            endif
                
            kData[kCount] chnget Sname
            kCount += 1
  
                
        od 
       
       xout kData

endop

instr getData

    
    gkDataA fillData gSparams, "A"
    gkOscA fillOsc gSMat, "A", 0

    gkDataB fillData gSparams, "B"
    gkOscB fillOsc gSMat, "B", 1 
    
    gkDataC fillData gSparams, "C"
    gkOscC fillOsc gSMat, "C", 2 
    
    gkDataD fillData gSparams, "D"
    gkOscD fillOsc gSMat, "D", 3
    
    gkDataE fillData gSparams, "E"
    gkOscE fillOsc gSMat, "E", 4
    
    gkDataF fillData gSparams, "F"
    gkOscF fillOsc gSMat, "F", 5
    
    
    gkLeftOut[0] chnget "Grid_OutLA"
    gkLeftOut[1] chnget "Grid_OutLB"
    gkLeftOut[2] chnget "Grid_OutLC"
    gkLeftOut[3] chnget "Grid_OutLD"
    gkLeftOut[4] chnget "Grid_OutLE"
    gkLeftOut[5] chnget "Grid_OutLF"
    
    gkRightOut[0] chnget "Grid_OutRA"
    gkRightOut[1] chnget "Grid_OutRB"
    gkRightOut[2] chnget "Grid_OutRC"
    gkRightOut[3] chnget "Grid_OutRD"
    gkRightOut[4] chnget "Grid_OutRE"
    gkRightOut[5] chnget "Grid_OutRF"

endin


;instrument will be triggered by keyboard widget

opcode makeOsc, a, a[]k[]k[]i[]iii
;"Ratio", "Offset", "Wave", "A", "D", "S", "R", "Inv", "Vel"

    aOscBank[], kData[], kOsc[], iData[], iIndex, iPitch, iVel xin
    if kOsc[iIndex] != 0 then
    
    iLen lenarray aOscBank
    
    aMod = 0
    kCount = 0
    
    until kCount >= iLen do 
        if kCount != iIndex then
            aMod += aOscBank[kCount]*kOsc[kCount]
        endif 
        kCount += 1
    od
    
    aOut oscil 0.1*kOsc[iIndex], (iPitch*kData[0]+kData[1])*(1+aMod), iData[2]+1
    
    aEnv madsr iData[3], iData[4], iData[5], iData[6]
    if iData[7] == 1 then
        aOut *= -1
    endif
    endif
    iVel = iVel*iData[8]+(1-iData[8])
    xout aOut*aEnv*iVel           
    
endop




instr 1    
    
    
    aOscBank[] init giOscNum
    aNoiseBank[] init giNoiseNum
    
    
    
    ;Osc A
    
    giDataA fillDatai gSparams, "A"
    aOscBank[0] makeOsc aOscBank, gkDataA, gkOscA, giDataA, 0, p4, p5
    
    ;Osc B    
    giDataB fillDatai gSparams, "B"
    aOscBank[1] makeOsc aOscBank, gkDataB, gkOscB, giDataB, 1, p4, p5
    
    ;Osc C
    giDataC fillDatai gSparams, "C"
    aOscBank[2] makeOsc aOscBank, gkDataC, gkOscC, giDataC, 2, p4, p5
        
    ;Osc D
    giDataD fillDatai gSparams, "D"
    aOscBank[3] makeOsc aOscBank, gkDataD, gkOscD, giDataD, 3, p4, p5

    ;Osc E
    giDataE fillDatai gSparams, "E"
    aOscBank[4] makeOsc aOscBank, gkDataE, gkOscE, giDataE, 4, p4, p5
   
    ;Osc F
    giDataF fillDatai gSparams, "F"
    aOscBank[5] makeOsc aOscBank, gkDataF, gkOscF, giDataF, 5, p4, p5


    
    aOutL = aOscBank[0]*gkLeftOut[0]+aOscBank[1]*gkLeftOut[1]+aOscBank[2]*gkLeftOut[2]+aOscBank[3]*gkLeftOut[3]+aOscBank[4]*gkLeftOut[4]+aOscBank[5]*gkLeftOut[5]
    aOutR = aOscBank[0]*gkRightOut[0]+aOscBank[1]*gkRightOut[1]+aOscBank[2]*gkRightOut[2]+aOscBank[3]*gkRightOut[3]+aOscBank[4]*gkRightOut[4]+aOscBank[5]*gkRightOut[5]
   
    outs aOutL, aOutR
endin




</CsInstruments>
<CsScore>
f1 0 16384 10 1  
f2 0 16384 10 1                                           
f3 0 16384 10 0 0.5 0 0.25 0 0.167 0 0.125 0 
f4 0 16384 10 1 0.5 0.3 0.25 0.2 0.167 0.14 0.125 .111 
f5 0 16384 10 1 0   0.3 0    0.2 0     0.14 0     .111 
  
    


;causes Csound to run for about 7000 years...
i "getData" 0 z 
f0 z
</CsScore>
</CsoundSynthesizer>
