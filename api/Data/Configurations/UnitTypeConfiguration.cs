using Al3b.Api.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class UnitTypeConfiguration : IEntityTypeConfiguration<UnitType>
{
    // Fixed ids: every device and the server must use the same four rows.
    // The Flutter app has the same ids in UnitTypeRules.serverId (apps/staff/lib/data/unit.dart). Never change them.
    public static readonly Guid PlayStation = Guid.Parse("01990000-0000-7000-8000-000000000001");
    public static readonly Guid PingPong = Guid.Parse("01990000-0000-7000-8000-000000000002");
    public static readonly Guid Billiards = Guid.Parse("01990000-0000-7000-8000-000000000003");
    public static readonly Guid Pc = Guid.Parse("01990000-0000-7000-8000-000000000004");

    public void Configure(EntityTypeBuilder<UnitType> builder)
    {
        builder.HasIndex(t => t.Name).IsUnique();

        builder.HasData(
            new UnitType { Id = PlayStation, Name = "PlayStation" },
            new UnitType { Id = PingPong, Name = "Ping pong" },
            new UnitType { Id = Billiards, Name = "Billiards" },
            new UnitType { Id = Pc, Name = "PC" });
    }
}
