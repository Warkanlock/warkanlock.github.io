---
layout: post
title: "Make your own NFT collection using Lighthouse + Fantom"
description: "A quick guide on how to put your NFTs into the Fantom Network using the help of the Lighthouse project"
date: 2022-01-18 12:00:00 -0300
categories: programming fantom
---

## Introduction

First of all,in order to understand NFT world you will need to understand the underline technology that make them possible in the first place, because without a blockchain to store the NFT information this world would not exists in the first place. 

You will need to read [Non-fungible tokens](https://ethereum.org/en/nft/) in order to understand what we are doing here. 

> Disclaimer: This library is on beta stage, use with precaution and responsability

### What's Fantom?

We will be using Fantom as underline network to store our NFTs, in this article I'll be using the [**testnet**](testnet.ftmscan.com) but it's exactly the same to reproduce it in the **mainnet**, so no worries about that.

### Why Fantom?

Because it's the cheapest and fastest L1 out there, almost free to deploy and really easy to use. You won't need more than 1 FTM to pass through this tutorial.

### What's Lighthouse?

Lighthouse allows users to store their files on decentralized network for lifetime at a fixed price. 

I'm a contributor to the library and in order to make the ecosystem robust we need to put our hands into the dirt.

### Why Lighthouse?

Because other services are quite massive so far with a lot of articles, documentation and people using it, and also adding a lot of "centralized" content in their own way. Lighthouse will remove the friction in between you and the [IPFS](https://ipfs.io/) network making almost invisible the process to create distributed assets.

## Preparation

In this tutorial we will be using [Lighthouse CLI](https://www.lighthouse.storage/#cli) but you can translate all of this information into Javascript using the package under the name [lighthouse-web3](https://www.npmjs.com/package/lighthouse-web3). If you want to make a robust tooling around Lighthouse that's the best way to do it.

Let's gets started.

Install the CLI as a global package using:

```bash
npm install -g lighthouse-web3
```

## Creating a wallet

In order to create a wallet you can throw in the terminal after installing the CLI

```bash
> lighthouse-web3 create-wallet

Set a password for your wallet: <write your own, and don't forget it!>
Public Key: 0xcE929c41EfCF81cc547D2C3a093915b1Ba904F1A
Wallet Created!
```

Or you can use an already created wallet importing the private key:

```bash
lighthouse-web3 import-wallet --key <private-key>
```

Both of those options are OK. In this tutorial I used the CLI but if you have hesitations using the create-wallet command you can create one using the [official Fantom Wallet](https://pwawallet.fantom.network/#/dashboard) and then importing the private key resultant.

After that we should set Lighthouse to use Fantom as default network:

```bash
> lighthouse-web3 --chain fantom  
  
Currently using: testnet
Chain set to fantom

```

## Funding your wallet

After creating the wallet, we would run a command call ``balance`` to check if everything works as excepted:

```bash
> lighthouse-web3 balance
0
```

As we can see, the command throw us a result into the terminal: 0. Obviously we would need to fund this wallet and in order to do this we are gonna use the [Fantom Faucet](https://faucet.fantom.network/) (I showed on [my previous article](https://blog.ignaciobrasca.com/programming/fantom/2022/01/08/how-to-deploy-on-fantom.html#deploying-to-a-live-network) how to fund you wallet using this website)

> Have in mind that you can use real FTM to fund this account on the mainnet, this is just for the testnet.

After request to the faucet a few bucks we can throw the balance again and see if something changes (*this process usually takes more than 2 minutes*)
 
```bash
> lighthouse-web3 balance
10
```

Now we are ready to upload something on the testnet! 

## Configure Lighthouse

In order to not mess up our wallets and deploying something to the real world we are gonna use the testnet, in order to configure **Lighthouse** to do that you can go to ``lighthouse.config.js`` on the root folder of the project and change ``network`` parameter from ``mainnet`` to ``testnet``

Otherwise you will be using the mainnet instead.

## Upload a folder

That's it, we are ready to deploy something to the chain. Command to drop something it's really simple but we would need a few preparations before related to the [metadata standars of the NFTs](https://docs.opensea.io/docs/metadata-standards)

Metadata structure is, basically, like this
```
{
  "description": "<you can put a description here>", 
  "image": "<any valid url that point to an image>", 
  "name": "<you can put a name here>",
}
```

Obviously you can extend that schema to have attributes that make your NFT unique, but so far with those parameters is enough for the scope of this tutoral.

One thing to notice is that ``image`` parameter could point to ANY valid url out there, and that's a problem because we want our NFT to be as decrentralized as possible. **We do not want to store our images in Google Drive (or similar) only to wake up one day and realize that they have disappeared because we have not paid for the subscription plan**.

That's why we are about to deploy this two times.

1. For plain images, in order to distribute those images in the IPFS network
2. For metadata objects, containing the ``image`` parameter pointing to the **[CID](https://docs.ipfs.io/concepts/content-addressing/)** of the step 1

Let's get to work:

First of all, I recommend to rename all the pictures you have by an unique numeric incremental identifier, something like

```
cat.png -> 1.png
dog.png -> 2.png
elephant.png -> 3.png
```

This way, having the CID after deployment we can hit and fetch images using only the **ID** (remember this for the ``deploy-your-contrat`` step) and why it's important to keep track of the id's.

Once we rename all of the pictures using an identifier we can deploy those into the IPFS network using Lighthouse (I'll upload a test folder in order to show you how to deploy a folder):

```bash
> lighthouse-web3 deploy pictures/test

bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m    2 MB        0.015131840249440111    image/png               1.png
bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m    2 MB        0.015131840249440111    image/png               2.png
bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m    2 MB        0.015131840249440111    image/png               3.png

Summary
Total Size: 2 MB
Fees: 0.005040873106182873
Gas Fees: 98615
Total Fee: 9.861500504087311e-14

Wallet
Address: 0x1449265f3331386F5308eEe40a8b06cdfb1DCCC1
Current balance: 19.680529799801604
Balance after deploy: 19.680529799801505

File Deployed, visit following url to view content!
Visit: https://ipfs.io/ipfs/bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m
CID: bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m
```

And there's our precious **CID**  
  
Now, we can write an script to make ``.json`` metadata files to match those same IPFS links. How? by refering the CID and attaching ``/[id].png`` at the end of the ``image`` url.

Let's see what I meant with this:

**file**: ``index.js``

```javascript
const fs = require("fs");
const path = require("path");

const index = (baseCID,itemsInCID) => {
  const object = (numberOfPhoto) => {
    return {
      name: `Moment #${numberOfPhoto}`,
      description: `Moment #${numberOfPhoto}`,
      image: `ipfs://${baseCID}/${numberOfPhoto}.JPG`,
    };
  };

  for (let index = 0; index <= itemsInCID; index++) {
    fs.writeFileSync(
      path.resolve(__dirname, `${index}.json`),
      JSON.stringify(object(index))
    );
  }
};

// we can use list all the files in the directory of images to 
// get the number instead of using a hardcoded 3 here
index("bafybeigl53pbfhwi7kvsgq66pwtye5v6o5iyso3pp4b32pdulxlykyon5m", 3);
```

After running the script using ``node index.js`` we can see that now we have three files under the same directory with ``.json`` format and pointing to the IPFS content we deployed before.

Now the process is quite similar than before, save ``.json`` files into a separate folder and do the same to upload them using Lighthouse

```
> lighthouse-web3 deploy pictures/test/metadata
```

Now, after deploying this we will get another CID that point to the metadata instead of the image itself. This is useful to make OpenSea, Rarible, Artion, etc to show the correct information for our NFT.

**After saving the latest CID generated by the CLI we can now go to the contract and mint some NFTs**

## Deploy your contract

I wrote this simple contract to deploy NFT using no ``access-control`` so **don't use this in production**, but for the sake of this article I think it's more than enough:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract YourFirstNFTContract is ERC721URIStorage, Ownable {
	// usings
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    // declaration of variables
    uint256 public maxSupply = <number of pictures you want to create as NFT>;
    string baseURI;
    string baseExtension = ".json";

    constructor(string memory baseCID) ERC721(<name-of-your-nft-collection>, <your-token>) {
        setBaseURI(baseCID);
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

	// needed for the contract to return the tokenURI of the NFT, since we are not using setTokenURI() method
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
        _exists(tokenId),
        "ERC721Metadata: URI query for token that does not exists"
        );

        string memory currentBaseURI = _baseURI();
        
       
       	 // if currentBaseURI exists we return that, if not return empty string
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, "/", tokenId.toString(), baseExtension))
            : "";
    }

	// hit this method to mint an NFT for the address sent as parameter
    function mint(address user)
        public onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        require(newItemId < maxSupply, "token exceed supply");

        _safeMint(user, newItemId);

        return newItemId;
    }
}

```

As you can see, deploying this contract needs one thing, the ``<baseCID>`` generated on the previous step.

We can get the CID we obtained on the latest deployment of the metadata and put into the constructor of the contract before deploy it to the chain.

In order to deploy it, you can use [Remix Ethereum](https://remix.ethereum.org/) so you can use your ``Metamask`` wallet with the account we created on Lighthouse (importing the private key). Also you can follow my previous article to check [how to deploy a contract on Fantom without using Remix](https://blog.ignaciobrasca.com/programming/fantom/2022/01/08/how-to-deploy-on-fantom.html). If you don't know how to use Remix don't worry, it's pretty straightforward and here is a videotutorial to understand the basics: [Intro to Remix & Solidity](https://www.youtube.com/watch?v=JWJWT9cwFbo)

Using ``hardhat`` will look like

```solidity
    const YourFirstNFTContract = await ethers.getContractFactory("YourFirstNFTContract");
    const yourContract = await YourFirstNFTContract.deploy("ipfs://<baseCID>");
```

Or using Remix:

First choose Environment as Injected Web3, connect your wallet and change it to [Fantom Testnet](https://docs.fantom.foundation/tutorials/set-up-metamask-testnet):

![Step 1](https://blog.ignaciobrasca.com/img/posts/programming/pic-3.png)

Then, you can deploy it but first be sure to set the baseCID as parameter:

![Step 2](https://blog.ignaciobrasca.com/img/posts/programming/pic-4.png)

After hitting deploy, you can see the transaction log and spot the address we need on the ``from:`` parameter.

![Step 2](https://blog.ignaciobrasca.com/img/posts/programming/pic-5.png)

Either way, you will get a contract deployed and ready to be minted. To access the contract (spotted on hardhat or remix) you can use the following URL [testnet.ftmscan.com/address/{your-contract-address}](https://testnet.ftmscan.com/) 

## Mint an NFT


After getting the address of the contract, you can hit the ``Read Method`` called **mint(address)** or use Remix UI to call **mint** method. 

> First option will need you to verify the contract, so Remix option is faster in order to try it out

After this, you will mint an NFT for an address that you can spot after adding the correspond contract in the wallet. Check it out the following links:

Wallets to visualize NFTs:

- [**Metamask Mobile**](https://metamask.zendesk.com/hc/en-us/articles/360058238591-NFT-tokens-in-your-MetaMask-wallet)
- [Xdefi](https://www.xdefi.io/#section-1) 

## Conclusion

As you can see, deploying a collection to Fantom using Lighthouse it's really affordable and also easy for those who does not have too much experience on the blockchain world. Feel free to try it out and start playing with Lighthouse + Fantom!

## Useful links

- [lighthouse.storage](https://lighthouse.storage)
- [fantom.foundation](https://fantom.foundation)
- [testnet.ftmscan.com](https://testnet.ftmscan.com)