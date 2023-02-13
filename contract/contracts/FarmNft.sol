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

    Counters.Counter private _tokenIds; // 次にmintされるNFTのid

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

    function mintNFT(address to) public payable {
        require(availableMint > 0, "Not enough nft");
        require(isExpired() == false, "Already expired");
        require(msg.value == price);

        uint256 newItemId = _tokenIds.current();
        _safeMint(to, newItemId);
        _tokenIds.increment();
        availableMint--;
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        name(),
                        " == NFT #: ",
                        Strings.toString(_tokenId),
                        '", "description": "',
                        description,
                        '", "image": "',
                        "https://i.imgur.com/GZCdtXu.jpg",
                        '"}'
                    )
                )
            )
        );
        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return output;
    }

    function isExpired() public view returns (bool) {
        if (expirationDate < block.timestamp) {
            return true;
        } else {
            return false;
        }
    }

    function burnNFT() public {
        require(isExpired(), "still available");
        for (uint256 id = 0; id < _tokenIds.current; id++) {
            _burn(id);
        }
    }

    function getTokenOwners() public view returns (address[] memory) {
        address[] memory owners = new address[](_tokenIds.current());

        for (uint256 index = 0; index < _tokenIds.current(); index++) {
            owners[index] = ownerOf(index);
        }
        return owners;
    }
}
