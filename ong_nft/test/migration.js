const Monitoring = artifacts.require("Monitoring") ;

contract("Monitoring" , () => {
    it("Monitoring Testing" , async () => {
       const monitoring = await Monitoring.deployed() ;
       await monitoring.setClass("class") ;
       await monitoring.setPrecipitation("precipitation") ;
       await monitoring.setOxygenProduction("oxygen production") ;
       await monitoring.setNdvi("ndvi") ;
       const temp1 = await monitoring.class() ;
       assert(temp1 === "class") ;
       const temp2 = await monitoring.precipitation() ;
       assert(temp2 === "precipitation") ;
       const temp3 = await monitoring.oxygenProduction() ;
       assert(temp3 === "oxygen production") ;
       const temp4 = await monitoring.ndvi() ;
       assert(temp4 === "ndvi") ;
    });
});