    /*
    This exercise has been updated to use Solidity version 0.6.12
    Breaking changes from 0.5 to 0.6 can be found here: 
    https://solidity.readthedocs.io/en/v0.6.12/060-breaking-changes.html
*/

pragma solidity ^0.6.12;

contract SimpleBank {

    //
    // State variables
    //

    /* Fill in the keyword. Hint: We want to protect our users balance from other contracts*/
  //  mapping (address => uint) balances;
    mapping(address => uint256) AcctBalance;    

    /* Fill in the keyword. We want to create a getter function and allow contracts to be able to see if a user is enrolled.  */
    mapping (address => bool) enrolled;

    /* Let's make sure everyone knows who owns the bank. Use the appropriate keyword for this*/
    address owner;
    
    //
    // Events - publicize actions to external listeners
    // ( I added dates to these events)
    
    /* Add an argument for this event, an accountAddress */
    event LogEnrolled(
//        uint256 date,
        address from
        );

    /* Add 2 arguments for this event, an accountAddress and an amount */
    event LogDepositMade(
  //      uint256 date,
        address from, 
        uint256 amount
        );

    /* Create an event called LogWithdrawal */
    /* Add 3 arguments for this event, an accountAddress, withdrawAmount and a newBalance */

    event LogWithdrawal(
//        uint256 date,
        address from, 
        uint256 amount,
        uint256 newBalance
        );


    //
    // Functions
    //

    /* Use the appropriate global variable to get the sender of the transaction */
    constructor() public {
        /* Set the owner to the creator of this contract */
//        string memory ContractOwner = "Jason";
        owner = address(this);
    }

    // Fallback function - Called if other functions don't match call or
    // sent ether without data
    // Typically, called when invalid data is sent
    // Added so ether sent to this contract is reverted if the contract fails
    // otherwise, the sender's money is transferred to contract
    fallback() external payable {
        revert();
    }

    /// @notice Get balance
    /// @return The balance of the user
    // A SPECIAL KEYWORD prevents function from editing state variables;
    // allows function to run locally/off blockchain
    function getBalance() public view returns (uint) {
        /* Get the balance of the sender of this transaction */
        return AcctBalance[msg.sender];
    }



    /// @notice Enroll a customer with the bank
    /// @return The users enrolled status
    // Emit the appropriate event
    function enroll() public returns (bool){
        emit LogEnrolled( msg.sender);
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user after the deposit is made
    // Add the appropriate keyword so that this function can receive ether
    // Use the appropriate global variables to get the transaction sender and value
    // Emit the appropriate event    
    // Users should be enrolled before they can make deposits
    
    
    
    function deposit(uint256 _depositAmt) public returns (uint) {
        /* Add the amount to the user's balance, call the event associated with a deposit,
          then return the balance of the user */
        AcctBalance[msg.sender] += _depositAmt;
        emit LogDepositMade( msg.sender, _depositAmt);
    }
    


    // @notice Withdraw ether from bank
    // @dev This does not return any excess ether sent to it
    // @param withdrawAmount amount you want to withdraw
    // @return The balance remaining for the user
    // Emit the appropriate event    
    function withdraw(uint _withdrawAmount) public returns (uint) {
        /* If the sender's balance is at least the amount they want to withdraw,
           Subtract the amount from the sender's balance, and try to send that amount of ether
           to the user attempting to withdraw. 
           return the user's balance.*/

        // Check withdrawl amount 
        // 1. this makes the transaction fail if the 
        require(_withdrawAmount <= AcctBalance[msg.sender]);

        // 2. this line would limit withdrawls to the balance in the account
        // _withdrawAmount = min(_withdrawAmount, AcctBalance[msg.sender]);

        AcctBalance[msg.sender] -= _withdrawAmount;
        emit LogWithdrawal( msg.sender, _withdrawAmount, AcctBalance[msg.sender]);
//        return(AcctBalance[msg.sender]);
    }
    

    // @dev Returns the smallest of two numbers.
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
    

}