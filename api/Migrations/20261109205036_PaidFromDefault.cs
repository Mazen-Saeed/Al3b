using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Al3b.Api.Migrations
{
    /// <inheritdoc />
    public partial class PaidFromDefault : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "paid_from",
                table: "cash_movements",
                type: "text",
                nullable: false,
                defaultValue: "CashBox",
                oldClrType: typeof(string),
                oldType: "text");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "paid_from",
                table: "cash_movements",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldDefaultValue: "CashBox");
        }
    }
}
