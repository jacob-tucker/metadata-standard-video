/**

This contract implements the metadata standard proposed
in FLIP-0636.

Ref: https://github.com/onflow/flow/blob/master/flips/20210916-nft-metadata.md

Structs and resources can implement one or more
metadata types, called views. Each view type represents
a different kind of metadata, such as a creator biography
or a JPEG image file.
*/

pub contract MetadataViews {

    // A Resolver provides access to a set of metadata views.
    //
    // A struct or resource (e.g. an NFT) can implement this interface
    // to provide access to the views that it supports.
    //
    pub resource interface Resolver {
        pub fun getViews(): [Type] // whats types can you be viewed as?
        pub fun resolveView(_ view: Type): AnyStruct? // <-- optional type
    }

    // A ResolverCollection is a group of view resolvers index by ID.
    //
    // NOT JUST NFTs!
    pub resource interface ResolverCollection {
        pub fun borrowViewResolver(id: UInt64): &{Resolver}
        pub fun getIDs(): [UInt64]
    }

    // Display is a basic view that includes the name and description
    // of an object. Most objects should implement this view.
    //
    pub struct Display {
        pub let name: String
        pub let description: String
        pub let thumbnail: String

        init(
            name: String,
            description: String,
            thumbnail: String
        ) {
            self.name=name
            self.description=description
            self.thumbnail=thumbnail
        }
    }

    // coming soon :D
    pub struct Royalty {
        /// ...
    }

    // also maybe coming soon :)
    pub struct Identity {
        pub let uuid: UInt64
        init(uuid: UInt64) {
            self.uuid = uuid
        }
    }
}