// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


contract TokenTool {

    function sendEthers(address[] calldata accounts, uint[] calldata values) payable external {
        require(accounts.length == values.length, "length");
        for (uint i = 0; i < accounts.length; i++) {
            payable(accounts[i]).transfer(values[i]);
        }
        if (address(this).balance > 0) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }

    function sendTokens(IERC20 token, address[] calldata accounts, uint[] calldata values) external {
        require(accounts.length == values.length, "length");
        for (uint i = 0; i < accounts.length; i++) {
            token.transferFrom(msg.sender, accounts[i], values[i]);
        }
    }

    function balancesOf(IERC20 token, address[] calldata accounts) public view returns (uint[] memory balances) {
        balances = new uint[](accounts.length);
        for (uint i = 0; i < accounts.length; i++) {
            balances[i] = token.balanceOf(accounts[i]);
        }
    }

    function balancesOfEther(address[] calldata accounts) public view returns (uint[] memory balances) {
        balances = new uint[](accounts.length);
        for (uint i = 0; i < accounts.length; i++) {
            balances[i] = accounts[i].balance;
        }
    }
}


interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}