using Al3b.Api.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class ExpenseCategoryConfiguration : IEntityTypeConfiguration<ExpenseCategory>
{
    public void Configure(EntityTypeBuilder<ExpenseCategory> builder)
    {
        // A visible category name is used once per shop.
        builder.HasIndex(c => new { c.VenueId, c.Name }).IsUnique().HasFilter("deleted_at IS NULL AND is_active");
    }
}
