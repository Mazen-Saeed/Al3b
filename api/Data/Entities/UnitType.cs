namespace Al3b.Api.Data.Entities;

// A kind of device (PlayStation, ping pong, a shop's own "toy cars"...).
// The four built-in ones are global rows: VenueId is null, the ids are fixed and seeded in
// UnitTypeConfiguration. A shop's own types belong to that shop and sync like any other row (decision #61).
public class UnitType : SyncedEntity
{
    public Guid? VenueId { get; set; }
    public Venue? Venue { get; set; }

    public required string Name { get; set; }
}
