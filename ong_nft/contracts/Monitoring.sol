pragma solidity ^0.8.15;

contract Monitoring {
  string public class;
  string public precipitation;
  string public oxygenProduction;
  string public ndvi;

  constructor() public {
    class = "unknown";
    precipitation = "unknown";
    oxygenProduction = "unknown";
    ndvi = "unknown";
  }

  function setClass(string memory value) public {
    class = value;
  }

  function setPrecipitation(string memory value) public {
    precipitation = value;
  }

  function setOxygenProduction(string memory value) public {
    oxygenProduction = value;
  }

  function setNdvi(string memory value) public {
    ndvi = value;
  }
}