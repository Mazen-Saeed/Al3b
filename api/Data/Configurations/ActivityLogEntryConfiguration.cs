using Al3b.Api.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class ActivityLogEntryConfiguration : IEntityTypeConfiguration<ActivityLogEntry>
{
    public void Configure(EntityTypeBuilder<ActivityLogEntry> builder)
    {
        builder.Property(e => e.Details).HasColumnType("jsonb");

        // The owner reads the log of one shop, newest first; the suspicious ones are what notifies them.
        builder.HasIndex(e => new { e.VenueId, e.OccurredAt });
        builder.HasIndex(e => new { e.VenueId, e.OccurredAt }).HasFilter("suspicious").HasDatabaseName("ix_activity_log_entries_suspicious");
    }
}
