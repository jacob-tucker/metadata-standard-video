import MetadataViews from "../contracts/MetadataViews.cdc"

pub fun main(): NFTResult {
    let address: Address = 0x02
    let id: UInt64 = 0
    
    let account = getAccount(address)

    let collection = account
        .getCapability(/public/exampleNFTCollection)
        .borrow<&{MetadataViews.ResolverCollection}>()
        ?? panic("Could not borrow a reference to the collection")

    let nft = collection.borrowViewResolver(id: id)

    var data = NFTResult()

    // Get the basic display information for this NFT
    if let view = nft.resolveView(Type<MetadataViews.Display>()) {
        let display = view as! MetadataViews.Display

        data.name = display.name
        data.description = display.description
        data.thumbnail = display.thumbnail
    }

    if let view = nft.resolveView(Type<MetadataViews.Identity>()) {
        let identity = view as! MetadataViews.Identity

        data.uuid = identity.uuid
    }

    // The owner is stored directly on the NFT object
    let owner: Address = nft.owner!.address

    data.owner = owner

    // Inspect the type of this NFT to verify its origin
    let nftType = nft.getType()

    data.type = nftType.identifier
    // `data.type` is `A.f3fcd2c1a78f5eee.ExampleNFT.NFT`

    return data
}

pub struct NFTResult {
    pub(set) var name: String
    pub(set) var description: String
    pub(set) var thumbnail: String
    pub(set) var owner: Address
    pub(set) var type: String
    pub(set) var uuid: UInt64

    init() {
        self.name = ""
        self.description = ""
        self.thumbnail = ""
        self.owner = 0x0
        self.type = ""
        self.uuid = 0
    }
}