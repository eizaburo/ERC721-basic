// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract MyToken is ERC721, Ownable, IERC721Enumerable {
    using Strings for uint256;
    //optional
    mapping(uint256 => string) private _tokenURIs;
    //base uri
    string private _baseURIextended;

    // constructor(string memory _name, string memory _symbol)
    //     ERC721(_name, _symbol)
    // {}

    constructor()
        ERC721("MyNFToken", "MNT")
    {}


    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseURIextended = baseURI_;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        //baseURIがない場合
        if (bytes(base).length == 0) {
            return _tokenURI;
        }

        //baseURI + tokenURIがある
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        //tokenURIがない
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function mint(
        address _to,
        uint256 _tokenId,
        string memory tokenURI_
    ) external onlyOwner {
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, tokenURI_);
    }

    function totalSupply() external view override returns (uint256) {
      return 1;
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {
        return 3;
    }

    function tokenByIndex(uint256 index) external view  override returns (uint256) {
      // You need update this logic.
      // ...
      return 5;
    }

}
