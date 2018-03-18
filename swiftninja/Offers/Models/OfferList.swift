struct OfferList: Decodable {
  let offers: [Offers]
  let links: Links

  func offerAt(index: Int) -> (title: String, state: OfferState, name: String, date: String, address: String) {
    let offer = offers[index]

    let title = offer.embedded.request.title
    let state = offer.state
    let name = offer.embedded.request.embedded.user.name
    let date = offer.embedded.request.createdAt
    let dateFormatted = APIDateFormatter.defaultNumberFormatter(value: date)
    let address = offer.embedded.request.embedded.address.fullPath()

    return (title, state, name, dateFormatted ,address)
  }

  enum CodingKeys: String, CodingKey {
    case offers = "offers"
    case links = "_links"
  }

  enum OfferState: String, Decodable {
    case read, unread
  }

  struct Offers: Decodable {
    let state: OfferState
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

    func fullPath() -> String {
      return "\(city), \(uf) - \(neighborhood)"
    }
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

