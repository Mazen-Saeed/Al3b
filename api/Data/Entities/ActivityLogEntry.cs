namespace Al3b.Api.Data.Entities;

// One line of the activity log (decision #63): who did what, and when.
// Append only: not a SyncedEntity, no UpdatedAt, no soft delete. The database refuses UPDATE and DELETE
// on this table, so nobody can change or remove an entry, the owner included.
public class ActivityLogEntry
{
    // UUID v7 made on the device, so a retried sync can never insert the same line twice.
    public Guid Id { get; set; } = Guid.CreateVersion7();

    // The shop. A plain column, no foreign key (see StaffId): the backend checks the shop on every sync.
    public Guid VenueId { get; set; }

    // Who did it. A plain column, no foreign key and no navigation: staff are soft-deleted, and a log
    // entry must never disappear from a query because the person was removed later.
    public Guid StaffId { get; set; }

    // The device it happened on (null if unknown).
    public Guid? DeviceId { get; set; }
    public Device? Device { get; set; }

    // When it happened, by the device's clock.
    public DateTime OccurredAt { get; set; }

    // What happened, e.g. "session_cancelled", "bill_corrected". Text, so a new kind needs no migration.
    public required string Kind { get; set; }

    // One of the events that notify the owner.
    public bool Suspicious { get; set; }

    // The details of this kind (old and new amount, minutes played, the reason...) as JSON.
    public string? Details { get; set; }

    // When the backend received it.
    public DateTime ReceivedAt { get; set; } = DateTime.UtcNow;
}
