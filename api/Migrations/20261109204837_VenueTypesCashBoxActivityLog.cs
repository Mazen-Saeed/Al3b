using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Al3b.Api.Migrations
{
    /// <inheritdoc />
    public partial class VenueTypesCashBoxActivityLog : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_unit_types_name",
                table: "unit_types");

            migrationBuilder.AddColumn<DateTime>(
                name: "deleted_at",
                table: "unit_types",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "updated_at",
                table: "unit_types",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<Guid>(
                name: "updated_by_staff_id",
                table: "unit_types",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "venue_id",
                table: "unit_types",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "is_owner",
                table: "staff_venues",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "pricing_mode",
                table: "price_categories",
                type: "text",
                nullable: false,
                defaultValue: "Hourly");

            migrationBuilder.AlterColumn<Guid>(
                name: "shift_id",
                table: "cash_movements",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddColumn<Guid>(
                name: "category_id",
                table: "cash_movements",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "owed",
                table: "cash_movements",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "paid_from",
                table: "cash_movements",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<Guid>(
                name: "purchase_id",
                table: "cash_movements",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "reimbursed_at",
                table: "cash_movements",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "activity_log_entries",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    venue_id = table.Column<Guid>(type: "uuid", nullable: false),
                    staff_id = table.Column<Guid>(type: "uuid", nullable: false),
                    device_id = table.Column<Guid>(type: "uuid", nullable: true),
                    occurred_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    kind = table.Column<string>(type: "text", nullable: false),
                    suspicious = table.Column<bool>(type: "boolean", nullable: false),
                    details = table.Column<string>(type: "jsonb", nullable: true),
                    received_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_activity_log_entries", x => x.id);
                    table.ForeignKey(
                        name: "fk_activity_log_entries_devices_device_id",
                        column: x => x.device_id,
                        principalTable: "devices",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "expense_categories",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    venue_id = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "text", nullable: false),
                    kind = table.Column<string>(type: "text", nullable: false),
                    is_active = table.Column<bool>(type: "boolean", nullable: false),
                    updated_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    updated_by_staff_id = table.Column<Guid>(type: "uuid", nullable: true),
                    deleted_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_expense_categories", x => x.id);
                    table.ForeignKey(
                        name: "fk_expense_categories_venues_venue_id",
                        column: x => x.venue_id,
                        principalTable: "venues",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000001"),
                columns: new[] { "deleted_at", "updated_at", "updated_by_staff_id", "venue_id" },
                values: new object[] { null, new DateTime(2026, 10, 3, 0, 0, 0, 0, DateTimeKind.Utc), null, null });

            migrationBuilder.UpdateData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000002"),
                columns: new[] { "deleted_at", "updated_at", "updated_by_staff_id", "venue_id" },
                values: new object[] { null, new DateTime(2026, 10, 3, 0, 0, 0, 0, DateTimeKind.Utc), null, null });

            migrationBuilder.UpdateData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000003"),
                columns: new[] { "deleted_at", "updated_at", "updated_by_staff_id", "venue_id" },
                values: new object[] { null, new DateTime(2026, 10, 3, 0, 0, 0, 0, DateTimeKind.Utc), null, null });

            migrationBuilder.UpdateData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000004"),
                columns: new[] { "deleted_at", "updated_at", "updated_by_staff_id", "venue_id" },
                values: new object[] { null, new DateTime(2026, 10, 3, 0, 0, 0, 0, DateTimeKind.Utc), null, null });

            migrationBuilder.CreateIndex(
                name: "ix_unit_types_venue_id_name",
                table: "unit_types",
                columns: new[] { "venue_id", "name" },
                unique: true,
                filter: "deleted_at IS NULL");

            migrationBuilder.CreateIndex(
                name: "ix_unit_types_venue_id_updated_at",
                table: "unit_types",
                columns: new[] { "venue_id", "updated_at" });

            migrationBuilder.CreateIndex(
                name: "ix_staff_venues_one_owner",
                table: "staff_venues",
                column: "venue_id",
                unique: true,
                filter: "is_owner AND deleted_at IS NULL");

            migrationBuilder.CreateIndex(
                name: "ix_cash_movements_category_id",
                table: "cash_movements",
                column: "category_id");

            migrationBuilder.CreateIndex(
                name: "ix_cash_movements_purchase_id",
                table: "cash_movements",
                column: "purchase_id");

            migrationBuilder.AddCheckConstraint(
                name: "ck_cash_movements_owed",
                table: "cash_movements",
                sql: "owed = false OR paid_from = 'Pocket'");

            migrationBuilder.CreateIndex(
                name: "ix_activity_log_entries_device_id",
                table: "activity_log_entries",
                column: "device_id");

            migrationBuilder.CreateIndex(
                name: "ix_activity_log_entries_suspicious",
                table: "activity_log_entries",
                columns: new[] { "venue_id", "occurred_at" },
                filter: "suspicious");

            migrationBuilder.CreateIndex(
                name: "ix_expense_categories_venue_id_name",
                table: "expense_categories",
                columns: new[] { "venue_id", "name" },
                unique: true,
                filter: "deleted_at IS NULL AND is_active");

            migrationBuilder.CreateIndex(
                name: "ix_expense_categories_venue_id_updated_at",
                table: "expense_categories",
                columns: new[] { "venue_id", "updated_at" });

            migrationBuilder.AddForeignKey(
                name: "fk_cash_movements_expense_categories_category_id",
                table: "cash_movements",
                column: "category_id",
                principalTable: "expense_categories",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_cash_movements_purchases_purchase_id",
                table: "cash_movements",
                column: "purchase_id",
                principalTable: "purchases",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_unit_types_venues_venue_id",
                table: "unit_types",
                column: "venue_id",
                principalTable: "venues",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
            // The activity log is append only (decision #63): the database refuses to change or remove a row,
            // for everyone. (A database superuser could still drop these triggers; the app's own login must not
            // be one, and must not own the table, once there is a production database.)
            migrationBuilder.Sql(@"
CREATE FUNCTION activity_log_entries_append_only() RETURNS trigger AS $$
BEGIN
    RAISE EXCEPTION 'activity_log_entries is append only: % is not allowed', TG_OP;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER activity_log_entries_no_change
    BEFORE UPDATE OR DELETE ON activity_log_entries
    FOR EACH ROW EXECUTE FUNCTION activity_log_entries_append_only();

CREATE TRIGGER activity_log_entries_no_truncate
    BEFORE TRUNCATE ON activity_log_entries
    FOR EACH STATEMENT EXECUTE FUNCTION activity_log_entries_append_only();
");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_cash_movements_expense_categories_category_id",
                table: "cash_movements");

            migrationBuilder.DropForeignKey(
                name: "fk_cash_movements_purchases_purchase_id",
                table: "cash_movements");

            migrationBuilder.DropForeignKey(
                name: "fk_unit_types_venues_venue_id",
                table: "unit_types");

            migrationBuilder.DropTable(
                name: "activity_log_entries");

            migrationBuilder.DropTable(
                name: "expense_categories");

            migrationBuilder.DropIndex(
                name: "ix_unit_types_venue_id_name",
                table: "unit_types");

            migrationBuilder.DropIndex(
                name: "ix_unit_types_venue_id_updated_at",
                table: "unit_types");

            migrationBuilder.DropIndex(
                name: "ix_staff_venues_one_owner",
                table: "staff_venues");

            migrationBuilder.DropIndex(
                name: "ix_cash_movements_category_id",
                table: "cash_movements");

            migrationBuilder.DropIndex(
                name: "ix_cash_movements_purchase_id",
                table: "cash_movements");

            migrationBuilder.DropCheckConstraint(
                name: "ck_cash_movements_owed",
                table: "cash_movements");

            migrationBuilder.DropColumn(
                name: "deleted_at",
                table: "unit_types");

            migrationBuilder.DropColumn(
                name: "updated_at",
                table: "unit_types");

            migrationBuilder.DropColumn(
                name: "updated_by_staff_id",
                table: "unit_types");

            migrationBuilder.DropColumn(
                name: "venue_id",
                table: "unit_types");

            migrationBuilder.DropColumn(
                name: "is_owner",
                table: "staff_venues");

            migrationBuilder.DropColumn(
                name: "pricing_mode",
                table: "price_categories");

            migrationBuilder.DropColumn(
                name: "category_id",
                table: "cash_movements");

            migrationBuilder.DropColumn(
                name: "owed",
                table: "cash_movements");

            migrationBuilder.DropColumn(
                name: "paid_from",
                table: "cash_movements");

            migrationBuilder.DropColumn(
                name: "purchase_id",
                table: "cash_movements");

            migrationBuilder.DropColumn(
                name: "reimbursed_at",
                table: "cash_movements");

            migrationBuilder.AlterColumn<Guid>(
                name: "shift_id",
                table: "cash_movements",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_unit_types_name",
                table: "unit_types",
                column: "name",
                unique: true);
            migrationBuilder.Sql("DROP FUNCTION IF EXISTS activity_log_entries_append_only();");
        }
    }
}
