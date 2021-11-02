pageextension 50086 ItemCardExt extends "Item Card"
{
    layout
    {
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }

        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Qty. on Service Order")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify("Qty. on Prod. Order")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify(SpecialPurchPriceListTxt)
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Tariff No.")
        {
            Visible = false;
        }
        modify("Country/Region of Origin Code")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Visible = false;
        }
        modify(SpecialSalesPriceListTxt)
        {
            Visible = false;
        }
        modify(Replenishment)
        {
            Visible = false;
        }
        modify(Planning)
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        addafter(Type)
        {
            field(Discount; Discount) { ApplicationArea = all; }
            field("Level 2 Categorization"; "Level 2 Categorization") { ApplicationArea = all; }
        }



    }

    actions
    {
        modify(ItemActionGroup)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(Attributes)
        {
            Visible = false;
        }
        modify(PurchPricesandDiscounts)
        {
            Visible = false;
        }
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify("Item Journal")
        {
            Visible = false;
        }
        modify("Item Tracing")
        {
            Visible = false;
        }
        modify("Item Reclassification Journal")
        {
            Visible = false;
        }
        modify("Requisition Worksheet")
        {
            Visible = false;
        }
        modify("&Create Stockkeeping Unit")
        {
            Visible = false;
        }
        modify(CalculateCountingPeriod)
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}