import Foundation

struct EventMetadata: Codable {
    var events: [Event]?
    enum CodingKeys: String, CodingKey {
        case events
    }
}

// MARK: - Event
struct Event: Codable {
    var type: String?
    var id: Int?
    var datetimeUTC: String?
    var datetimeTbd: Bool?
    var isOpen: Bool?
    var links: [String]?
    var datetimeLocal: String?
    var timeTbd: Bool?
    var shortTitle: String?
    var visibleUntilUTC: String?
    var url: String?
    var score: Double?
    var announceDate, createdAt: String?
    var dateTbd: Bool?
    var title: String?
    var popularity: Double?
    var eventDescription: String?
    var conditional: Bool?
    var enddatetimeUTC: String?
    var themes, domainInformation: [String]?
    var generalAdmission: Bool?
    var venue: Venue?
    var announcements: Announcements?
    var accessMethod: AccessMethod?
    var stats: EventStats?
    var taxonomies: [Taxonomy]?
    var performers: [Performer]?
    var isFavourite: Bool = false

    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case datetimeTbd = "datetime_tbd"
        case performers
        case isOpen = "is_open"
        case links
        case datetimeLocal = "datetime_local"
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"
        case stats, url, score
        case taxonomies
        case announceDate = "announce_date"
        case createdAt = "created_at"
        case dateTbd = "date_tbd"
        case title, popularity
        case eventDescription = "description"
        case accessMethod = "access_method"
        case announcements, conditional
        case enddatetimeUTC = "enddatetime_utc"
        case themes
        case domainInformation = "domain_information"
        case generalAdmission = "general_admission"
    }
}

// MARK: - AccessMethod
struct AccessMethod: Codable {
    var method: String?
    var createdAt: String?
    var employeeOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case method
        case createdAt = "created_at"
        case employeeOnly = "employee_only"
    }
}

// MARK: - Announcements
struct Announcements: Codable {
    var checkoutDisclosures: CheckoutDisclosures?

    enum CodingKeys: String, CodingKey {
        case checkoutDisclosures = "checkout_disclosures"
    }
}

// MARK: - CheckoutDisclosures
struct CheckoutDisclosures: Codable {
    var messages: [Message]?
}

// MARK: - Message
struct Message: Codable {
    var text: String?
}


// MARK: - Performer
struct Performer: Codable {
    var type, name: String?
    var image: String?
    var id: Int?
    var images: PerformerImages?
    var divisions: String?
    var hasUpcomingEvents, primary: Bool?
    var stats: PerformerStats?
    var taxonomies: [Taxonomy]?
    var imageAttribution: String?
    var url: String?
    var score: Double?
    var slug: String?
    var homeVenueID: Int?
    var shortName: String?
    var numUpcomingEvents: Int?
    var imageLicense: String?
    var popularity: Int?
    var location: Location?
    var genres: [Genre]?

    enum CodingKeys: String, CodingKey {
       // case type, name, image, id, divisions
        case image
        case hasUpcomingEvents = "has_upcoming_events"
        case primary
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case imageLicense = "image_license"
        case popularity //, location, genres
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name, slug: String?
    var primary: Bool?
    var images: GenreImages?
    var image: String?
    var documentSource: DocumentSource?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, primary, images, image
        case documentSource = "document_source"
    }
}

// MARK: - DocumentSource
struct DocumentSource: Codable {
    var sourceType: String?
    var generationType: String?

    enum CodingKeys: String, CodingKey {
        case sourceType = "source_type"
        case generationType = "generation_type"
    }
}


// MARK: - GenreImages
struct GenreImages: Codable {
    var the1200X525, the1200X627, the136X136, the500_700: String?
    var the800X320, banner, block, criteo130_160: String?
    var criteo170_235, criteo205_100, criteo400_300, fb100X72: String?
    var fb600_315, huge, ipadEventModal, ipadHeader: String?
    var ipadMiniExplore, mongo, squareMid, triggitFbAd: String?

    enum CodingKeys: String, CodingKey {
        case the1200X525 = "1200x525"
        case the1200X627 = "1200x627"
        case the136X136 = "136x136"
        case the500_700 = "500_700"
        case the800X320 = "800x320"
        case banner, block
        case criteo130_160 = "criteo_130_160"
        case criteo170_235 = "criteo_170_235"
        case criteo205_100 = "criteo_205_100"
        case criteo400_300 = "criteo_400_300"
        case fb100X72 = "fb_100x72"
        case fb600_315 = "fb_600_315"
        case huge
        case ipadEventModal = "ipad_event_modal"
        case ipadHeader = "ipad_header"
        case ipadMiniExplore = "ipad_mini_explore"
        case mongo
        case squareMid = "square_mid"
        case triggitFbAd = "triggit_fb_ad"
    }
}

// MARK: - PerformerImages
struct PerformerImages: Codable {
    var huge: String?
}

// MARK: - PerformerStats
struct PerformerStats: Codable {
    var eventCount: Int?

    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }
}

// MARK: - Taxonomy
struct Taxonomy: Codable {
    var id: Int?
    var name: String?
    var parentID: Int?
    var documentSource: DocumentSource?
    var rank: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
        case documentSource = "document_source"
        case rank
    }
}

// MARK: - EventStats
struct EventStats: Codable {
    var listingCount, lowestPriceGoodDeals, lowestPrice: Int?
    var highestPrice, visibleListingCount, medianPrice: Int?
    var lowestSgBasePrice, lowestSgBasePriceGoodDeals: Int?
    var dqBucketCounts: [Int]?
    var averagePrice: Int?

    enum CodingKeys: String, CodingKey {
        case listingCount = "listing_count"
        case averagePrice = "average_price"
        case lowestPriceGoodDeals = "lowest_price_good_deals"
        case lowestPrice = "lowest_price"
        case highestPrice = "highest_price"
        case visibleListingCount = "visible_listing_count"
        case dqBucketCounts = "dq_bucket_counts"
        case medianPrice = "median_price"
        case lowestSgBasePrice = "lowest_sg_base_price"
        case lowestSgBasePriceGoodDeals = "lowest_sg_base_price_good_deals"
    }
}

// MARK: - Venue
struct Venue: Codable {
    var state: String?
    var nameV2, postalCode, name: String?
    var links: [String]?
    var timezone: String?
    var url: String?
    var score: Double?
    var location: Location?
    var address: String?
    var country: String?
    var hasUpcomingEvents: Bool?
    var numUpcomingEvents: Int?
    var city, slug, extendedAddress: String?
    var id, popularity: Int?
    var accessMethod: AccessMethod?
    var metroCode, capacity: Int?
    var displayLocation: String?

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, links, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case accessMethod = "access_method"
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}


// MARK: - Location
struct Location: Codable {
    var lat, lon: Double?
}

// MARK: - InHand
struct InHand: Codable {
}

// MARK: - Meta
struct Meta: Codable {
    var total, took, page, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case total, took, page
        case perPage = "per_page"
    }
}
