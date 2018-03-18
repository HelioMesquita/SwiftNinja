struct OfferList: Decodable {
  let offers: [Offers]
  let links: Links

  enum CodingKeys: String, CodingKey {
    case offers = "offers"
    case links = "_links"
  }

  struct Offers: Decodable {
    let state: String
    let embedded: EmbeddedFirst
    let links: Links
    enum CodingKeys: String, CodingKey {
      case state = "state"
      case embedded = "_embedded"
      case links = "_links"
    }
  }

  struct EmbeddedFirst: Decodable {
    let request: Request
  }

  struct Request : Decodable {
    let createdAt : String
    let title : String
    let embedded : EmbeddedSecond
    enum CodingKeys: String, CodingKey {
      case createdAt = "created_at"
      case title = "title"
      case embedded = "_embedded"
    }
  }

  struct EmbeddedSecond: Decodable {
    let user: User
    let address: Address
  }

  struct Address: Decodable {
    let city: String
    let neighborhood: String
    let uf: String
  }

  struct User: Decodable {
    let name: String
  }

  struct Links: Decodable {
    let selfy: Link
    enum CodingKeys: String, CodingKey {
      case selfy = "self"
    }
  }

  struct Link: Decodable {
    let href: String
  }
}

