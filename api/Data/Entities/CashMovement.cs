using Al3b.Api.Data.Enums;

namespace Al3b.Api.Data.Entities;

// Cash in or out of the drawer that isn't a bill.
public class CashMovement : SyncedEntity
{
    public Guid VenueId { get; set; }
    public Venue Venue { get; set; } = null!;

    // Null when it was paid from a pocket and no cash box was open.
    public Guid? ShiftId { get; set; }
    public Shift? Shift { get; set; }

    public Guid StaffId { get; set; }
    public Staff Staff { get; set; } = null!;

    public CashMovementType Type { get; set; }
    public decimal Amount { get; set; }
    public string? Note { get; set; }

    // Where the money came from. Only expenses can be paid from a pocket.
    public PaidFrom PaidFrom { get; set; } = PaidFrom.CashBox;

    // Paid from the pocket of someone the shop must pay back (a staff member who is not an Admin).
    public bool Owed { get; set; }
    public DateTime? ReimbursedAt { get; set; }

    // Set when a stock purchase made this expense.
    public Guid? PurchaseId { get; set; }
    public Purchase? Purchase { get; set; }

    // What an expense was for. Null for cash in and owner withdrawals.
    public Guid? CategoryId { get; set; }
    public ExpenseCategory? Category { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
