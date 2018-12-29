<Cabbage>
form caption("Spectral Pedal") size(375, 100), colour(50,50, 50), pluginid("sped")
combobox channel("fftSize")  items("512","1024", "2048", "4096", "8192", "16384") value(4) bounds(8,15,80,20)
label text("fft size") bounds(90, 20, 80, 10) align("left")
rslider text("overlap") channel ("overlap") bounds(130,10, 40,40) range(2,16,4,1,1)
rslider text("capture theshold") channel ("thresh") bounds(170,10, 80,40) range(0,1,0.1,1,0.001)
label bounds(0,75,350,10) align("right") text("© Christopher Poovey 2018")


button bounds(8, 100, 381, 50) channel("pedal") text("Pedal") colour:0("grey") colour:1("green") fontcolour:0("grey") bounds(260,10,100,40)

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
ksmps = 32
sr = 44100
nchnls = 2
0dbfs = 1


instr 1

    kped chnget "pedal"
    printk2 kped
    kchanged changed kped
    printk2 kchanged
    if  kchanged== 1 && kped == 1 then
       turnon 2
    elseif  kchanged== 1 && kped == 0 then
       turnoff2 2, 1, 1 
    endif

endin

instr 2

iFftSize = pow(2,chnget("fftSize")+8)   ;Set fft size based on combo bax

iOverlap chnget "overlap"               ;get overlap factor
iHopSize = iFftSize/iOverlap            ;convert overlap to hop size


;Initialize fft tables
START:
fAccum1 pvsinit iFftSize
fAccum2 pvsinit iFftSize

kFrameCount init 0 ;Initialize frame count

aIn1 inch 1
aIn2 inch 2

kFrameCount1 init 0
kFrameCount2 init 0
kThresh chnget "thresh"  ;capture threshold

if kFrameCount == 0 then
    fAccum1 pvsgain fAccum1, 0
    fAccum2 pvsgain fAccum2, 0   
    kFrameCount = 1 
    endif



kLevel1= rms(aIn1) 
    
if kLevel1 > kThresh then
    
    fIn1 pvsanal butterhp(aIn1,50), iFftSize, iHopSize, iFftSize, 0 
    fAccum1 pvsmix fIn1, fAccum1
    kFrameCount1 = 2
        
endif

kLevel2= rms(aIn2) 

if kLevel2 > kThresh then
    
    fIn2 pvsanal butterhp(aIn1,50), iFftSize, iHopSize, iFftSize, 0 
    fAccum2 pvsmix fIn2, fAccum2

    kFrameCount2 = 2
    
endif

aLf = butterlp(aIn1+aIn2, 50)


aNoise random -1, 1

fNoise pvsanal aNoise, iFftSize, iHopSize, iFftSize*0.9, 0 


fOut1 pvsfilter fNoise, fAccum1, 1
fOut2 pvsfilter fNoise, fAccum2, 1

aOut1 pvsynth fOut1
aOut2 pvsynth fOut2

kEnv1 init 0
kEnv2 init 0

if kFrameCount1 != 0 then
    kEnv1 linsegr 0, 2, 1, 2, 0
    endif 
    
if kFrameCount2 != 0 then
    kEnv2 linsegr 0, 2, 1, 2, 0
    endif 



outs aOut1*kEnv1, aOut2*kEnv2

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
i 1 0 z
</CsScore>
</CsoundSynthesizer>
