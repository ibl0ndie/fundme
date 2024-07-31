//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Dex {
    uint256 public minimumInUsd = 2;
    address[] public funders;
    mapping (address funders => uint256 balance) 

    function fund() public payable {
        require(getConversionalRate(msg.value) >= minimumInUsd , "your balance is insufficient");
        funders.push(msg.sender);
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE);
        (,int256 price,,,) =  pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionalRate(uint256 bnbAmount) public view returns (uint256) {
        uint256 bnbPrice = getPrice();
        uint256 bnbAmountInUsd = (bnbAmount * bnbPrice) / 1e18;
        return bnbAmountInUsd;

    }
}