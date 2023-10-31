%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.starknet.common.syscalls import (
    get_caller_address,
    get_contract_address,
    get_block_timestamp,
)
from starkware.cairo.common.math import assert_not_zero,assert_le
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.uint256 import Uint256, uint256_add,uint256_lt,uint256_le

from openzeppelin.token.erc721.library import ERC721
from openzeppelin.token.erc721.enumerable.library import ERC721Enumerable
from openzeppelin.introspection.erc165.library import ERC165
from openzeppelin.access.ownable.library import Ownable
from openzeppelin.token.erc20.IERC20 import IERC20
from openzeppelin.security.pausable.library import Pausable

from contracts.token.ERC721.ERC721_Metadata_base import (
    ERC721_Metadata_initializer,
    ERC721_Metadata_tokenURI,
    ERC721_Metadata_setBaseTokenURI,
)


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
@storage_var
func WarsERC20() -> (address: felt) {
}

@storage_var
func Admin() -> (address: felt) {
}

@storage_var
func claimed_a(user: felt) -> (has : Uint256) {
}

@storage_var
func claimed_b(user: felt) -> (has : Uint256) {
}

@storage_var
func claimed_c(user: felt) -> (has : Uint256) {
}

@storage_var
func claimed_d(user: felt) -> (has : Uint256) {
}

@storage_var
func mint_balance_a() -> (balance: Uint256) {
}

@storage_var
func mint_balance_b() -> (balance: Uint256) {
}

@storage_var
func mint_balance_c() -> (balance: Uint256) {
}

@storage_var
func mint_balance_d() -> (balance: Uint256) {
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//
// Constructor
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt,wars_erc20:felt,admin:felt
) {
    ERC721.initializer('WARS', 'WARS');
    ERC721Enumerable.initializer();
    ERC721_Metadata_initializer();
    Ownable.initializer(owner);
    //ERC721_Metadata_setBaseTokenURI(base_token_uri_len, base_token_uri, token_uri_suffix);

    WarsERC20.write(wars_erc20);
    Admin.write(admin);
    return ();
}

//
// Getters
//

@view
func getClaimedA{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,}(user:felt) -> (res: Uint256) {
    let (res) = claimed_a.read(user);
    return (res=res);
}

@view
func getClaimedB{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,}(user:felt) -> (res: Uint256) {
    let (res) = claimed_b.read(user);
    return (res=res);
}

@view
func getClaimedC{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,}(user:felt) -> (res: Uint256) {
    let (res) = claimed_c.read(user);
    return (res=res);
}

@view
func getClaimedD{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr,}(user:felt) -> (res: Uint256) {
    let (res) = claimed_d.read(user);
    return (res=res);
}

@view
func getWarsERC20{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (address: felt) {
    let (address) = WarsERC20.read();
    return (address=address);
}

@view
func getAdmin{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (address: felt) {
    let (address) = Admin.read();
    return (address=address);
}

@view
func getMintBalanceA{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (balance: Uint256) {
    let (balance) = mint_balance_a.read();
    return (balance=balance);
}

@view
func getMintBalanceB{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (balance: Uint256) {
    let (balance) = mint_balance_b.read();
    return (balance=balance);
}

@view
func getMintBalanceC{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (balance: Uint256) {
    let (balance) = mint_balance_c.read();
    return (balance=balance);
}

@view
func getMintBalanceD{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (balance: Uint256) {
    let (balance) = mint_balance_d.read();
    return (balance=balance);
}

@view
func paused{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (paused: felt) {
    return Pausable.is_paused();
}

@view
func getOwner{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (owner: felt) {
    let (owner) = Ownable.owner();
    return (owner=owner);
}

@view
func supportsInterface{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    interface_id: felt
) -> (success: felt) {
    let (success) = ERC165.supports_interface(interface_id);
    return (success,);
}

@view
func name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    let (name) = ERC721.name();
    return (name,);
}

@view
func symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    let (symbol) = ERC721.symbol();
    return (symbol,);
}

@view
func balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(owner: felt) -> (
    balance: Uint256
) {
    let (balance: Uint256) = ERC721.balance_of(owner);
    return (balance,);
}

@view
func ownerOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256
) -> (owner: felt) {
    let (owner: felt) = ERC721.owner_of(token_id);
    return (owner,);
}

@view
func getApproved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256
) -> (approved: felt) {
    let (approved: felt) = ERC721.get_approved(token_id);
    return (approved,);
}

@view
func isApprovedForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, operator: felt
) -> (is_approved: felt) {
    let (is_approved: felt) = ERC721.is_approved_for_all(owner, operator);
    return (is_approved,);
}

@view
func tokenURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256
) -> (token_uri_len: felt, token_uri: felt*) {
    let (token_uri_len, token_uri) = ERC721_Metadata_tokenURI(token_id);
    return (token_uri_len=token_uri_len, token_uri=token_uri);
}

@view
func totalSupply{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    totalSupply: Uint256
) {
    let (totalSupply: Uint256) = ERC721Enumerable.total_supply();
    return (totalSupply,);
}

@view
func tokenByIndex{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    index: Uint256
) -> (tokenId: Uint256) {
    let (tokenId: Uint256) = ERC721Enumerable.token_by_index(index);
    return (tokenId,);
}

@view
func tokenOfOwnerByIndex{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, index: Uint256
) -> (tokenId: Uint256) {
    let (tokenId: Uint256) = ERC721Enumerable.token_of_owner_by_index(owner, index);
    return (tokenId,);
}


//
// Externals
//


@external
func pause{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    Ownable.assert_only_owner();
    Pausable._pause();
    return ();
}

@external
func unpause{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    Ownable.assert_only_owner();
    Pausable._unpause();
    return ();
}

@external
func approve{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    to: felt, token_id: Uint256
) {
    ERC721.approve(to, token_id);
    return ();
}

@external
func setApprovalForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    operator: felt, approved: felt
) {
    ERC721.set_approval_for_all(operator, approved);
    return ();
}

@external
func transferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    _from: felt, to: felt, token_id: Uint256
) {
    ERC721Enumerable.transfer_from(_from, to, token_id);
    return ();
}

@external
func safeTransferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    _from: felt, to: felt, token_id: Uint256, data_len: felt, data: felt*
) {
    ERC721Enumerable.safe_transfer_from(_from, to, token_id, data_len, data);
    return ();
}

@external
func setTokenURI{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    base_token_uri_len: felt, base_token_uri: felt*, token_uri_suffix: felt
) {
    Ownable.assert_only_owner();
    ERC721_Metadata_setBaseTokenURI(base_token_uri_len, base_token_uri, token_uri_suffix);
    return ();
}

@external
func burn{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(token_id: Uint256) {
    Ownable.assert_only_owner();
    ERC721._burn(token_id);
    return ();
}

@external
func transferOwnership{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    new_owner: felt
) -> (new_owner: felt) {
    // Ownership check is handled by this function
    Ownable.transfer_ownership(new_owner);
    return (new_owner=new_owner);
}


@external
func mint_a{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(inviter:felt)
{
    alloc_locals;
    let amountForMinter = Uint256(10000000000000000000000,0);
    let ethPrice = Uint256(500000000000000,0);
    let maxSold = Uint256(80000,0);
    let amountForInviter = Uint256(300000000000000000000,0);

    let maxClaimed = Uint256(5,0);
    let (tokenId: Uint256) = ERC721Enumerable.total_supply();
    let (self:felt) = get_contract_address();
    let (ERC20_WAR:felt) = WarsERC20.read();
    let eth = 0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7;
    let (admin:felt) = Admin.read();
    let (minted:Uint256) = mint_balance_a.read();
    let (caller) = get_caller_address();
    let (is_claimed:Uint256) = claimed_a.read(caller);

    Pausable.assert_not_paused();

    let (claim_is_le) = uint256_lt(is_claimed, maxClaimed);
    with_attr error_message("already claimed"){
        assert claim_is_le = TRUE;
    }

    with_attr error_message("ERC721: caller is the zero address") {
        assert_not_zero(caller);
    }

    let (sold_is_le) =  uint256_lt(minted, maxSold);
    with_attr error_message("Mint: be sold out") {
         assert sold_is_le = TRUE;
    }

    let (new_minted: Uint256, _) = uint256_add(minted, Uint256(1, 0));
    mint_balance_a.write(new_minted);

    IERC20.transferFrom(contract_address=eth, sender=caller, recipient=admin, amount=ethPrice);
    IERC20.transfer(contract_address=ERC20_WAR, recipient=caller, amount=amountForMinter);

    let (newTokenId: Uint256, _) = uint256_add(tokenId, Uint256(100000001, 0));
    ERC721Enumerable._mint(caller, newTokenId);

    let (claimed: Uint256, _) = uint256_add(is_claimed, Uint256(1, 0));
    claimed_a.write(caller,claimed);

    if(inviter != 0){
        IERC20.transfer(contract_address=ERC20_WAR, recipient=inviter, amount=amountForInviter);
        return ();
    }else{
        return ();
    }
}


@external
func mint_b{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(inviter:felt)
{
    alloc_locals;
    let amountForMinter = Uint256(42000000000000000000000,0);
    let ethPrice = Uint256(2000000000000000,0);
    let maxSold = Uint256(17000,0);
    let amountForInviter = Uint256(300000000000000000000,0);

    let maxClaimed = Uint256(5,0);
    let (tokenId: Uint256) = ERC721Enumerable.total_supply();
    let (self:felt) = get_contract_address();
    let (ERC20_WAR:felt) = WarsERC20.read();
    let eth = 0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7;
    let (admin:felt) = Admin.read();
    let (minted:Uint256) = mint_balance_b.read();
    let (caller) = get_caller_address();
    let (is_claimed:Uint256) = claimed_b.read(caller);

    Pausable.assert_not_paused();

    let (claim_is_le) = uint256_lt(is_claimed, maxClaimed);
    with_attr error_message("already claimed"){
        assert claim_is_le = TRUE;
    }

    with_attr error_message("ERC721: caller is the zero address") {
        assert_not_zero(caller);
    }

    let (sold_is_le) =  uint256_lt(minted, maxSold);
    with_attr error_message("Mint: be sold out") {
         assert sold_is_le = TRUE;
    }

    let (new_minted: Uint256, _) = uint256_add(minted, Uint256(1, 0));
    mint_balance_b.write(new_minted);

    IERC20.transferFrom(contract_address=eth, sender=caller, recipient=admin, amount=ethPrice);
    IERC20.transfer(contract_address=ERC20_WAR, recipient=caller, amount=amountForMinter);

    let (newTokenId: Uint256, _) = uint256_add(tokenId, Uint256(200000001, 0));
    ERC721Enumerable._mint(caller, newTokenId);

    let (claimed: Uint256, _) = uint256_add(is_claimed, Uint256(1, 0));
    claimed_b.write(caller,claimed);

    if(inviter != 0){
        IERC20.transfer(contract_address=ERC20_WAR, recipient=inviter, amount=amountForInviter);
        return ();
    }else{
        return ();
    }
}


@external
func mint_c{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(inviter:felt)
{
    alloc_locals;
    let amountForMinter = Uint256(220000000000000000000000,0);
    let ethPrice = Uint256(10000000000000000,0);
    let maxSold = Uint256(2500,0);
    let amountForInviter = Uint256(300000000000000000000,0);

    let maxClaimed = Uint256(5,0);
    let (tokenId: Uint256) = ERC721Enumerable.total_supply();
    let (self:felt) = get_contract_address();
    let (ERC20_WAR:felt) = WarsERC20.read();
    let eth = 0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7;
    let (admin:felt) = Admin.read();
    let (minted:Uint256) = mint_balance_c.read();
    let (caller) = get_caller_address();
    let (is_claimed:Uint256) = claimed_c.read(caller);

    Pausable.assert_not_paused();

    let (claim_is_le) = uint256_lt(is_claimed, maxClaimed);
    with_attr error_message("already claimed"){
        assert claim_is_le = TRUE;
    }

    with_attr error_message("ERC721: caller is the zero address") {
        assert_not_zero(caller);
    }

    let (sold_is_le) =  uint256_lt(minted, maxSold);
    with_attr error_message("Mint: be sold out") {
         assert sold_is_le = TRUE;
    }

    let (new_minted: Uint256, _) = uint256_add(minted, Uint256(1, 0));
    mint_balance_c.write(new_minted);

    IERC20.transferFrom(contract_address=eth, sender=caller, recipient=admin, amount=ethPrice);
    IERC20.transfer(contract_address=ERC20_WAR, recipient=caller, amount=amountForMinter);

    let (newTokenId: Uint256, _) = uint256_add(tokenId, Uint256(300000001, 0));
    ERC721Enumerable._mint(caller, newTokenId);

    let (claimed: Uint256, _) = uint256_add(is_claimed, Uint256(1, 0));
    claimed_c.write(caller,claimed);

    if(inviter != 0){
        IERC20.transfer(contract_address=ERC20_WAR, recipient=inviter, amount=amountForInviter);
        return ();
    }else{
        return ();
    }
}


@external
func mint_d{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(inviter:felt)
{
    alloc_locals;
    let amountForMinter = Uint256(1200000000000000000000000,0);
    let ethPrice = Uint256(50000000000000000,0);
    let maxSold = Uint256(500,0);
    let amountForInviter = Uint256(300000000000000000000,0);

    let maxClaimed = Uint256(5,0);
    let (tokenId: Uint256) = ERC721Enumerable.total_supply();
    let (self:felt) = get_contract_address();
    let (ERC20_WAR:felt) = WarsERC20.read();
    let eth = 0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7;
    let (admin:felt) = Admin.read();
    let (minted:Uint256) = mint_balance_d.read();
    let (caller) = get_caller_address();
    let (is_claimed:Uint256) = claimed_d.read(caller);

    Pausable.assert_not_paused();

    let (claim_is_le) = uint256_lt(is_claimed, maxClaimed);
    with_attr error_message("already claimed"){
        assert claim_is_le = TRUE;
    }

    with_attr error_message("ERC721: caller is the zero address") {
        assert_not_zero(caller);
    }

    let (sold_is_le) = uint256_lt(minted, maxSold);
    with_attr error_message("Mint: be sold out") {
         assert sold_is_le = TRUE;
    }

    let (new_minted: Uint256, _) = uint256_add(minted, Uint256(1, 0));
    mint_balance_d.write(new_minted);

    IERC20.transferFrom(contract_address=eth, sender=caller, recipient=admin, amount=ethPrice);
    IERC20.transfer(contract_address=ERC20_WAR, recipient=caller, amount=amountForMinter);

    let (newTokenId: Uint256, _) = uint256_add(tokenId, Uint256(400000001, 0));
    ERC721Enumerable._mint(caller, newTokenId);

    let (claimed: Uint256, _) = uint256_add(is_claimed, Uint256(1, 0));
    claimed_d.write(caller,claimed);

    if(inviter != 0){
        IERC20.transfer(contract_address=ERC20_WAR, recipient=inviter, amount=amountForInviter);
        return ();
    }else{
        return ();
    }
}
