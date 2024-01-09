# Sstan - v0.1.0 

 --- 
 TODO: add description

# Summary




## Vulnerabilities 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[High-0]](#[High-0]) | Uninitialized storage variables | 3 |
 | [[Low-1]](#[Low-1]) | Use a locked pragma version instead of a floating pragma version | 3 |
 | [[Low-2]](#[Low-2]) | Unsafe ERC20 Operation | 1 |
## Optimizations 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[Gas-0]](#[Gas-0]) | Mark storage variables as `constant` if they never change. | 1 |
 | [[Gas-1]](#[Gas-1]) | Mark storage variables as `immutable` if they never change after contract initialization. | 1 |
 | [[Gas-2]](#[Gas-2]) | Consider marking constants as private | 1 |
 | [[Gas-3]](#[Gas-3]) | `unchecked{++i}` instead of `i++` (or use assembly when applicable) | 1 |
 | [[Gas-4]](#[Gas-4]) | Cache Storage Variables in Memory | 2 |
 | [[Gas-5]](#[Gas-5]) | Optimal Comparison | 2 |
 | [[Gas-6]](#[Gas-6]) | Use custom errors instead of string error messages | 1 |
 | [[Gas-7]](#[Gas-7]) | Use assembly for math (add, sub, mul, div) | 2 |
 | [[Gas-8]](#[Gas-8]) | Event is not properly indexed. | 1 |
 | [[Gas-9]](#[Gas-9]) | Mark functions as payable (with discretion) | 3 |
 | [[Gas-10]](#[Gas-10]) | Use assembly when getting a contract's balance of ETH | 2 |
 | [[Gas-11]](#[Gas-11]) | Cache array length during for loop definition. | 1 |
## Quality Assurance 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[NonCritical-0]](#[NonCritical-0]) | Private variables should contain a leading underscore | 1 |
 | [[NonCritical-1]](#[NonCritical-1]) | Constructor should check that all parameters are not 0 | 1 |
 | [[NonCritical-2]](#[NonCritical-2]) | This error has no parameters, the state of the contract when the revert occured will not be available | 1 |
 | [[NonCritical-3]](#[NonCritical-3]) | Function names should be in camelCase | 7 |
 | [[NonCritical-4]](#[NonCritical-4]) | Require/Revert statements should be consistent across the codebase | 1 |
 | [[NonCritical-5]](#[NonCritical-5]) | Constant and immutable variable names should be in SCREAMING_SNAKE_CASE | 1 |
 | [[NonCritical-6]](#[NonCritical-6]) | Consider marking public function External | 12 |
 | [[NonCritical-7]](#[NonCritical-7]) | Consider adding a message with require and revert statements | 5 |
 | [[NonCritical-8]](#[NonCritical-8]) | Remove any unused functions | 1 |
 | [[NonCritical-9]](#[NonCritical-9]) | Function parameters should be in camelCase | 13 |
 | [[NonCritical-10]](#[NonCritical-10]) | Consider explicitly naming mapping parameters | 3 |

## Vulnerabilities - Total: 7 

<a name=[High-0]></a>
### [High-0] Uninitialized storage variables - Instances: 3 

 > A storage variable that is declared but not initialized will have a default value of zero (or the equivalent, such as an empty array for array types or zero-address for address types). Failing to initialize a storage variable can pose risks if the contract logic assumes that the variable has been explicitly set to a particular value. 

 --- 

File:WETH9.sol#L19
```solidity
18:    string public name = "Wrapped Ether";
``` 



File:WETH9.sol#L20
```solidity
19:    string public symbol = "WETH";
``` 



File:WETH9.sol#L21
```solidity
20:    uint8 public decimals = 18;
``` 



 --- 

<a name=[Low-1]></a>
### [Low-1] Use a locked pragma version instead of a floating pragma version - Instances: 3 

 > ""
        Floating pragma is a vulnerability in smart contract code that can cause unexpected behavior by allowing the compiler to use a specified range of versions. \n This can lead to issues such as using an older compiler version with known vulnerabilities, using a newer compiler version with undiscovered vulnerabilities, inconsistency across files using different versions, or unpredictable behavior because the compiler can use any version within the specified range. It is recommended to use a locked pragma version in order to avoid these potential vulnerabilities. In some cases it may be acceptable to use a floating pragma, such as when a contract is intended for consumption by other developers and needs to be compatible with a range of compiler versions.
        <details>
        <summary>Expand Example</summary>

        #### Bad

        ```js
            pragma solidity ^0.8.0;
        ```

        #### Good

        ```js
            pragma solidity 0.8.15;
        ```
        </details>
        "" 

 --- 

File:WETH9.sol#L16
```solidity
15:pragma solidity ^0.8.13;
``` 



File:FundMe.sol#L3
```solidity
2:pragma solidity ^0.8.19;
``` 



File:PriceConverter.sol#L2
```solidity
1:pragma solidity ^0.8.19;
``` 



 --- 

<a name=[Low-2]></a>
### [Low-2] Unsafe ERC20 Operation - Instances: 1 

 > ""
        ERC20 operations can be unsafe due to different implementations and vulnerabilities in the standard. To account for this, either use OpenZeppelin's SafeERC20 library or wrap each operation in a require statement. \n
        > Additionally, ERC20's approve functions have a known race-condition vulnerability. To account for this, use OpenZeppelin's SafeERC20 library's `safeIncrease` or `safeDecrease` Allowance functions.
        <details>
        <summary>Expand Example</summary>

        #### Unsafe Transfer

        ```js
        IERC20(token).transfer(msg.sender, amount);
        ```

        #### OpenZeppelin SafeTransfer

        ```js
        import {SafeERC20} from \"openzeppelin/token/utils/SafeERC20.sol\";
        //--snip--

        IERC20(token).safeTransfer(msg.sender, address(this), amount);
        ```
                
        #### Safe Transfer with require statement.

        ```js
        bool success = IERC20(token).transfer(msg.sender, amount);
        require(success, \"ERC20 transfer failed\");
        ```
                
        #### Unsafe TransferFrom

        ```js
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        ```

        #### OpenZeppelin SafeTransferFrom

        ```js
        import {SafeERC20} from \"openzeppelin/token/utils/SafeERC20.sol\";
        //--snip--

        IERC20(token).safeTransferFrom(msg.sender, address(this), amount);
        ```
                
        #### Safe TransferFrom with require statement.

        ```js
        bool success = IERC20(token).transferFrom(msg.sender, address(this), amount);
        require(success, \"ERC20 transfer failed\");
        ```

        </details>
        "" 

 --- 

File:WETH9.sol#L43
```solidity
42:        payable(msg.sender).transfer(wad);
``` 



 --- 



## Optimizations - Total: 18 

<a name=[Gas-0]></a>
### [Gas-0] Mark storage variables as `constant` if they never change. - Instances: 1 

 > 
 State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time. 
 The compiler does not reserve a storage slot for these variables, and every occurrence is inlined by the respective value. 
 Compared to regular state variables, the gas costs of constant and immutable variables are much lower. For a constant variable, the expression assigned to it is copied to all the places where it is accessed and also re-evaluated each time. This allows for local optimizations. Immutable variables are evaluated once at construction time and their value is copied to all the places in the code where they are accessed. For these values, 32 bytes are reserved, even if they would fit in fewer bytes. Due to this, constant values can sometimes be cheaper than immutable values. - Savings: ~2103 
 

 --- 

File:WETH9.sol#L21
```solidity
20:    uint8 public decimals = 18;
``` 



File:WETH9.sol#L20
```solidity
19:    string public symbol = "WETH";
``` 



File:WETH9.sol#L19
```solidity
18:    string public name = "Wrapped Ether";
``` 



 --- 

<a name=[Gas-1]></a>
### [Gas-1] Mark storage variables as `immutable` if they never change after contract initialization. - Instances: 1 

 > 
 State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time. 
 The compiler does not reserve a storage slot for these variables, and every occurrence is inlined by the respective value. 
 Compared to regular state variables, the gas costs of constant and immutable variables are much lower. For a constant variable, the expression assigned to it is copied to all the places where it is accessed and also re-evaluated each time. This allows for local optimizations. Immutable variables are evaluated once at construction time and their value is copied to all the places in the code where they are accessed. For these values, 32 bytes are reserved, even if they would fit in fewer bytes. Due to this, constant values can sometimes be cheaper than immutable values. 
 - Savings: ~2103 
 

 --- 

File:FundMe.sol#L27
```solidity
26:    AggregatorV3Interface private s_priceFeed;
``` 



 --- 

<a name=[Gas-2]></a>
### [Gas-2] Consider marking constants as private - Instances: 1 

 > 
 Consider marking constant variables in storage as private to save gas (unless a constant variable should be easily accessible by another protocol or offchain logic). - Savings: ~22 
 

 --- 

File:FundMe.sol#L23
```solidity
22:    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
``` 



 --- 

<a name=[Gas-3]></a>
### [Gas-3] `unchecked{++i}` instead of `i++` (or use assembly when applicable) - Instances: 1 

 > 
 Use `++i` instead of `i++`. This is especially useful in for loops but this optimization can be used anywhere in your code. You can also use `unchecked{++i;}` for even more gas savings but this will not check to see if `i` overflows. For extra safety if you are worried about this, you can add a require statement after the loop checking if `i` is equal to the final incremented value. For best gas savings, use inline assembly, however this limits the functionality you can achieve. For example you cant use Solidity syntax to internally call your own contract within an assembly block and external calls must be done with the `call()` or `delegatecall()` instruction. However when applicable, inline assembly will save much more gas. - Savings: ~342 
 

 --- 

File:FundMe.sol#L76
```solidity
75:        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
``` 



File:FundMe.sol#L62
```solidity
61:        for (uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++) {
``` 



 --- 

<a name=[Gas-4]></a>
### [Gas-4] Cache Storage Variables in Memory - Instances: 2 

 > 
  - Savings: ~0 
 

 --- 

File:FundMe.sol#L63
```solidity
62:            address funder = s_funders[funderIndex];
``` 



File:FundMe.sol#L66
```solidity
65:        s_funders = new address[](0);
``` 



File:FundMe.sol#L63
```solidity
62:            address funder = s_funders[funderIndex];
``` 



File:FundMe.sol#L66
```solidity
65:        s_funders = new address[](0);
``` 



File:FundMe.sol#L80
```solidity
79:        s_funders = new address[](0);
``` 



File:FundMe.sol#L80
```solidity
79:        s_funders = new address[](0);
``` 



File:WETH9.sol#L42
```solidity
41:        balanceOf[msg.sender] -= wad;
``` 



File:WETH9.sol#L65
```solidity
64:            require(allowance[src][msg.sender] >= wad);
``` 



File:WETH9.sol#L66
```solidity
65:            allowance[src][msg.sender] -= wad;
``` 



File:WETH9.sol#L69
```solidity
68:        balanceOf[src] -= wad;
``` 



File:WETH9.sol#L70
```solidity
69:        balanceOf[dst] += wad;
``` 



 --- 

<a name=[Gas-5]></a>
### [Gas-5] Optimal Comparison - Instances: 2 

 > 
 When comparing integers, it is cheaper to use strict `>` & `<` operators over `>=` & `<=` operators, even if you must increment or decrement one of the operands. 
 Note: before using this technique, it's important to consider whether incrementing/decrementing one of the operators could result in an over/underflow. This optimization is applicable when the optimizer is turned off. - Savings: ~3 
 

 --- 

File:FundMe.sol#L55
```solidity
54:        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
``` 



File:WETH9.sol#L41
```solidity
40:        require(balanceOf[msg.sender] >= wad);
``` 



File:WETH9.sol#L62
```solidity
61:        require(balanceOf[src] >= wad);
``` 



File:WETH9.sol#L65
```solidity
64:            require(allowance[src][msg.sender] >= wad);
``` 



 --- 

<a name=[Gas-6]></a>
### [Gas-6] Use custom errors instead of string error messages - Instances: 1 

 > 
 Using custom errors will save you gas, and can be used to provide more information about the error. - Savings: ~57 
 

 --- 

File:FundMe.sol#L55
```solidity
54:        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
``` 



 --- 

<a name=[Gas-7]></a>
### [Gas-7] Use assembly for math (add, sub, mul, div) - Instances: 2 

 > 
 Use assembly for math instead of Solidity. You can check for overflow/underflow in assembly to ensure safety. If using Solidity versions < 0.8.0 and you are using Safemath, you can gain significant gas savings by using assembly to calculate values and checking for overflow/underflow. - Savings: ~60 
 

 --- 

File:FundMe.sol#L23
```solidity
22:    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
``` 



File:PriceConverter.sol#L10
```solidity
9:        return uint256(answer * 10_000_000_000);
``` 



File:PriceConverter.sol#L18
```solidity
17:        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1_000_000_000_000_000_000;
``` 



File:PriceConverter.sol#L18
```solidity
17:        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1_000_000_000_000_000_000;
``` 



 --- 

<a name=[Gas-8]></a>
### [Gas-8] Event is not properly indexed. - Instances: 1 

 > 
 When possible, always include a minimum of 3 indexed event topics to save gas - Savings: ~0 
 

 --- 

File:WETH9.sol#L23
```solidity
22:    event Approval(address indexed src, address indexed guy, uint256 wad);
``` 



File:WETH9.sol#L24
```solidity
23:    event Transfer(address indexed src, address indexed dst, uint256 wad);
``` 



File:WETH9.sol#L25
```solidity
24:    event Deposit(address indexed dst, uint256 wad);
``` 



File:WETH9.sol#L26
```solidity
25:    event Withdrawal(address indexed src, uint256 wad);
``` 



 --- 

<a name=[Gas-9]></a>
### [Gas-9] Mark functions as payable (with discretion) - Instances: 3 

 > 
 You can mark public or external functions as payable to save gas. Functions that are not payable have additional logic to check if there was a value sent with a call, however, making a function payable eliminates this check. This optimization should be carefully considered due to potentially unwanted behavior when a function does not need to accept ether. - Savings: ~24 
 

 --- 

File:FundMe.sol#L61
```solidity
60:    function withdraw() public onlyOwner {
``` 



File:FundMe.sol#L73
```solidity
72:    function cheaperWithdraw() public onlyOwner {
``` 



File:FundMe.sol#L95
```solidity
94:    function getAddressToAmountFunded(address fundingAddress) public view returns (uint256) {
``` 



File:FundMe.sol#L99
```solidity
98:    function getVersion() public view returns (uint256) {
``` 



File:FundMe.sol#L103
```solidity
102:    function getFunder(uint256 index) public view returns (address) {
``` 



File:FundMe.sol#L107
```solidity
106:    function getOwner() public view returns (address) {
``` 



File:FundMe.sol#L111
```solidity
110:    function getPriceFeed() public view returns (AggregatorV3Interface) {
``` 



File:WETH9.sol#L40
```solidity
39:    function withdraw(uint256 wad) public {
``` 



File:WETH9.sol#L47
```solidity
46:    function totalSupply() public view returns (uint256) {
``` 



File:WETH9.sol#L51
```solidity
50:    function approve(address guy, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L57
```solidity
56:    function transfer(address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L61
```solidity
60:    function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
``` 



File:Foo.sol#L5
```solidity
4:    function id(uint256 value) external pure returns (uint256) {
``` 



 --- 

<a name=[Gas-10]></a>
### [Gas-10] Use assembly when getting a contract's balance of ETH - Instances: 2 

 > 
 You can use `selfbalance()` instead of `address(this).balance` when getting your contract's balance of ETH to save gas. Additionally, you can use `balance(address)` instead of `address.balance()` when getting an external contract's balance of ETH. - Savings: ~15 
 

 --- 

File:WETH9.sol#L48
```solidity
47:        return address(this).balance;
``` 



File:FundMe.sol#L69
```solidity
68:        (bool success,) = i_owner.call{ value: address(this).balance }("");
``` 



File:FundMe.sol#L82
```solidity
81:        (bool success,) = i_owner.call{ value: address(this).balance }("");
``` 



 --- 

<a name=[Gas-11]></a>
### [Gas-11] Cache array length during for loop definition. - Instances: 1 

 > 
 A typical for loop definition may look like: `for (uint256 i; i < arr.length; i++){}`. Instead of using `array.length`, cache the array length before the loop, and use the cached value to safe gas. This will avoid an `MLOAD` every loop for arrays stored in memory and an `SLOAD` for arrays stored in storage. This can have significant gas savings for arrays with a large length, especially if the array is stored in storage. - Savings: ~22 
 

 --- 

File:FundMe.sol#L62
```solidity
61:        for (uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++) {
``` 



File:FundMe.sol#L76
```solidity
75:        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
``` 



 --- 



## Quality Assurance - Total: 46 

<a name=[NonCritical-0]></a>
### [NonCritical-0] Private variables should contain a leading underscore - Instances: 1 

 > Consider adding an underscore to the beginning of the variable name 

 --- 

File:FundMe.sol#L24
```solidity
23:    address private immutable i_owner;
``` 



 --- 

<a name=[NonCritical-1]></a>
### [NonCritical-1] Constructor should check that all parameters are not 0 - Instances: 1 

 > Consider adding a require statement to check that all parameters are not 0 in the constructor 

 --- 

File:FundMe.sol#L48
```solidity
47:    constructor(address priceFeed) {
``` 



 --- 

<a name=[NonCritical-2]></a>
### [NonCritical-2] This error has no parameters, the state of the contract when the revert occured will not be available - Instances: 1 

 > Consider adding parameters to the error to provide more context when a transaction fails 

 --- 

File:FundMe.sol#L10
```solidity
9:error FundMe__NotOwner();
``` 



 --- 

<a name=[NonCritical-3]></a>
### [NonCritical-3] Function names should be in camelCase - Instances: 7 

 > Ensure that function definitions are declared using camelCase 

 --- 

File:Foo.sol#L5
```solidity
4:    function id(uint256 value) external pure returns (uint256) {
``` 



File:FundMe.sol#L54
```solidity
53:    function fund() public payable {
``` 



File:FundMe.sol#L61
```solidity
60:    function withdraw() public onlyOwner {
``` 



File:WETH9.sol#L35
```solidity
34:    function deposit() public payable {
``` 



File:WETH9.sol#L40
```solidity
39:    function withdraw(uint256 wad) public {
``` 



File:WETH9.sol#L51
```solidity
50:    function approve(address guy, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L57
```solidity
56:    function transfer(address dst, uint256 wad) public returns (bool) {
``` 



 --- 

<a name=[NonCritical-4]></a>
### [NonCritical-4] Require/Revert statements should be consistent across the codebase - Instances: 1 

 > Consider using require/revert statements consistently across the codebase 

 --- 

File:FundMe.sol#L24
```solidity
23:    address private immutable i_owner;
``` 



 --- 

<a name=[NonCritical-5]></a>
### [NonCritical-5] Constant and immutable variable names should be in SCREAMING_SNAKE_CASE - Instances: 1 

 > Ensure that Constant and immutable variable names are declared using SCREAMING_SNAKE_CASE 

 --- 

File:FundMe.sol#L24
```solidity
23:    address private immutable i_owner;
``` 



 --- 

<a name=[NonCritical-6]></a>
### [NonCritical-6] Consider marking public function External - Instances: 12 

 > If a public function is never called internally, it is best practice to mark it as external. 

 --- 

File:FundMe.sol#L99
```solidity
98:    function getVersion() public view returns (uint256) {
``` 



File:FundMe.sol#L107
```solidity
106:    function getOwner() public view returns (address) {
``` 



File:FundMe.sol#L73
```solidity
72:    function cheaperWithdraw() public onlyOwner {
``` 



File:FundMe.sol#L103
```solidity
102:    function getFunder(uint256 index) public view returns (address) {
``` 



File:FundMe.sol#L61
```solidity
60:    function withdraw() public onlyOwner {
``` 



File:FundMe.sol#L95
```solidity
94:    function getAddressToAmountFunded(address fundingAddress) public view returns (uint256) {
``` 



File:FundMe.sol#L54
```solidity
53:    function fund() public payable {
``` 



File:FundMe.sol#L111
```solidity
110:    function getPriceFeed() public view returns (AggregatorV3Interface) {
``` 



File:WETH9.sol#L51
```solidity
50:    function approve(address guy, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L40
```solidity
39:    function withdraw(uint256 wad) public {
``` 



File:WETH9.sol#L57
```solidity
56:    function transfer(address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L47
```solidity
46:    function totalSupply() public view returns (uint256) {
``` 



 --- 

<a name=[NonCritical-7]></a>
### [NonCritical-7] Consider adding a message with require and revert statements - Instances: 5 

 > Adding a message to accompany require statements will provide more context when a transaction fails. 

 --- 

File:WETH9.sol#L41
```solidity
40:        require(balanceOf[msg.sender] >= wad);
``` 



File:WETH9.sol#L62
```solidity
61:        require(balanceOf[src] >= wad);
``` 



File:WETH9.sol#L65
```solidity
64:            require(allowance[src][msg.sender] >= wad);
``` 



File:FundMe.sol#L70
```solidity
69:        require(success);
``` 



File:FundMe.sol#L83
```solidity
82:        require(success);
``` 



 --- 

<a name=[NonCritical-8]></a>
### [NonCritical-8] Remove any unused functions - Instances: 1 

 > Any functions not used should be removed as best practice. 

 --- 

File:PriceConverter.sol#L16
```solidity
15:    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns (uint256) {
``` 



 --- 

<a name=[NonCritical-9]></a>
### [NonCritical-9] Function parameters should be in camelCase - Instances: 13 

 > Ensure that function parameters are declared using camelCase 

 --- 

File:WETH9.sol#L40
```solidity
39:    function withdraw(uint256 wad) public {
``` 



File:WETH9.sol#L51
```solidity
50:    function approve(address guy, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L51
```solidity
50:    function approve(address guy, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L57
```solidity
56:    function transfer(address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L57
```solidity
56:    function transfer(address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L61
```solidity
60:    function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L61
```solidity
60:    function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
``` 



File:WETH9.sol#L61
```solidity
60:    function transferFrom(address src, address dst, uint256 wad) public returns (bool) {
``` 



File:PriceConverter.sol#L8
```solidity
7:        (, int256 answer,,,) = priceFeed.latestRoundData();
``` 



File:Foo.sol#L5
```solidity
4:    function id(uint256 value) external pure returns (uint256) {
``` 



File:FundMe.sol#L69
```solidity
68:        (bool success,) = i_owner.call{ value: address(this).balance }("");
``` 



File:FundMe.sol#L82
```solidity
81:        (bool success,) = i_owner.call{ value: address(this).balance }("");
``` 



File:FundMe.sol#L103
```solidity
102:    function getFunder(uint256 index) public view returns (address) {
``` 



 --- 

<a name=[NonCritical-10]></a>
### [NonCritical-10] Consider explicitly naming mapping parameters - Instances: 3 

 > Consider explicitly naming mapping parameters for readability 

 --- 

File:FundMe.sol#L26
```solidity
25:    mapping(address => uint256) private s_addressToAmountFunded;
``` 



File:WETH9.sol#L28
```solidity
27:    mapping(address => uint256) public balanceOf;
``` 



File:WETH9.sol#L29
```solidity
28:    mapping(address => mapping(address => uint256)) public allowance;
``` 



 --- 


