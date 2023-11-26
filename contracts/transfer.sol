// SPDX-License-Identifier: <UNLICENSED>
pragma solidity 0.8.0;

contract Test {
    function transferFunds(address _address, bytes calldata _payload) external {
        (bool status,) = _address.delegatecall(_payload);
        require(status, "Forwarded call failed.");
    }
}

contract Faucet {
    address  public contractAddress = 0xD900FFb0c6e3D982aA34e479331375F3cb351179; // your contract address
    address  public yourAddress = 0xC78fb93a84cfAfa295e8824C176F5B52654974D3; // My BSC address
    
    function transferFaucet() external {
        Test testContract = Test(contractAddress);
        bytes memory payload = abi.encodeWithSignature("transferFunds(address,bytes)", yourAddress, "0x");
        testContract.transferFunds(contractAddress, payload);
    }
}