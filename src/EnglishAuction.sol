// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EnglishAuction {

    constructor() {
        //init values
        //owner and NFT


    }

    function bid() external payable{

        //validations
        //highest bidder, all bids, highest bidder

    }

    function start() external onlyOwner {
        //validations
        //start time
        //end time
        //price
    }
    function end() external onlyOwner {
        //validations
        //end timestamp
        //price

        //highest bidder receives the item
        //owner receives ether
    }

    function withdraw() external {
        // bidder to receive back their ether
    }


}
