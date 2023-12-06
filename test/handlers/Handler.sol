// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {WETH9} from "../../src/WETH9.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {AddressSet, LibAddressSet} from "../helpers/AddressSet.sol";
import {console} from "forge-std/console.sol";

contract ForcePush {
    constructor(address dst) payable {
        selfdestruct(payable(dst));
    }
}

contract Handler is CommonBase, StdCheats, StdUtils {
    using LibAddressSet for AddressSet;

    AddressSet internal _actors;
    address internal currentActor;
    WETH9 public weth;
    uint256 public ETH_SUPPLY = 120_223_011 ether;
    uint256 public ghost_depositSum;
    uint256 public ghost_withdrawSum;
    uint256 public ghost_zeroWithdrawals;

    uint256 public ghost_forcePushSum;

    mapping(bytes32 => uint256) public calls;

    modifier createActor() {
        currentActor = msg.sender;
        _actors.add(msg.sender);
        _;
    }

    modifier countCall(bytes32 key) {
        calls[key]++;
        _;
    }

    modifier useActor(uint256 actorIndexSeed) {
        currentActor = _actors.rand(actorIndexSeed);
        _;
    }

    constructor(WETH9 _weth) {
        weth = _weth;
        deal(address(this), ETH_SUPPLY);
    }

    function callSummary() external view {
        console.log("Call summary:");
        console.log("-------------------");
        console.log("deposit", calls["deposit"]);
        console.log("withdraw", calls["withdraw"]);
        console.log("sendFallback", calls["sendFallback"]);
        console.log("-------------------");

        console.log("Zero withdrawals:", ghost_zeroWithdrawals);
    }

    function deposit(uint256 amount) public createActor countCall("deposit") {
        amount = bound(amount, 0, address(this).balance);
        _pay(currentActor, amount);

        vm.prank(currentActor);
        weth.deposit{value: amount}();

        ghost_depositSum += amount;
    }

    function withdraw(
        uint256 actorSeed,
        uint256 amount
    ) public useActor(actorSeed) countCall("withdraw") {
        amount = bound(amount, 0, weth.balanceOf(currentActor));
        if (amount == 0) ghost_zeroWithdrawals++;

        vm.startPrank(currentActor);
        weth.withdraw(amount);
        _pay(address(this), amount);
        vm.stopPrank();

        ghost_withdrawSum += amount;
    }

    function sendFallback(uint256 amount) public createActor {
        amount = bound(amount, 0, address(this).balance);
        _pay(currentActor, amount);

        vm.prank(currentActor);
        (bool success, ) = address(weth).call{value: amount}("");

        require(success, "sendFallback failed");
        ghost_depositSum += amount;
    }

    function _pay(address to, uint256 amount) internal {
        (bool s, ) = to.call{value: amount}("");
        require(s, "pay() failed");
    }

    function actors() external returns (address[] memory) {
        return _actors.addrs;
    }

    function forEachActor(function(address) external func) public {
        return _actors.forEach(func);
    }

    function reduceActors(
        uint256 acc,
        function(uint256, address) external returns (uint256) func
    ) public returns (uint256) {
        return _actors.reduce(acc, func);
    }

    function approve(
        uint256 actorSeed,
        uint256 spenderSeed,
        uint256 amount
    ) public useActor(actorSeed) countCall("approve") {
        address spender = _actors.rand(spenderSeed);

        vm.prank(currentActor);
        weth.approve(spender, amount);
    }

    function transfer(
        uint256 actorSeed,
        uint256 toSeed,
        uint256 amount
    ) public useActor(actorSeed) countCall("transfer") {
        address to = _actors.rand(toSeed);

        amount = bound(amount, 0, weth.balanceOf(currentActor));

        vm.prank(currentActor);
        weth.transfer(to, amount);
    }

    function transferFrom(
        uint256 actorSeed,
        uint256 fromSeed,
        uint256 toSeed,
        bool _approve,
        uint256 amount
    ) public useActor(actorSeed) countCall("transferFrom") {
        address from = _actors.rand(fromSeed);
        address to = _actors.rand(toSeed);

        amount = bound(amount, 0, weth.balanceOf(from));

        if (_approve) {
            vm.prank(from);
            weth.approve(currentActor, amount);
        } else {
            amount = bound(amount, 0, weth.allowance(currentActor, from));
        }

        vm.prank(currentActor);
        weth.transferFrom(from, to, amount);
    }

    function forcePush(
        uint256 amount
    ) public countCall("forcePush") {
        amount = bound(amount, 0, address(this).balance);
        new ForcePush{ value: amount }(address(weth));
        ghost_forcePushSum += amount;
    }

    receive() external payable {}
}
