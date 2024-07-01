// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC721 {
    function transferFrom(address from, address to, uint tokenId) external;
}


contract EnglishAuction {

    //auction states
    bool public started;
    bool public ended;
    uint public endTime;

    uint public highestBid;
    address public highestBidder;
    mapping(address => uint) public allBids;

    address payable public immutable owner;
    IERC721 public immutable nft;
    uint public immutable nftId;

    event Start(uint startTime, uint endTime);
    event Bid(address indexed bidder, uint value);
    event End(uint value, address highestBidder);
    event Withdraw(address indexed bidder, uint value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(address _nft, uint _nftId) onlyOwner() {
        //init values
        //owner and NFT

        //payable so that we can send funds to the address
        owner = payable(msg.sender);

        nft = IERC721(_nft);
        nftId = _nftId;




    }

    function bid() external payable{

        //validations
        require(started, "Auction not started");
        require(block.timestamp < endTime, "Auction ended");
        require(msg.value > highestBid, "New bid is lower than the highest bid");



        //highest bidder, all bids, highest bidder
        allBids[highestBidder] += highestBid;
        highestBid = msg.value;
        highestBidder = payable(msg.sender);

        emit Bid(msg.sender, msg.value);

    }

    function start(uint _openingBid, uint _duration) external onlyOwner {

        require(!started, "Auction already started");
        
        highestBid = _openingBid;
        // highestBidder = payable(msg.sender);
        endTime = block.timestamp + _duration;
        nft.transferFrom(owner, address(this), nftId);
        started = true;

        emit Start(block.timestamp, endTime);

    }
    function end() external onlyOwner {
        //validations
        //end timestamp
        //price
        require(started, "Auction not started");
        require(block.timestamp > endTime, "Auction not ended");

        //ensures end event only once.
        require(!ended, "Auction already ended");
        ended = true;

        //highest bidder receives the item
        nft.transferFrom(address(this), highestBidder, nftId);
        owner.transfer(highestBid);
        emit End(highestBid, highestBidder);
        //owner receives ether
    }

    function withdraw() external {
        // bidder to receive back their ether
        uint value = allBids[msg.sender];
        allBids[msg.sender] = 0;
        payable(msg.sender).transfer(value);

        emit Withdraw(msg.sender, value);
    }


}
