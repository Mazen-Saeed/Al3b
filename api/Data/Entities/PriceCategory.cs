using Al3b.Api.Data.Enums;

namespace Al3b.Api.Data.Entities;

// Pricing for a group of units (PlayStation, ping pong, billiards...).
public class PriceCategory : SyncedEntity
{
    public Guid VenueId { get; set; }
    public Venue Venue { get; set; } = null!;

    public required string Name { get; set; }

    // How this category charges. Only Hourly for now.
    public PricingMode PricingMode { get; set; } = PricingMode.Hourly;

    // The normal price per hour.
    public decimal HourlyPrice { get; set; }

    // Price per hour in multi mode (e.g. 4 controllers, doubles in ping pong).
    // Null = this category has no multi mode, so the app doesn't ask "single or multi?".
    public decimal? MultiHourlyPrice { get; set; }

}
