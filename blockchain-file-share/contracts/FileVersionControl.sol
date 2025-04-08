// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileVersionControl {
    struct FileVersion {
        string cid;
        uint256 timestamp;
        string changelog;
    }

    mapping(string => FileVersion[]) private fileVersions;
    mapping(string => address) private fileOwners;

    event NewVersionUploaded(string fileName, string cid, string changelog, uint256 timestamp);

    function addVersion(string memory _name, string memory _cid, string memory _changelog) public {
        if (fileVersions[_name].length == 0) {
            fileOwners[_name] = msg.sender; // Set owner for new file
        } else {
            require(fileOwners[_name] == msg.sender, "Not the file owner");
        }

        fileVersions[_name].push(FileVersion(_cid, block.timestamp, _changelog));
        emit NewVersionUploaded(_name, _cid, _changelog, block.timestamp);
    }

    function getVersions(string memory _name) public view returns (FileVersion[] memory) {
        return fileVersions[_name];
    }

    function getFileOwner(string memory _name) public view returns (address) {
        return fileOwners[_name];
    }
}
