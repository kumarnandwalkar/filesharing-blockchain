// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileVersionControl {
    struct FileVersion {
        string cid;
        uint256 timestamp;
        string changelog;
    }

    struct File {
        string name;
        address owner;
        FileVersion[] versions;
    }

    File[] public files;

    event NewVersionUploaded(uint fileId, string cid, string changelog, uint256 timestamp);

    function uploadNewFile(string memory _name, string memory _cid, string memory _changelog) public {
        File storage newFile = files.push();
        newFile.name = _name;
        newFile.owner = msg.sender;
        newFile.versions.push(FileVersion(_cid, block.timestamp, _changelog));

        emit NewVersionUploaded(files.length - 1, _cid, _changelog, block.timestamp);
    }

    function uploadNewVersion(uint fileId, string memory _cid, string memory _changelog) public {
        require(fileId < files.length, "Invalid file ID");
        require(msg.sender == files[fileId].owner, "Not the owner");

        files[fileId].versions.push(FileVersion(_cid, block.timestamp, _changelog));
        emit NewVersionUploaded(fileId, _cid, _changelog, block.timestamp);
    }

    function getLatestVersion(uint fileId) public view returns (string memory cid, string memory changelog, uint timestamp) {
        require(fileId < files.length, "Invalid file ID");
        FileVersion memory latest = files[fileId].versions[files[fileId].versions.length - 1];
        return (latest.cid, latest.changelog, latest.timestamp);
    }

    function getVersionCount(uint fileId) public view returns (uint) {
        return files[fileId].versions.length;
    }

    function getFileOwner(uint fileId) public view returns (address) {
        return files[fileId].owner;
    }
}
