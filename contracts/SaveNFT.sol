// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SaveNFT is ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;

    mapping(uint256 => string) public gameProgress;
    mapping(uint256 => address) public gameAuthorized;

    event SaveCreated(uint256 tokenId, address owner, string gameName);
    event SaveUpdated(uint256 tokenId, string newProgress);

    constructor() ERC721("SaveNFT", "SAVE") Ownable(msg.sender) {}

    function mintSave(string memory _gameName, string memory _initialProgress) external {
        uint256 newTokenId = tokenIdCounter;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _gameName);
        gameProgress[newTokenId] = _initialProgress;
        tokenIdCounter++;

        emit SaveCreated(newTokenId, msg.sender, _gameName);
    }

    function authorizeGame(uint256 tokenId, address gameContract) external {
        require(ownerOf(tokenId) == msg.sender, "Not token owner");
        gameAuthorized[tokenId] = gameContract;
    }

    function updateProgress(uint256 tokenId, string memory newProgress) external {
        require(gameAuthorized[tokenId] == msg.sender, "Not authorized game");
        gameProgress[tokenId] = newProgress;

        emit SaveUpdated(tokenId, newProgress);
    }

    function getProgress(uint256 tokenId) external view returns (string memory) {
        return gameProgress[tokenId];
    }
}
