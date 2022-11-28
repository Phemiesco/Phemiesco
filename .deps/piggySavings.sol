//SPDX-License-Identifier: MIT
pragma solidity ^0.5.1;

contract piggySavings {

    // who can withdraw
    // who much can they withdraw
    // when can they withdraw
    address payable public beneficiary;
    uint256 public releaseTime;

    constructor(address payable _beneficiary, uint256 _releaseTime) public payable{
        require(_releaseTime > block.timestamp);
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
    }

    function release() public payable{
        require(block.timestamp >= releaseTime);
        address(beneficiary).transfer(address(this).balance);
    }
}
contract piggySavingsFactory {
    piggySavings [] public Piggys;

    function create(address _beneficiary, uint256 _releaseTime) public {
        piggySavings piggys = new piggySavings(_beneficiary, _releaseTime);
            Piggys.push(piggys);
    } 
}