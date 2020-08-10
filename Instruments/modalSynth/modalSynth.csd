<Cabbage>

#define impulseSlider rslider bounds(10,35,20,20) range(0.0001,1,0.0001,1,0.0001) colour(0,0,0,0) trackercolour("white") trackerthickness(2) trackeroutsideradius(1) trackerinsideradius(0)

#define defaultSlider rslider trackeroutsideradius(1) trackerinsideradius(0) trackercolour(180,0,0) outlinecolour(255,200,200) markerstart(0) markerend(1)

form caption("Modal Synth") size(800, 700), colour("whitesmoke"), pluginid("cpmd"), import("./modalSynthPlants.plant"), bundle("./modalSynthPlants.plant", "./modalSynth.snaps")

label text("Modal Synth") bounds(20,10,500,36) align("left") fontcolour("black")
image colour(0,0,0,0) bounds(20, 50, 200,100) {
    combobox bounds(0, 0, 100, 25), channel("preset"), populate("*.snaps") directory("./")
    filebutton bounds(110, 0, 60, 25), channel("but1"), text("Save"), mode("snapshot")
}


image bounds(0,100,800,800) colour(0,0,0,0)
{

image bounds(20,0,740,60) colour(0,0,0,0){
    image bounds(0,0,150,60) colour(0,0,0,0){
    label bounds(0,0,100,18) text("Input") fontcolour("black") align("left")
    $defaultSlider channel("inputGain") range(0.1,10,1,0.5,0.01) bounds(0,20,40,40) 
    combobox bounds(50,30,70,20)  items("impulse", "bow", "live input") channel("inputMode") align("centre")

    }
    image bounds(170 ,0,150,60) colour(0,0,0,0){
    image bounds(0 ,0,150,60) colour(200,0,0,255) identchannel("impulseInput") visible(1) active(1){
        gentable tablenumber(200) amprange(0, 1, 200, 0) active(0) bounds(10,10,125, 20) tablecolour("black") tablebackgroundcolour(0,0,0,0) tablegridcolour(0,0,0,0) identchannel("impulseTab")
        $impulseSlider value(1) channel("impulseSlider1")
        $impulseSlider bounds(35,35,20,20) channel("impulseSlider2")
        $impulseSlider bounds(60,35,20,20) channel("impulseSlider3")
        $impulseSlider bounds(85,35,20,20) channel("impulseSlider4")
        $impulseSlider bounds(110,35,20,20) channel("impulseSlider5")
    }
    
    image bounds(0,0,150,60) colour(0,200,0,255) identchannel("bowedInput") visible(0) active(1){
        label bounds(0,0,150,14) text("Bow Type") fontcolour("black")

        combobox bounds(25,15,100,14) channel("bowType") items("random saw", "random impulses", "noise")
        //hrange channel("bowNoiseOffsetLow", "bowNoiseOffsetHigh") identchannel("sawBowOptions") range(-36,24, -24:-12, 1, 0.5) bounds(15,30,140,20) visible(0)
        image identchannel("sawBowOptions") bounds(45,35,50,20) visible(0) colour(0,0,0,0){
            $impulseSlider range(-36,24, -24, 1, 0.5) channel("bowNoiseOffsetLow") bounds(0, 0, 20,20)
            $impulseSlider range(-36,24, -12, 1, 0.5) channel("bowNoiseOffsetHigh") bounds(30, 0, 20,20)
        }
        //hrange channel("bowNoiseDenseLow", "bowNoiseDenseHigh") identchannel("dustBowOptions") range(10,500, 2:5, 0.5, 0.001) bounds(15,30,140,30) visible(0)
            image identchannel("dustBowOptions") bounds(45,35,50,20) visible(0) colour(0,0,0,0){
            $impulseSlider range(10,500, 10, 0.5, 0.001) channel("bowNoiseDenseLow") bounds(0, 0, 20,20)
            $impulseSlider range(10,500, 50, 0.5, 0.001) channel("bowNoiseDenseHigh") bounds(30, 0, 20,20)
        }
        
        $impulseSlider channel("bowNoiseBeta") identchannel("bowNoise") range(-0.9, 0.9, 0, 1, 0.01) bounds(0,32,150,30) visible(0) 
        }
        
        image bounds(0,0,150,60) colour(0,200,0,255) identchannel("liveInput") visible(0) active(1){
                combobox bounds(25,15,100,14) channel("inputCh") items("mono","stereo","24 channel") value(2)

        }
        }
        
        
        
        image identchannel("inputFilter") bounds(350,0,200,60) visible(1) colour(0,0,0,0){
            button channel("inputFilterMode")  text("") bounds(5,0,90,14) colour:0(180,20,20) colour:1(200,100,100) identchannel("inputFilterModeIdent") value(1) 
            button channel("inputFilterEnabled") value(0)  text("lp / hp state") bounds(5,40,90,14) colour:0("grey") colour:1(200,80,80)  
            hslider channel ("InputFilterOffset") range(-36,100,12,1,0.25) bounds(5,12,90,30) 
            
            button channel("inputApEnabled") value(0)  text("allpass state") bounds(105,40,90,14) colour:0("grey") colour:1(200,80,80)  
            $defaultSlider channel ("inputAllpassOrder") range(2,16,8,1,2) bounds(110,15,20,20) 
            $defaultSlider channel ("inputAllpassOffset") range(-36,48,3,1,0.5) bounds(140,0,20,20) 
            $defaultSlider channel ("inputApFeedback") range(0,0.99,0.5,0.5,0.001) bounds(170,15,20,20) 
            
          
 
    
       }
       image bounds(600,0,150,60) colour(0,,0,0){
       label text("output") bounds(0,0,100,18) align("left") fontcolour("black")
       $defaultSlider channel("gain") bounds(0,20,40,40) range(0,2,1,0.5,0.01) trackercolour(255,0,0,255) outlinecolour(0,0,0,0) colour(0,0,0,0) 
        combobox items("stereo", "discrete channels (24)") bounds(50,30,70,20) channel("outputMode")
}
}


modalSynthMatrix namespace("cp"), bounds(0,100,800,280) 


image bounds(24,400,250,80) colour(0,0,0,0){
    label text("ADSR") bounds (0,0,200,18) align("left") fontcolour("black")
    $defaultSlider channel("voiceAttack") bounds(8,24,30,30) range(5,5000,10,0.25,0.001) 
    $defaultSlider channel("voiceDecay") bounds(48,24,30,30) range(0,5000,10,0.25,0.001) 
    $defaultSlider channel("voiceSustain") bounds(88,24,30,30) range(0,1,0.8,1,0.001) 
    $defaultSlider channel("voiceRelease") bounds(128,24,30,30) range(5,5000,500,0.25,0.001) 
    //hrange bounds(8,50,132,20) range(50, 5000, 100:250, 0.25, 1) channel("qMin","qMax")
    image bounds(55,60,132,20) visible(1) colour(0,0,0,0){
         $defaultSlider range(50, 5000, 100, 0.25, 1) channel("qMin") bounds(0, 0, 20,20)
         $defaultSlider range(50, 5000, 250, 0.25, 1) channel("qMax") bounds(30, 0, 20,20)
        }
    label text("q range") bounds(125,63,160,14) align("left") fontcolour(0,0,0,255)

    

}



image bounds(580, 400, 200, 150)colour(0,0,0,0) {
    label text("Macro Buttons")  bounds(20,0,160,18)  fontcolour(0,0,0,255)
    button text("all on") bounds(20,24,75,20) channel("allOn") identchannel("allOn_ident") latched(0)
    button text("all off") bounds(105,24,75,20) channel("allOff") latched(0)
    //button text("randomize notes") bounds(20,50,160,20) channel("randNotes") latched(0)
    //button text("randomize q") bounds(20,75,160,20) channel("randQ")     latched(0)
    //button text("randomize gain") bounds(20,100,160,20) channel("randGain") latched(0)
    //button text("randomize pan") bounds(20,125,160,20) channel("randPan") latched(0)
    button text("randomize") bounds(20,50,160,20) channel("randAll") latched(0)
    //filebutton text("import") bounds(20,75,160,20) channel("import") latched(0) populate("*.txt", "$HOME/")mode("file")
}

image colour(0,0,0,0) bounds(320,400,200,200){
    label text("Random Deviations") bounds (0,0,200,18) align("left") fontcolour("black")
    $defaultSlider channel("randomPitchPerNote") range(0,12,0,0.5,0.01) bounds(0,24,30,30) 
    $defaultSlider channel("randomQPerNote") range(0,1,0,0.5,0.01) bounds(40,24,30,30) 
    $defaultSlider channel("randomGainPerNote") range(0,1,0,0.5,0.01) bounds(80,24,30,30)
    $defaultSlider channel("randomPanPerNote") range(0,1,0,0.5,0.01) bounds(120,24,30,30) 
    button text("key tracked")  bounds(20,60,100,14) channel("keyTrack") identchannel("keyTrackIdent") colour:1(100,100,255)

    }


image bounds(24,500,800,80) colour(0,0,0,0){
    image bounds(15,0, 40, 80) colour(0,0,0,0){
        $defaultSlider bounds(0,0,20,20) channel("vibratoRate") range(0.001,15,1, 0.25,0.01)
        $defaultSlider bounds(0,20,20,20) channel("vibratoDepth") range(1,12,3,1,0.01) 
        $defaultSlider bounds(0,40,20,20) channel("vibratoDeviation") range(0,1,0.1,1,0.01) 
        vslider bounds(15,0,20,80) channel("vibrato") range(0,1,0,1,0.01) colour(0,0,0)
        }

image bounds(70,0, 40, 80) colour(0,0,0,0){
$defaultSlider bounds(0,0,20,20) channel("tremRate") range(0.001,15,1, 0.25,0.01) 
$defaultSlider bounds(0,40,20,20) channel("tremDeviation") range(0,1,0.1,1,0.01)
vslider bounds(15,0,20,80) channel("trem") range(0,1,0,1,0.01) colour(0,0,0)


}

keyboard bounds (110,0,624,80) blacknotecolour(25,0,0) whitenotecolour(220,120,120) arrowbackgroundcolour(0,0,0,0) keysdowncolour(255,200,200,255) arrowcolour("black") mouseoverkeycolour(255,200,200,255)

}
}



</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>


; Initialize the global variables. 
ksmps = 32
nchnls = 24
0dbfs = 1
giInputCh init 2
gkVibrato[] init 4
gaTrem[] init 4
gaIns[] init 2;

giSfTab init 1
gkOutputMode init 1
giEnabled ftgen 0, 0, 24, 27, 0, 0
giPans ftgen 0, 0, 24, 27, 0, 0.5
giNotes ftgen 0, 0, 24, 27, 0, 0
giAmps ftgen 0, 0, 24, 27, 0, 0.5
giQs ftgen 0, 0, 24, 27, 0, 0.5
gkQMin init 0
gkQMax init 0
gkADSR[] fillarray 5, 5, 0.8, 500
 
gkRandomPitch init 0
gkRandomGain init 0
gkRandomQ init 0
gkRandomPan init 0
gkKeyTracked init 0


giBow1 ftgen 0, 0, 4096, 7, 1, 4096, 0; 

giImpulse init 200

opcode resonbank, aa, akiiiiikai
//Resonant filters in parallel

    aSig, kBaseNote, iNotesTab, iQsTab, iGainsTab,iPansTab, iEnabledTab, kOutputMode, aEnv, iCount xin
    
    iNumber= tableng(iNotesTab)-1
    aOutL = 0
    aOutR = 0
    kQ init 0
    RESONTOP:
    
    iEnabled tab_i iCount, iEnabledTab
    iGain tab_i iCount, iGainsTab
     
    
    aTemp = 0
    
    if (iEnabled*iGain == 0) then 
        iCount += 1
        if iCount >= iNumber goto RESONSKIP
        goto RESONTOP           
    endif
    iKeyTracked = i(gkKeyTracked)
    if iKeyTracked == 1 then
        seed p4+iCount*50
    elseif  iKeyTracked == 0 then
        seed 0
    endif 
      
    iNote tab_i iCount, iNotesTab
    iVib random 0, 1
    iRandomPitchDepth = i(gkRandomPitch);
    if (iCount != 0) then
    iRandomPitch unirand iRandomPitchDepth*2
    iRandomPitch -= iRandomPitchDepth 
    else
    iRandomPitch = 0
    endif 
    kThisVib = gkVibrato[0]*((iVib)%1)+gkVibrato[1]*((iVib+0.25)%1)+gkVibrato[2]*((iVib+0.5)%1)+gkVibrato[3]*((iVib+0.75)%1)
    kThisNote = (iNote+kBaseNote+iRandomPitch)+kThisVib   
    kThisFreq = mtof(kThisNote)
    
    GETQ:    
    kQ = tab_i(iCount, iQsTab)

    iQRandomAmount = i(gkRandomQ)
    iQRandom unirand iQRandomAmount
    
    kQ = kQ+iQRandom*2000
    
    kQ = kThisFreq/kQ
    
    //printk2 kQ
    iPan tab_i iCount, iPansTab
    iRandomPanAmount = i(gkRandomPan)
    iRandomPan trirand iRandomPanAmount
    iPan = mirror(iPan+iRandomPan, 0, 1)
        
    if qnan(kQ) == 1 then 
        kQ = kThisFreq/150;
    endif 
    
    if giInputCh == 1 then
        aResonIn = gaIns[0]+gaIns[1]
        
    elseif giInputCh == 2 then
        aResonIn = gaIns[0]*(1-iPan)+gaIns[1]*iPan
        
    elseif giInputCh == 3 then    
        aResonIn inch iCount+1
     
    else 
        aResonIn = aSig
    endif
    
    aTemp resonz aResonIn, kThisFreq, kQ
    iTrem random 0, 1
    aThisTrem = gaTrem[0]*((iTrem)%1)+gaTrem[1]*((iTrem+0.25)%1)+gaTrem[2]*((iTrem+0.5)%1)+gaTrem[3]*((iTrem+0.75)%1)
    
    iRandomGainAmount = i(gkRandomGain)
    iRandomGain unirand iRandomGainAmount
    iRandomGain = 1-iRandomGain

    aGain = (iGain*iRandomGain)*(1-aThisTrem)
    aGain limit aGain, 0 ,1
    aTemp *= aGain
    
    
    

    if (kOutputMode == 1) then
        aOutL = aTemp*(1-iPan)
        aOutR = aTemp*(iPan)
        //prints "pan %d: %f \n", iCount, iPan; 
        
    elseif (kOutputMode == 2) then
        outch iCount+1, aTemp*aEnv
    endif
    
    

    if (iCount >= iNumber) goto RESONSKIP
        aTempL, aTempR resonbank aSig,kBaseNote, iNotesTab, iQsTab, iGainsTab,iPansTab, iEnabledTab, kOutputMode, aEnv, iCount+1
        if (kOutputMode == 1) then
        aOutL += aTempL
        aOutR += aTempR 
        endif

    RESONSKIP:
    
    xout aOutL, aOutR

endop


opcode performLfo, k, S
    
    Sname xin
    
    Sselect sprintfk "%sselect", Sname
 
    kSelect chnget Sselect


    kOut = 1
    
    if (kSelect == 1) kgoto END        

       
    Srate sprintfk "%srate", Sname
    kRate chnget Srate
    
    
    Srmin sprintfk "%srangeMin", Sname
    krMin chnget Srmin
    
    Srmax sprintfk "%srangeMax", Sname
    krMax chnget Srmax
    
    krMin = 1+krMin
    krMax = 1+krMax
    if (kSelect == 2) then                     
        kOut oscil 0.5, kRate, 201  
        kOut = (kOut+1)*(krMax-krMin)+krMin
    elseif (kSelect == 3) then
            kOut oscil 0.5, kRate, 202  
            kOut = (kOut+1)*(krMax-krMin)+krMin
    elseif (kSelect == 4) then
            kOut oscil 0.5, kRate, 203  
            kOut = (kOut+1)*(krMax-krMin)+krMin    
    elseif (kSelect == 5) then
        kOut randomi krMin, krMax, kRate, 2, 0
    
    elseif (kSelect == 6) then
        kOut randomh krMin, krMax, kRate, 2, 0
    
    elseif (kSelect == 7) then
        kOut random krMin, krMax
    endif  
    END:
    xout kOut
endop



opcode updateTables, i ,p
    idummy xin
    iCount = 0

    until iCount >= 24 do

        SName sprintf "enable%d", iCount
        tablew chnget(SName), iCount, giEnabled

        SName sprintf "note%d", iCount
        tablew chnget(SName), iCount, giNotes

        SName sprintf "gain%d", iCount
        tablew chnget(SName), iCount, giAmps
        
        SName sprintf "pan%d", iCount
        tablew chnget(SName), iCount, giPans
        
        SName sprintf "q%d", iCount
        tablew chnget(SName), iCount, giQs
        
        iCount += 1
    od
    xout 1
endop


instr 1

aOutL, aOutR init 0
ihandle updateTables 0
kInit init 0
iAttack chnget "voiceAttack"
iAttack *= 0.001
iDecay chnget "voiceDecay"
iDecay *= 0.001
iSustain chnget "voiceSustain"
iRelease chnget "voiceRelease"
iRelease *= 0.001

iInputMode chnget "inputMode"


kOutputMode = gkOutputMode

iTabSize tableng giNotes

iQsTab ftgen 0, 0, iTabSize, -24, giQs, i(gkQMin), i(gkQMax)


kCount init 0
kNum = 24


SKIP:
giInputCh = 0;
aIn = 0
if iInputMode == 1 then

    iSampleTime = tableng(giImpulse)/sr
    aIndex line 0, iSampleTime, 1

    aIn table3 aIndex, giImpulse, 1, 0, 0 
    
 
    
    aIn *= 0.01
    
elseif iInputMode == 2 then
/// Bowed input 
    iBowMode chnget "bowType"
    if  iBowMode == 1 then
        
        kBowNoiseOffsetLow chnget "bowNoiseOffsetLow"
        kBowNoiseOffsetHigh chnget "bowNoiseOffsetHigh"
        
        kBowRate init p4-i(kBowNoiseOffsetLow)
        kBowRate randomi mtof(p4+kBowNoiseOffsetLow), mtof(p4+kBowNoiseOffsetHigh), kBowRate
        kBowAmp randomi 0.5, 1., kBowRate*0.1
        aIn  poscil kBowAmp, kBowRate, giBow1
    elseif iBowMode == 2 then
        kDustLow chnget "bowNoiseDenseLow"
        kDustHigh chnget "bowNoiseDenseHigh"
        kDensity randomi kDustLow, kDustHigh, (kDustLow+kDustLow)/2
        aIn dust2 1, kDensity 

    elseif iBowMode == 3 then
        kBeta chnget "bowNoiseBeta"
        aIn noise 1, kBeta 
        
    elseif iBowMode == 4 then
          
    endif
    
    
    aIn *= 0.005
    
elseif iInputMode == 3 then
    
    giInputCh chnget "inputCh"
    
      
    aIn inch 1
    gaIns[0] = aIn
    aIn inch 2
    gaIns[1] = aIn
    
    
    gaIns = gaIns*chnget("inputGain")*p5
    
    
    
    klpoffset chnget "InputFilterOffset"
    ilpenabled chnget "inputFilterEnabled"
    if ilpenabled == 1 then
    aIn = gaIns[0]
    aFiltered = lowpass2(aIn, mtof(p4+klpoffset), 0.5)
    iInputFilterMode chnget "inputFilterMode"
        if iInputFilterMode == 0 then
            gaIns[0] = aFiltered
        else
            gaIns[0]= gaIns[0]-aFiltered
        endif   
        aIn = gaIns[1]
     aFiltered = lowpass2(aIn, mtof(p4+klpoffset), 0.5)
    iInputFilterMode chnget "inputFilterMode"
        if iInputFilterMode == 0 then
            gaIns[1] = aFiltered
        else
            gaIns[1]= gaIns[1]-aFiltered
        endif 
    endif
    
    iApEnabled chnget "inputApEnabled"
    if iApEnabled == 1 then
        iOrder chnget "inputAllpassOrder"
        kApOffset chnget "inputAllpassOffset"
        kApFeedback chnget "inputApFeedback"
        aIn = gaIns[0]
    aPhasor phaser1 aIn, mtof(ftom(kBowRate)+kApOffset), iOrder, kApFeedback
    gaIns[0] = aPhasor
        aIn = gaIns[1]
    aPhasor phaser1 aIn, mtof(ftom(kBowRate)+kApOffset), iOrder, kApFeedback
    gaIns[1] = aPhasor
    endif
    
   aIn = 0
    

endif
 //giInputCh = 1  //Changes things back to normal if input is not live 
///Input Filtering
    if iInputMode != 3 then
    klpoffset chnget "InputFilterOffset"
    ilpenabled chnget "inputFilterEnabled"
    if ilpenabled == 1 then
    
    aFiltered = lowpass2(aIn, mtof(p4+klpoffset), 0.5)
    iInputFilterMode chnget "inputFilterMode"
        if iInputFilterMode == 0 then
            aIn = aFiltered
        else
            aIn = aIn-aFiltered
        endif
    
    endif
    iApEnabled chnget "inputApEnabled"
    if iApEnabled == 1 then
        iOrder chnget "inputAllpassOrder"
        kApOffset chnget "inputAllpassOffset"
        kApFeedback chnget "inputApFeedback"
    aIn phaser1 aIn, mtof(ftom(kBowRate)+kApOffset), iOrder, kApFeedback
    endif
    endif

aIn *= chnget("inputGain")*p5
INPUTSKIP:
aEnv transegr 0, iAttack, 1, 1, iDecay, 0, iSustain, iRelease, -1, 0 
kPitch = p4

aOutL, aOutR resonbank aIn, kPitch, giNotes, iQsTab, giAmps, giPans, giEnabled,kOutputMode, aEnv, 0

aOutL *= aEnv
aOutR *= aEnv

gaOutL += aOutL
gaOutR += aOutR


endin

instr io
kGain chnget "gain"
aGain interp kGain


gaOutL lowpass2 gaOutL, sr/2.01, 1
gaOutR lowpass2 gaOutR, sr/2.01, 1

outs gaOutL*aGain, gaOutR*aGain
clear gaOutL, gaOutR

endin



instr update


gkKeyTracked chnget "keyTrack"
kAllOnTrigger chnget "allOn"
kAllOffTrigger chnget "allOff"
kRandomFreqTrigger chnget "randNotes"
kRandomQTrigger chnget "randQ"
kRandomGainTrigger chnget "randGain"
kRandomPanTrigger chnget "randPan"

kRandAllTrigger chnget "randAll"
kRandAll changed2 kRandAllTrigger
kRandAll *= kRandAllTrigger

kAllOn changed2 kAllOnTrigger
kAllOn *= kAllOnTrigger
kAllOff changed2 kAllOffTrigger
kAllOff *= kAllOffTrigger
kRandomFreq changed2 kRandomFreqTrigger
kRandomFreq *= kRandomFreqTrigger
kRandomQ changed2 kRandomQTrigger
kRandomQ *= kRandomQTrigger
kRandomGain changed2 kRandomGainTrigger
kRandomGain *= kRandomGainTrigger
kRandomPan changed2 kRandomPanTrigger
kRandomPan *= kRandomPanTrigger



kCount = 0
kRandomMode rand 1.5, 2
kRandomMode = round(kRandomMode+1.5)


until kCount >= 24 do

if (kAllOn == 1)|| (kRandAll == 1) then
SName sprintfk "enable%d", kCount
chnset k(1), SName
endif

if kAllOff == 1 then
SName sprintfk "enable%d", kCount
chnset k(0), SName

SName sprintfk "pan%d", kCount
tabw chnget(SName), kCount, giPans

endif


if (kRandomFreq == 1) || (kRandAll == 1) then    
    
    if kCount == 0 then
        kLastRand = 0
        kRDepth = rand(0.5)+0.5, 2
        kRDepth2 = rand(0.5)+0.5, 2
    else
        if kRandomMode == 0 then
                if k(rand(1))<0.5 then
            kLastRand += rand(0.25+0.25*kRDepth, 2)+0.25+kRDepth2*0.25
        else
            kLastRand += rand(3+3*kRDepth, 2)+3+4*kRDepth2
        endif
        
        elseif kRandomMode == 1 then
            kLastRand += rand(0.5+2*kRDepth, 2)+2*kRDepth2+0.5; 
    
        elseif kRandomMode == 2 then
    
            kLastRand += rand(kRDepth*1+2, 2)+(2+3*kRDepth2); 
    
        
    
        elseif kRandomMode == 3 then
    
        if kLastRand == 0 then
            kStep = 12
            
        else
            kStep = kStep*0.5;
        endif
        kLastRand += kStep + rand(kRDepth*3, 2);
    
    endif
    endif
    
    SName sprintfk "note%d", kCount
    chnset kLastRand, SName
endif



if (kRandomQ == 1) || (kRandAll == 1)  then

    kQ = k(rand(0.5)+0.5, 2)
    SName sprintfk "q%d", kCount
    chnset kQ, SName

endif

SName sprintfk "q%d", kCount
tabw chnget(SName), kCount, giQs

if (kRandomGain == 1) || (kRandAll == 1)  then
    kGain = k(rand(0.45, 2))+0.45+0.1
    SName sprintfk "gain%d", kCount
    chnset kGain, SName
    endif



if (kRandomPan == 1) || (kRandAll == 1)  then
    kPan = k(rand(, 2))+0.5
    SName sprintfk "pan%d", kCount
    chnset kPan, SName
    endif



kCount +=1

od

gkOutputMode chnget "outputMode"

gkQMin chnget "qMin"
gkQMax chnget "qMax"

/*
//Old code for file select
gSImpulseSelect chnget "impulseSelect"

if changed(gSImpulseSelect) == 1 then
    
    event "i", "readSoundfile", 0, 0
    
endif
*/






kInputMode chnget "inputMode"

if changed(kInputMode)==1 then
    if kInputMode == 1 then
        chnset "visible(1)", "impulseInput"
    else
    chnset "visible(0)", "impulseInput"
    endif
    
    if kInputMode == 2 then
        chnset "visible(1)", "bowedInput"
    else
        chnset "visible(0)", "bowedInput"
    endif

    

    
    if kInputMode == 3 then
    
        
            chnset "visible(1)", "liveInput"
    else
        chnset "visible(0)", "liveInput"
    
    endif

endif 

kBowType chnget "bowType"

if changed(kBowType)==1 then

    if kBowType == 1 then
        chnset "visible(1)", "sawBowOptions"
    else
        chnset "visible(0)", "sawBowOptions"
    
    endif

    if kBowType == 2 then
        chnset "visible(1)", "dustBowOptions"
    else
        chnset "visible(0)", "dustBowOptions"
    
    endif
    
    if kBowType == 3 then
    
    
           chnset "visible(1)", "bowNoise"
    else
        chnset "visible(0)", "bowNoise"
    
    
    endif

endif

kCount = 1
kImpulseLevels[] init 5
kImpulseChange = 0
kImpulseSlider init 0

until kCount >=6 do 

    kImpulseSlider chnget sprintfk("impulseSlider%d", kCount)
    
    if (kImpulseLevels[kCount-1]  != kImpulseSlider) then
        kImpulseLevels[kCount-1] = kImpulseSlider
        kImpulseChange = 1
    endif

    kCount += 1

od

if kImpulseChange == 1 then
  event "i", "refreshImpusleTable", 0, 1

endif

kInputFilterType chnget "inputFilterMode"

if changed(kInputFilterType)==1 then

    if kInputFilterType == 0 then 
    
    chnset "text(lowpass)", "inputFilterModeIdent"
    
    elseif  kInputFilterType == 1 then 
     chnset "text(highpass)", "inputFilterModeIdent"
    
    endif

endif


endin

instr refreshImpusleTable
 iImpulseLevels[] init 5
 
 iCount = 0
 
 until iCount >=5 do 

    iImpulseLevels[iCount] chnget sprintf("impulseSlider%d", iCount+1)
    

    iCount += 1

od


    
    iImpulseLevels limit iImpulseLevels, 0.001, 1
    
 iImpulseStep = tableng(giImpulse)/4
 giImpulse ftgen 200, 0, 2049, -5, iImpulseLevels[0], iImpulseStep, iImpulseLevels[1], iImpulseStep, iImpulseLevels[2], iImpulseStep, iImpulseLevels[3], iImpulseStep, iImpulseLevels[4] 

 chnset "tablenumber(200)", "impulseTab"
 
turnoff
endin
/*
instr readSoundfile 

    if (strcmpk(gSImpulseSelect, "") != 0) then   
    giSfTab = giSfTab%5+1
    giSfTabs ftgen giSfTab, 0, 0, 1, gSImpulseSelect, 0, 0, 0 
    Smessage sprintf "tablenumber(%d)", giSfTab
    chnset Smessage, "impulseDisplay"
    endif

    
    turnoff
    

endin
*/

instr importPartials

iCount = 0

until iCount >= 24 do

    //readfi 
    iline = 0
    if iline == -1 then
    
    iCount = 24
    
    else

    iCount += 1 
    
    endif

od
 
endin 

instr lfoDrive
    gkRandomPitch chnget "randomPitchPerNote"
    gkRandomGain chnget "randomGainPerNote"
    gkRandomQ chnget "randomQPerNote"
    gkRandomPan chnget "randomPanPerNote"
    
    kVib chnget "vibrato"
    kVibRate chnget "vibratoRate"
    kVibDepth chnget "vibratoDepth"
    kVibDeviate chnget "vibratoDeviation"

    if (kVib > 0) then
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[0] oscil kVib*0.5*kVibDepth,kThisVibRate , 201, 0
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[1] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.125
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[2] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.25
        
        kThisVibRate = kVibRate*randomi(1+kVibDeviate, 1-kVibDeviate, kVibRate*0.250)
        gkVibrato[3] oscil kVib*0.5*kVibDepth,kThisVibRate  , 201, 0.375
    
    else
        gkVibrato = gkVibrato*0
    
    endif
    
    kTrem chnget "trem"
    kTremRate chnget "tremRate"
    kTremDeviate chnget "tremDeviation"
    aTrem interp kTrem
    
    if (kTrem > 0) then
        kThisTremRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[0] oscil aTrem*0.5,kThisTremRate , 201, 0
        
        kThisVibRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[1] oscil aTrem*0.5,kThisTremRate  , 201, 0.125
        
        kThisVibRate = kTremRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[2] oscil aTrem*0.5,kThisTremRate  , 201, 0.25
        
        kThisVibRate = kVibRate*randomi(1+kTremDeviate, 1-kTremDeviate, kTremRate*0.250)
        gaTrem[3] oscil aTrem*0.5,kThisTremRate  , 201, 0.375
    
    else
        gaTrem = gaTrem*0
    
    endif
                
endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 200 0 2049 -5 1 2000 0.0001 29
f 201 0 2049 11 1
f 202 0 2049 7 1 2048 -1 
f 203 0 2049 7 0 1024 1 1024 -1
i "io" 0 z
i "lfoDrive" 0 z
i "update" 0 z


</CsScore>
</CsoundSynthesizer>
