using Al3b.Api.Data.Enums;

namespace Al3b.Api.Data.Entities;

// What an expense was for ("salaries", "rent"...), so reports can say where the money went.
public class ExpenseCategory : SyncedEntity
{
    public Guid VenueId { get; set; }
    public Venue Venue { get; set; } = null!;

    public required string Name { get; set; }
    public ExpenseCategoryKind Kind { get; set; }

    // False = removed by the owner: hidden from the buttons, but old expenses still show the name.
    // (Not DeletedAt: a soft-deleted row would disappear from queries and old expenses would lose their name.)
    public bool IsActive { get; set; } = true;
}
