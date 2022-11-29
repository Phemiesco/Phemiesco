//SPDX-License-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

// import "hardhat/console.sol";

contract Savings {
    uint256 public Maturitydate;  
    address payable private owner;

    event Withdrawal(uint256 amount, uint256 Date);

    constructor(uint256 _Maturitydate) payable {
        require(
            block.timestamp < _Maturitydate,
            "Maturitydate should be in the future"
        );

        Maturitydate = _Maturitydate;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= Maturitydate, "it's not maturity date yet");
        require(msg.sender == owner, "You cannot withdraw with from this account");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
