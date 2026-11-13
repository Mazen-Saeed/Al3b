using Al3b.Api.Data.Entities;
using Al3b.Api.Data.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Al3b.Api.Data.Configurations;

public class CashMovementConfiguration : IEntityTypeConfiguration<CashMovement>
{
    public void Configure(EntityTypeBuilder<CashMovement> builder)
    {
        // A row from an older app version that does not send paid_from came out of the drawer.
        builder.Property(m => m.PaidFrom).HasDefaultValue(PaidFrom.CashBox);

        builder.ToTable(t =>
        {
            t.HasCheckConstraint("ck_cash_movements_amount", "amount > 0");
            // Only money paid from a pocket can be owed.
            t.HasCheckConstraint("ck_cash_movements_owed", "owed = false OR paid_from = 'Pocket'");
        });
    }
}
