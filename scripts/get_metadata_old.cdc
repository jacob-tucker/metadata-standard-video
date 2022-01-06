import MetadataViews from "../contracts/MetadataViews.cdc"
import OldExampleNFT from "../contracts/OldExampleNFT.cdc"

pub fun main(address: Address, id: UInt64): NFTResult {
    let account = getAccount(address)

    let collection = account
        .getCapability(OldExampleNFT.CollectionPublicPath)
        .borrow<&{OldExampleNFT.ExampleNFTCollectionPublic}>()
        ?? panic("Could not borrow a reference to the collection")

    let nft = collection.borrowExampleNFT(id: id)!

    var data = NFTResult()

    data.name = nft.name
    data.description = nft.description
    data.thumbnail = nft.thumbnail
    
    // The owner is stored directly on the NFT object
    let owner: Address = nft.owner!.address

    data.owner = owner

    // Inspect the type of this NFT to verify its origin
    let nftType = nft.getType()

    data.type = nftType.identifier
    // `data.type` is `A.f3fcd2c1a78f5eee.OldExampleNFT.NFT`

    return data
}

pub struct NFTResult {
    pub(set) var name: String
    pub(set) var description: String
    pub(set) var thumbnail: String
    pub(set) var owner: Address
    pub(set) var type: String

    init() {
        self.name = ""
        self.description = ""
        self.thumbnail = ""
        self.owner = 0x0
        self.type = ""
    }
}