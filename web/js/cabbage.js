

class cabbageAudio{
    csoundOptions;
    csoundOrch;
    csoundScore;
    cabbageGui;
    filename;
    cabbageDiv;
    myCsound;
    csd;
    
    
    constructor(pathToFile){
        this.filename = pathToFile;
        this.myCsound = new Csound(); 
    }
    
   readCabbageFile(){
       const request = new XMLHttpRequest();
       request.addEventListener("load", this.parseCabbage);
       request.open("GET","./fmMatrix.csd");
       request.send();
    }
    
    domRender(){
        if (this.cabbageDiv == null){
        this.cabbageDiv= document.createElement()
        }
        this.cabbageDiv.innerHTML = this.csoundScore;
    }
    
    parseCabbage(reqListener){        
        var cabbageXML = reqListener.currentTarget.responseText;        
        var xmlParser = new DOMParser();
        
        cabbageXML = xmlParser.parseFromString(cabbageXML, "text/html");
        this.cabbageGui = cabbageXML.getElementsByTagName("Cabbage")[0].innerHTML;
        this.csoundOptions = cabbageXML.getElementsByTagName("CsOptions")[0].innerHTML;
        this.csoundOrch = cabbageXML.getElementsByTagName("CsInstruments")[0].innerHTML;
        this.csoundScore = cabbageXML.getElementsByTagName("CsScore")[0].innerHTML;
        this.csd = cabbageXML.getElementsByTagName("csoundsynthesizer")[0].innerHTML;
        
    }
    
    loadCsound(){       
        

        //this.myCsound.compileCsdText(this.csd); 
    
    }

    
    
}

//Test

var testCabbage = new cabbageAudio("./fmMatrix.csd");
testCabbage.readCabbageFile();

setTimeout(1000, testCabbage.loadCsound());

setTimeout(2000,csound.compileCSD(testCabbage.csd));