// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// error SaleNotOpen();
error SoldOut();
error NotEnoughMatic();
error WithdrawFailed();
error OnlyOwner();

contract Vajira110 is ERC721URIStorage {
    /* Variable */
    using Counters for Counters.Counter;
    Counters.Counter public _tokenIds;
    address private immutable i_owner;
    string public i_baseTokenURI;
    uint256 private constant i_price = 75000000000000000000; // 75 matic
    uint256 private constant i_maxSupply = 10000;

    /* Mapping */
    // tokenId => claimed
    mapping(uint256 => bool) private claimedHealthCheck;

    /* Event */

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI
    ) ERC721(_name, _symbol) {
        i_owner = msg.sender;
        i_baseTokenURI = _baseURI;
    }

    function mint(address _player) public payable returns (uint256) {
        if (msg.value < i_price) revert NotEnoughMatic();
        if (_tokenIds.current() >= i_maxSupply) revert SoldOut();

        uint256 newItemId = _tokenIds.current();
        _mint(_player, newItemId);
        _setTokenURI(newItemId, i_baseTokenURI);
        _tokenIds.increment();
        return newItemId;
    }

    function Withdraw() public {
        if (msg.sender != i_owner) revert OnlyOwner();
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
    function claimHealthCheck(uint256 _tokenIdClaim) public {
        if (msg.sender != i_owner) revert OnlyOwner();
        claimedHealthCheck[_tokenIdClaim] = true;
    }

    function setBaseURI(string memory _newURI) public {
        if (msg.sender != i_owner) revert OnlyOwner();
        i_baseTokenURI = _newURI;
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function getPrice() public pure returns (uint256) {
        return i_price;
    }
}
