using Al3b.Api.Data.Entities;
using Al3b.Api.Data.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class PriceCategoryConfiguration : IEntityTypeConfiguration<PriceCategory>
{
    public void Configure(EntityTypeBuilder<PriceCategory> builder)
    {
        builder.Property(c => c.PricingMode).HasDefaultValue(PricingMode.Hourly);

        builder.ToTable(t =>
        {
            t.HasCheckConstraint("ck_price_categories_hourly", "hourly_price >= 0");
            t.HasCheckConstraint("ck_price_categories_multi", "multi_hourly_price >= 0");
        });
    }
}
