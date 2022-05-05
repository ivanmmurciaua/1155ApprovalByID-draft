// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC1155/ERC1155.sol";
import "./ERC1155/extensions/ERC1155Supply.sol";
import "./ERC1155/extensions/ERC1155ApprovalById.sol";
import "./ERC1155/extensions/ERC1155ApprovalByAmount.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";


contract My1155 is ERC1155, Ownable, Pausable, ERC1155Supply, ERC1155ApprovalById, ERC1155ApprovalByAmount {
    constructor() ERC1155("") {}

    event Minted(address to, uint256 id, uint256 amount, bytes data);
    event BatchMinted(address to, uint256[] ids, uint256[] amounts, bytes data);

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
        emit Minted(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
        emit BatchMinted(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        whenNotPaused
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}