<Cabbage>
form caption("FFT Bin Exchange") size(316, 216), colour(47, 79, 79), pluginid("pcwp")
gentable bounds(8,8,300,200) amprange(0,1,101,0.001) tablenumber(101) active(1) tablegridcolour(0,0,0,0) tablecolour:N(72, 209, 204) tablebackgroundcolour(27, 59, 59)

</Cabbage>

<CsoundSynthesizer>

<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1

;ksmps needs to be an integer div of hopsize 
ksmps = 16

instr 1

   ; hopsize
 ifftsize = 2048  ; FFT size 
 iolaps = 4 ; overlaps
 ihopsize = ifftsize/iolaps 
 ibw = sr/ifftsize ; bin bandwidth
 kcnt init 0    ; counting vars
 krow init 0
    kSpec[] init ifftsize
 kOla[] init ifftsize ; overlap-add buffer
 kIn[] init ifftsize  ; input buffer
 kOut[][] init iolaps, ifftsize ; output buffers

 a1 inch 1 ; audio input
    iExchange ftgen 101, 0, ifftsize, -7,0, ifftsize, 1
    iEmpty ftgen 102, 0, ifftsize, -2,0

 /* every hopsize samples */
 if kcnt == ihopsize then  
   /* window and take FFT */
   kWin[] window kIn,krow*ihopsize
   kFftIn[] fft kWin
    kBin= 0
    copyf2array kSpec, 102

   /* filter between high and low freqs */
     until kBin >= lenarray(kSpec) do 
         kIndex table kBin, 101 
         kSpec[kBin] = kFftIn[floor(kIndex*ifftsize)]+kSpec[kIndex]
         kBin += 1 
            od  
   
   /* IFFT + window */
   kRow[] fftinv kSpec
   kWin window kRow, krow*ihopsize
   /* place it on out buffer */
   kOut setrow kWin, krow

   /* zero the ola buffer */
   kOla = 0
   /* overlap-add */
   ki = 0
   until ki == iolaps do
     kRow getrow kOut, ki
     kOla = kOla + kRow
     ki += 1
   od
  
  /* update counters */ 
  krow = (krow+1)%iolaps
  kcnt = 0
 endif

 /* shift audio in/out of buffers */
 kIn shiftin a1
 a2 shiftout kOla
    out a2/iolaps

 /* increment counter */
 kcnt += ksmps

endin

</CsInstruments>

<CsScore>
i1 0 z
</CsScore>

</CsoundSynthesizer>

