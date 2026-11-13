namespace Al3b.Api.Data.Enums;

public enum ExpenseCategoryKind
{
    Normal,      // salaries, rent...: the owner's own list
    Stock,       // set by a stock purchase, never picked by hand
    Other,       // "other": always there, a note is required
    Repayment    // the shop paying a person back: not a cost
}
