// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// error SaleNotOpen();
error MaxSupplyExceeded();
error NotEnoughMatic();
error WithdrawFailed();
error claimed();

contract Vajira110 is ERC721URIStorage, ReentrancyGuard, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /* Variable */
    string public i_baseTokenURI;
    string private constant i_URIPrefix = ".json";
    address private immutable i_owner;
    uint256 private immutable i_maxSupply;
    uint256 private constant i_price = 750000000000000; // 0.00075 eth

    /* Mapping */
    // tokenId => claimed
    mapping(uint256 => bool) private claimedHealthCheck;

    /* Event */

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI,
        uint256 _maxSupply
    ) ERC721(_name, _symbol) {
        i_owner = msg.sender;
        i_baseTokenURI = _baseURI;
        i_maxSupply = _maxSupply;
        _tokenIds.increment(); // start at id 1 instead of 0
    }

    function mint() public payable {
        if (msg.value < i_price) revert NotEnoughMatic();
        if (_tokenIds.current() == i_maxSupply) revert MaxSupplyExceeded();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _tokenIds.increment();
    }

    // need to change profit distribute
    // set distribute share
    function Withdraw() public nonReentrant onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    /**
     *  Claim health check off-chain
     *      - Book health check
     *      - Pay fee off-chain
     *      - System confirm to blockchain (owner call this function)
     *
     *  Claim link
     *  www.vajiraHealthCheckOrSomething.co.th
     */
    function claimHealthCheck(uint256 _tokenIdClaim) public onlyOwner {
        if (claimedHealthCheck[_tokenIdClaim] == true) revert claimed();
        claimedHealthCheck[_tokenIdClaim] = true;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _requireMinted(tokenId);
        return
            bytes(i_baseTokenURI).length > 0
                ? string(
                    abi.encodePacked(
                        i_baseTokenURI,
                        Strings.toString(tokenId),
                        i_URIPrefix
                    )
                )
                : "";
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function getPrice() public pure returns (uint256) {
        return i_price;
    }

    function getMaxSupply() public view returns (uint256) {
        return i_maxSupply;
    }
}
