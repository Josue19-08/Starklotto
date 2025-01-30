#[contract]
mod Participants {
    use array::ArrayTrait;
    use starknet::ContractAddress;
    
    struct Storage {
        participants: Array<ContractAddress>,
    }

    #[external(v0)]
    fn register_participant(ref self: ContractState, addr: ContractAddress) {
        let mut participants = self.participants.read();

        for i in 0..participants.len() {
            if participants.at(i) == addr {
                panic("Address already registered");
            }
        }

        participants.append(addr);
        self.participants.write(participants);
    }

    #[external(v0)]
    fn get_participants(ref self: ContractState) -> Array<ContractAddress> {
        self.participants.read()
    }
}
