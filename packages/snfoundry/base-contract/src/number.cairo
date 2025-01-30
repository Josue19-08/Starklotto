use starknet::ContractAddress;

#[starknet::contract]
mod Number {
    use starklotto::interfaces::INumber::{INumber};
    use starklotto::base::errors::Errors::{INVALID_NUMBER};


    #[storage]
    struct Storage {
        number: u64
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        UpdateNumber: UpdateNumber,
    }

    #[derive(Drop, starknet::Event)]
    pub struct UpdateNumber {
        #[key]
        value: u64,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.number.write(0);
    }

    #[abi(embed_v0)]
    impl NumberImpl of INumber<ContractState> {
        fn storeValue(ref self: ContractState, newNumber: u64,) -> bool {
            self.number.write(newNumber);
            self.emit(UpdateNumber { value: newNumber });

            true
        }

        fn retrieveValue(self: @ContractState) -> u64 {
            self.number.read()
        }
    }
}
