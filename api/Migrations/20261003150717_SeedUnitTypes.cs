using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Al3b.Api.Migrations
{
    /// <inheritdoc />
    public partial class SeedUnitTypes : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "unit_types",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { new Guid("01990000-0000-7000-8000-000000000001"), "PlayStation" },
                    { new Guid("01990000-0000-7000-8000-000000000002"), "Ping pong" },
                    { new Guid("01990000-0000-7000-8000-000000000003"), "Billiards" },
                    { new Guid("01990000-0000-7000-8000-000000000004"), "PC" }
                });

            migrationBuilder.CreateIndex(
                name: "ix_unit_types_name",
                table: "unit_types",
                column: "name",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_unit_types_name",
                table: "unit_types");

            migrationBuilder.DeleteData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000001"));

            migrationBuilder.DeleteData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000002"));

            migrationBuilder.DeleteData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000003"));

            migrationBuilder.DeleteData(
                table: "unit_types",
                keyColumn: "id",
                keyValue: new Guid("01990000-0000-7000-8000-000000000004"));
        }
    }
}
