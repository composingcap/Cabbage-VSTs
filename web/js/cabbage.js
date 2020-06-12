class cabbageAudio{
    csoundOptions;
    csoundOrch;
    csoundScore;
    cabbageGui;
    filename;
    
    constructor(pathToFile){
        this.filename = pathToFile;
    }
    
   readCabbageFile(){
       const request = new XMLHttpRequest();
       request.addEventListener("load", this.parseCabbage);
       request.open("GET","./fmMatrix.csd");
       request.send();
    }
    
    parseCabbage(reqListener){        
        var cabbageXML = reqListener.currentTarget.responseText;        
        var xmlParser = new DOMParser();
        cabbageXML = xmlParser.parseFromString(cabbageXML, "text/html");
        this.cabbageGui = cabbageXML.getElementsByTagName("Cabbage")[0].innerHTML;
        this.csoundOptions = cabbageXML.getElementsByTagName("CsOptions")[0].innerHTML;
        this.csoundOrch = cabbageXML.getElementsByTagName("CsInstruments")[0].innerHTML;
        this.csoundScore = cabbageXML.getElementsByTagName("CsScore")[0].innerHTML;
        
    }
    
    
}

//Test

var testCabbage = new cabbageAudio("./fmMatrix.csd");
testCabbage.readCabbageFile();