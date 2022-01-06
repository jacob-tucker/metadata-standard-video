import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import OldExampleNFT from "../contracts/OldExampleNFT.cdc"
import MetadataViews from 0x02

// This transaction is what an account would run
// to set itself up to receive NFTs

transaction {

    prepare(signer: AuthAccount) {
        // Return early if the account already has a collection
        if signer.borrow<&OldExampleNFT.Collection>(from: OldExampleNFT.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection <- OldExampleNFT.createEmptyCollection()

        // save it to the account
        signer.save(<-collection, to: OldExampleNFT.CollectionStoragePath)

        // create a public capability for the collection
        signer.link<&{NonFungibleToken.CollectionPublic, OldExampleNFT.ExampleNFTCollectionPublic}>(
            OldExampleNFT.CollectionPublicPath,
            target: OldExampleNFT.CollectionStoragePath
        )
    }

    execute {
      log("Setup account")
    }
}