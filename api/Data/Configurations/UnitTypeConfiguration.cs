using Al3b.Api.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class UnitTypeConfiguration : IEntityTypeConfiguration<UnitType>
{
    // Fixed ids: every device and the server must use the same four rows.
    // The Flutter app has the same ids in UnitType.defaults (apps/staff/lib/data/unit_type.dart). Never change them.
    public static readonly Guid PlayStation = Guid.Parse("01990000-0000-7000-8000-000000000001");
    public static readonly Guid PingPong = Guid.Parse("01990000-0000-7000-8000-000000000002");
    public static readonly Guid Billiards = Guid.Parse("01990000-0000-7000-8000-000000000003");
    public static readonly Guid Pc = Guid.Parse("01990000-0000-7000-8000-000000000004");

    // Seed rows need a fixed timestamp: a "now" would make every migration look different.
    private static readonly DateTime SeededAt = new(2026, 10, 3, 0, 0, 0, DateTimeKind.Utc);

    public void Configure(EntityTypeBuilder<UnitType> builder)
    {
        // A name is used once per shop. The built-in four have no shop (VenueId null).
        builder.HasIndex(t => new { t.VenueId, t.Name }).IsUnique().HasFilter("deleted_at IS NULL");

        builder.HasData(
            new UnitType { Id = PlayStation, Name = "PlayStation", UpdatedAt = SeededAt },
            new UnitType { Id = PingPong, Name = "Ping pong", UpdatedAt = SeededAt },
            new UnitType { Id = Billiards, Name = "Billiards", UpdatedAt = SeededAt },
            new UnitType { Id = Pc, Name = "PC", UpdatedAt = SeededAt });
    }
}
