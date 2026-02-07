# Web3 Solidity Course - Voting Application (Webbb3) 🗳️

A 3-lesson introduction to Web3 and smart contract development using Solidity. Build a decentralized voting application inspired by reality TV shows, learning blockchain fundamentals, contract design, and voting mechanisms.

**Instructor:** Luis Tools

---

## 📚 Course Overview

This course teaches Web3 and Solidity development through a practical, hands-on project: building a decentralized voting system where participants compete in elimination-style voting rounds.

### What You'll Learn

- **Lesson 1:** Smart contract basics, voting mechanics, and state management
- **Lesson 1 Challenge:** Advanced features including participant management, elimination tracking, and result retrieval
- **Lesson 2 & 3:** *(Coming soon)*

---

## 🏗️ Project Structure

```
webbb3-course/
├── lesson-1/                          # Foundational voting contract
│   └── voting.sol                     # Basic voting system implementation
├── lesson-1-challenge/                # Enhanced contract with advanced features
│   └── webbb3-course-lesson1-challenge.sol
├── LICENSE                            # MIT License
└── README.md                          # This file
```

---

## 💡 Lesson 1: Basic Voting System

### Concepts Covered
- Solidity data structures (`struct`)
- Smart contract state management
- Mappings and arrays
- Access control (owner-based)
- Time-based constraints

### Key Contract Features
```solidity
// Track active voting round
uint public currentVoting;

// Store voting proposals
Voting[] public votings;

// Record individual votes
mapping(uint => mapping(address => Vote)) public votes;
```

### Main Functions
- `getCurrentVoting()` - Retrieve the active voting round
- `addVoting(option1, option2, timeToVote)` - Create a new voting round (owner only)
- `addVote(choice)` - Cast a vote (1 or 2)

---

## 🎯 Lesson 1 Challenge: Advanced Features

### New Features Implemented

#### 1. **Participant Management** ✅
```solidity
struct Participant {
    uint number;      // Alphabetical order
    string name;
    uint age;
    string foto;      // Profile image URL
    string ig;        // Instagram handle
    address wallet;   // Ethereum wallet
    string descripion; // Short bio
}

function addParticipant(...) public { ... }
```

#### 2. **Voting Results Tracking** ✅
```solidity
struct ParticipantEliminated {
    uint order;   // Round number
    string name;  // Eliminated participant
}

function getVotingResult(uint votingNumber) public view returns (string memory)
```

#### 3. **Participant Validation** ✅
- Ensure both voting options are registered participants
- Prevent eliminated participants from entering new voting rounds
```solidity
require(participantsAlive[option1] != address(0), "Only available players, please.");
```

#### 4. **Elimination System** ✅
- Automatically track eliminated participants
- Remove losers from `participantsAlive` mapping
- Maintain elimination history
```solidity
function defineVoting(uint votingNumber) public { ... }
```

#### 5. **Vote Correction** ✅
- Allow participants to change their vote (removed single-vote restriction)
- Voting timestamp still tracked for audit trail

---

## 🔧 Contract Details

### Data Structures

```solidity
struct Voting {
    string option1;      // First participant
    uint votes1;         // Votes for option 1
    string option2;      // Second participant
    uint votes2;         // Votes for option 2
    uint maxDate;        // Voting deadline (Unix timestamp)
}

struct Vote {
    uint choice;         // 1 or 2
    uint date;          // When the vote was cast
}

struct Participant {
    uint number;         // Registration order
    string name;         // Full name
    uint age;           // Age
    string foto;        // Profile image URL
    string ig;          // Instagram handle
    address wallet;     // Ethereum wallet address
    string descripion;  // Bio/description
}
```

### Storage Variables

```solidity
address owner;                              // Contract deployer (admin)
uint public currentVoting = 1;              // Active round number
Voting[] public votings;                    // All voting rounds
Participant[] public participants;          // All participants
ParticipantEliminated[] public participantsEliminated; // Elimination history
mapping(uint => mapping(address => Vote)) public votes; // Vote records
mapping(string => address) participantsMapping;        // Name → Wallet lookup
mapping(string => address) participantsAlive;         // Active participants
```

---

## 🚀 Getting Started

### Prerequisites
- Solidity compiler `^0.8.21`
- Ethereum wallet (MetaMask, etc.)
- Web3 development environment (Hardhat, Truffle, or Remix)

### Deploy the Contract

1. **Using Remix IDE** (easiest):
   - Go to [remix.ethereum.org](https://remix.ethereum.org)
   - Create a new file and paste the contract code
   - Set compiler version to `0.8.21`
   - Deploy to your test network

2. **Using Hardhat**:
   ```bash
   npm install -D hardhat
   npx hardhat init
   # Copy contract to contracts/ directory
   npx hardhat run scripts/deploy.js --network <network>
   ```

### Usage Example

```solidity
// Deploy contract
Webbb3 contract = new Webbb3();

// Register participants
contract.addParticipant(1, "Alice", 28, "ipfs://...", "alice_ig", 0xAAA..., "Entrepreneur");
contract.addParticipant(2, "Bob", 32, "ipfs://...", "bob_ig", 0xBBB..., "Developer");

// Create voting round (7 days = 604800 seconds)
contract.addVoting("Alice", "Bob", 604800);

// Cast votes
contract.addVote(1); // Vote for Alice

// Check voting results
uint votes1 = contract.getCurrentVoting().votes1;

// Define winner after voting period ends
contract.defineVoting(1);

// Get elimination result
string memory eliminated = contract.getVotingResult(1);
```

---

## 📋 Course Progression

| Lesson | Focus | Status |
|--------|-------|--------|
| **1** | Basic voting mechanics | ✅ Complete |
| **1-Challenge** | Advanced features & participant management | ✅ Complete |
| **2** | *(Coming soon)* | 📅 Planned |
| **3** | *(Coming soon)* | 📅 Planned |

---

## 🐛 Known Issues & Future Improvements

### Current Limitations
- No frontend UI (contract-only)
- No integration with real blockchain networks yet
- Participation capped at 16 (by design for this lesson)

### Future Enhancements
- Frontend web interface (React + Web3.js)
- ERC-20 token voting rewards
- Multi-sig contract upgrades
- Gas optimization
- Event emissions for better indexing

---

## 📜 License

MIT License - See [LICENSE](LICENSE) file for details

---

## 🤝 Contributing

This is an educational project. Feedback and suggestions are welcome!

---

## 📧 Contact

**Instructor:** Luis Tools

---

## 🎓 Learning Resources

- [Solidity Documentation](https://docs.soliditylang.org/)
- [OpenZeppelin Smart Contract Library](https://docs.openzeppelin.com/contracts/)
- [Ethereum Development Documentation](https://ethereum.org/en/developers/)
- [Hardhat Guide](https://hardhat.org/docs)

---

**Happy coding! 🚀**
