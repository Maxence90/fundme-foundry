// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "./HelpConfig.s.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "../script/HelpConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelpConfig helperConfig = new HelpConfig();
        address ethUsdPricedFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPricedFeed);
        vm.stopBroadcast();

        return fundMe;
        // address deployer;
        // FundMe fundMe;

        // // deployer = makeAddr("deployer");
        // // vm.deal(deployer, 10 ether);
        // HelpConfig config = new HelpConfig();
        // address priceFeed = config.activeNetworkConfig();

        // if (priceFeed == address(0)) {
        //     vm.startBroadcast();
        //     priceFeed = address(new MockV3Aggregator(8, 2000e8));
        //     vm.stopBroadcast();
        // }
        // vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // fundMe = new FundMe(priceFeed);

        // vm.stopBroadcast();
    }
}
