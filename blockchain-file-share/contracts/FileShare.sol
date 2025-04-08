// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileShare {
    struct File {
        string cid;
        string name;
        address uploader;
    }

    File[] public files;

    event FileUploaded(string cid, string name, address uploader);

    function uploadFile(string memory _cid, string memory _name) public {
        files.push(File(_cid, _name, msg.sender));
        emit FileUploaded(_cid, _name, msg.sender);
    }

    function getAllFiles() public view returns (File[] memory) {
        return files;
    }

    function getFileCount() public view returns (uint256) {
        return files.length;
    }
}
