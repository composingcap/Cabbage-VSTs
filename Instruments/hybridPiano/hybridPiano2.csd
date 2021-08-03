<Cabbage>
#define PSLIDER colour(10,10,10, 50), textcolour("white"), trackercolour("white") markercolour("white")

form caption("Hybrid Piano") size(600, 250), colour(58, 110, 182), pluginid("cphb"), bundle("./media") titlebarcolour("black") style("flat")

image file("./media/pianoBackground.png") bounds(0,0,600,250)
image bounds(125,10,225,125) colour(0,0,0,100) corners(15){
rslider channel("attackTime") range(10,5000, 500, 0.5) bounds(0,0,70,50) text("attack time") $PSLIDER
rslider channel("attackAmp") range(0,1, 0.25, 0.5) bounds(75,0,70,50) text("sustain amp") $PSLIDER
rslider channel("decayTime") range(10,5000, 50, 0.5) bounds(0,75,70,50) text("release time") identchannel("decayTime_ident")  $PSLIDER
rslider channel("releaseRatio") range(0.1,2, 0.5, 0.5) bounds(0,75,70,50) text("release ratio") visible(0) identchannel("releaseRatio_ident") $PSLIDER
rslider channel("decayAmp") range(0.001,1, 1, 0.5) bounds(75,75,70,50) text("release amp") $PSLIDER
rslider channel("envelopeCurve") range(-2,2, 0.5, 1) bounds(150,0,80,50) text("envelope curve") $PSLIDER
rslider channel("rev") text("reverb mix")range(0,1, 0, 1) bounds(150,75,80,50) $PSLIDER
}
image bounds(400,10,225,125) colour(0,0,0,100) corners(15){
combobox items("granular piano" , "aux sounds") channel("mode") bounds(0,0, 150,14)
combobox items("fixed release" , "dyanmic release") channel("releaseMode") bounds(0,20, 150,14)

}

vslider channel("amp") range(0,1,0.75, 2) bounds(20,20,50,125) $PSLIDER markercolour("white") colour("white") text("amp")

keyboard bounds(8, 158, 381, 60)
image colour("white") bounds(0,225,400,25){
    label text("Created by Christopher Poovey") bounds(5,2,150, 10) fontcolour("black") align("left")
    label text("Samples taken from Salamander Grand Piano") bounds(5,15,250, 10) fontcolour("black") align("left")
}
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity=5
</CsOptions>
<CsInstruments>
; Initialize the global variables.
ksmps = 128
nchnls = 2
0dbfs = 1



;If adding your own samples the samples should be ordered by pitch class, octave (increasing), the velocity step (increasing)
;The code also assumes pitches are in a dimishished chord starting on A0 this will need to be modifies if your samples are different.

giSf init 0
gSSampleFolder init "./media/Salamander Samples Min" ;Path to a folder with samples
gSSampleFolderRel init "./media/Salamander Release" ;Path to a folder with samples
gSirPath init "./media/Reverb/salmanderPianoIR.wav" ;Path to an impulse response for the IR
giVelSamps init 4 ;The number of velocity steps per pitch
giPcOffset init 32 ; this is the number of files per pitchclass-- can be computed through numberOfOctaves*numberOfVelSteps


;instrument will be triggered by keyboard widget

giInterpTime = 0.25;


instr 1

iMode chnget "mode"



iAttackTime chnget "attackTime"
iAttackAmp chnget "attackAmp"
iEnvCurve chnget "envelopeCurve"



kEnv linseg 0, iAttackTime/1000, iAttackAmp

kMix linsegr 1, 0.01, 1, giInterpTime, 0

iExponent = pow(2,iEnvCurve)

kEnv pow kEnv, iExponent
if iMode == 1 then
aFade linseg 0, 0.25, 1
iPitch = p4-12
iPc = iPitch%12
iTune = 1
iOctave = floor((iPitch)/12)

if (iPc < 3) then
    iTune = pow(2,iPc/12)
    iPcOffset = giPcOffset*0


elseif iPc < 6 then
    iTune = pow(2,(iPc-3)/12)
    iPcOffset = giPcOffset*1

elseif iPc < 9 then
    iTune = pow(2,(iPc-6)/12)
    iPcOffset = giPcOffset*2
    iOctave -= 1

elseif iPc < 12 then
    iTune = pow(2,(iPc-9)/12)
    iPcOffset = giPcOffset*3
    iOctave -= 1

endif



iVelStep= (p5/128)*giVelSamps
iVelStep floor iVelStep

itableNumber = iPcOffset+iOctave*giVelSamps+iVelStep+100
iStart = 0.5
iEnd = 1.5
kRate randomi -0.1,0.1, 10
kOverlap randomi 2*p5/127+1,3*p5/127+1+2, 10
kSize = randomi(0.1,0.2, 10)
endif

if iMode == 2 then
aFade = 1
itableNumber= 900+p4-24
iTune = 1
iStart = 0.01
iEnd = 0.1
kRate randomi -0.01,0.01, 10
kOverlap randomi 1+kEnv*2,2+kEnv*2+p5/127*1, 10
kSize = randomi(0.1,0.2, 10)
endif

aSamp loscil 1, iTune, itableNumber, 1, 0



aGrain syncloop 1, 1/(kSize/kOverlap), iTune, kSize, kRate, iStart, iEnd, itableNumber, 10, 5, 0.5
aOut = aGrain*aFade+aSamp
aOut butterhp aOut, cpsmidinn(p4)
aOut = aOut * pow(p5/127,2)
kMix pow kMix, 0.5
gaOut += aOut*a(kEnv*0.5*kMix)

kRel release
    if kRel == 1 && changed(kRel) == 1 then
        //isamps= ftcps(itableNumber) //this breaks everything for some reason
        isr = 41000
        kTimePassed timeinsts
        iReleaseMode chnget "releaseMode"
        if ( iReleaseMode == 1 ) then
            kDecayTime = chnget("decayTime")/1000
        elseif iReleaseMode == 2 then
            kDecayTime = kTimePassed*chnget("releaseRatio")
        endif

        kDecayAmp chnget "decayAmp"


        kStart = kTimePassed*isr*iTune


        event "i", "keyOff", 0, kDecayTime+0.1, p4, p5, itableNumber, iTune, kDecayAmp, kEnv, iExponent, kStart
    endif


endin


instr keyOff

    iMode chnget "mode"
    iDecayTime = p3 - 0.1
    iDecayAmp = p8
    itableNumber = p6
    iTune = p7
    iAttackAmp = p9
    iExponent = p10
    kEnv linseg iAttackAmp, iDecayTime, iDecayAmp, 0.1, 0
    kMix linseg 0, giInterpTime, 1
    kEnv pow kEnv, iExponent
    aSamp init 0
    if iMode == 1 then
    iStart = p11








    if iStart < tableng(itableNumber) then
        aSamp loscilx 1, iTune, itableNumber, 2, 0, iStart
    endif


    kRate randomi -0.1,0.1, 10
    kOverlap randomi 2,3, 10
    

    kSize = randomi(0.1,0.2, 10)
    iStart = 0.5
    iEnd = 1.5

  elseif iMode == 2 then
  
    itableNumber= 900+p4-24
    iTune = 1
    iStart = 0.01
    iEnd = 0.1
    kRate randomi -0.01,0.01, 10
    kOverlap randomi 2*p5/127+1,3*p5/127+1+2, 10
    kSize = randomi(0.1,0.2, 10)
    endif


    aGrain syncloop 1, 1/(kSize/kOverlap), iTune, kSize, kRate, iStart, iEnd, itableNumber, 10, 5, 0.5

    aOut = aGrain
    aOut butterhp aOut, cpsmidinn(p4)
    aOut = (aOut+aSamp) * pow(p5/127,2)
    kMix pow kMix, 0.5

    gaOut += aOut*a(kEnv*0.5*kMix)

endin


instr io

kAmp chnget "amp"
aAmp = a(kAmp)
kRev chnget "rev"
aOut = gaOut*aAmp
aRev = a(kRev)

if kRev > 0 then
    ;Perform convolution if it is more than 0
   aRev1, aRev2 pconvolve  aOut, gSirPath, 2048
endif

outs aOut*(1-aRev)+aRev1*aRev*0.125, aOut*(1-aRev)+aRev2*aRev*0.125


clear gaOut

;Gui

kReleaseMode chnget "releaseMode"
if changed(kReleaseMode) == 1 then
    if kReleaseMode == 1 then

    chnset "visible(0)", "releaseRatio_ident"
    chnset "visible(1)", "decayTime_ident"

    elseif kReleaseMode == 2 then
        chnset "visible(1)", "releaseRatio_ident"
        chnset "visible(0)", "decayTime_ident"
    endif
endif



endin

instr loadSamples

giNSamples ftsamplebank gSSampleFolder, 100, 0, 4, 1
;The bank used has 4 velocity steps per note and is organized by pc then octave. Each pitch class has 32 members
;pitch classed 0, 3, 6, and 9 are repesented

giNSamplesRel ftsamplebank gSSampleFolderRel, 900, 0, 4, 1

print(giNSamplesRel)
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
f 10 0 8192 20 2 1
i "io" 0 6000000*600000
i "loadSamples" 0 1

</CsScore>
</CsoundSynthesizer>
