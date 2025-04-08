// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileAccessControl {
    struct File {
        address owner;
        string name;
        string cid;
    }

    File[] public files;
    mapping(uint => address[]) public buyers;  // fileId → list of buyers
    mapping(uint => mapping(address => bool)) public hasPurchased;

    event FilePurchased(uint fileId, address buyer);
    event FileUploaded(uint fileId, address uploader);

    function uploadFile(string memory _name, string memory _cid) public {
        files.push(File(msg.sender, _name, _cid));
        emit FileUploaded(files.length - 1, msg.sender);
    }

    function buyFile(uint fileId) public payable {
        require(fileId < files.length, "Invalid file ID");
        require(msg.value >= 0.01 ether, "Insufficient payment");  // example price
        require(!hasPurchased[fileId][msg.sender], "Already purchased");

        hasPurchased[fileId][msg.sender] = true;
        buyers[fileId].push(msg.sender);

        // transfer funds to owner
        payable(files[fileId].owner).transfer(msg.value);

        emit FilePurchased(fileId, msg.sender);
    }

    function getFileCid(uint fileId) public view returns (string memory) {
        require(hasPurchased[fileId][msg.sender] || msg.sender == files[fileId].owner, "Access denied");
        return files[fileId].cid;
    }

    function getBuyers(uint fileId) public view returns (address[] memory) {
        return buyers[fileId];
    }
}
