# My Virtual Animal Truffle Project

This project utilizes Truffle to deploy smart contracts for the NFT market. It was configured for the Goerli network environment.

## Setup

1. **Dependencies Installation**:

   ```
   npm install
   ```

2. Environment Configuration <br/>
   Create a .env file in the root directory.
   Add the following variables:
   ```
   MNEMONIC=your_mnemonic_here
   INFURA_ENDPOINT_URL=your_infura_endpoint_url_here
   ```

## Compilation

Compile the contracts to generate ABI .json files:

```
truffle compile
```

## Testing

```
truffle test
truffle test --network goerli
```

## Deployment

Migrate the contract to the Goerli network:

```
truffle migrate --network goerli
```

## Console Access

Access the Truffle console for the Goerli network:

```
truffle conosle --network goerli
```
