// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FarmNft is ERC721 {
    address public farmerAddress; // このスマートコントラクトを作成した農家のアドレスを保存
    string public farmerName; // 農家の名前
    string public description; // NFTに関する説明文
    uint256 public totalMint; // mintできるNFTの総量
    uint256 public availableMint; // 現在mintできる残りのNFTの数
    uint256 public price; // 1つのNFTの値段
    uint256 public expirationDate; // このコントラクト自体の有効期限

    using Counters for Counters.Counter;

    constructor(
        address _farmerAddress,
        string memory _farmerName,
        string memory _description,
        uint256 _totalMint,
        uint256 _price,
        uint256 _expirationDate
    ) ERC721("Farm NFT", "FARM") {
        farmerAddress = _farmerAddress;
        farmerName = _farmerName;
        description = _description;
        totalMint = _totalMint;
        availableMint = _totalMint;
        price = _price;
        expirationDate = _expirationDate;
    }
}
