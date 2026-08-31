$app = "src\app\(procurement)\tenders\[tenderId]"
$lib = "../../../../../../lib/nav"

# Helper for creating wrapper component
function Create-Page ($path, $screenComponent, $relativeLevel) {
    $navImportPath = ""
    for ($i=0; $i -lt $relativeLevel; $i++) { $navImportPath += "../" }
    $navImportPath += "lib/nav"
    
    $screenImportPath = ""
    for ($i=0; $i -lt $relativeLevel; $i++) { $screenImportPath += "../" }
    $screenImportPath += "screens/$screenComponent"

    $code = @"
`"use client`";
import { useParams } from `"next/navigation`";
import { useLegacyNavigate } from `"$navImportPath`";
import $screenComponent from `"$screenImportPath`";

export default function Page() {
  const params = useParams();
  const navigate = useLegacyNavigate(params.tenderId as string);
  return <$screenComponent onNavigate={navigate as any} />;
}
"@
    Set-Content -LiteralPath $path -Value $code
}

Create-Page "$app\page.tsx" "TenderOverview" 4
Create-Page "$app\rules\page.tsx" "RuleApproval" 5
Create-Page "$app\bidders\page.tsx" "BidderList" 5
Create-Page "$app\bidders\intake\page.tsx" "BidderIntake" 6
Create-Page "$app\audit\page.tsx" "AuditTimeline" 5
Create-Page "$app\report\page.tsx" "Report" 5

# Bidder-specific pages (requires bidderId passed to useLegacyNavigate eventually, but default "B" is fine for now based on hook defaults)
$bidderApp = "$app\bidders\[bidderId]"
function Create-BidderPage ($path, $screenComponent, $relativeLevel) {
    $navImportPath = ""
    for ($i=0; $i -lt $relativeLevel; $i++) { $navImportPath += "../" }
    $navImportPath += "lib/nav"
    
    $screenImportPath = ""
    for ($i=0; $i -lt $relativeLevel; $i++) { $screenImportPath += "../" }
    $screenImportPath += "screens/$screenComponent"

    $code = @"
`"use client`";
import { useParams } from `"next/navigation`";
import { useLegacyNavigate } from `"$navImportPath`";
import $screenComponent from `"$screenImportPath`";

export default function Page() {
  const params = useParams();
  const navigate = useLegacyNavigate(params.tenderId as string, params.bidderId as string);
  return <$screenComponent onNavigate={navigate as any} />;
}
"@
    Set-Content -LiteralPath $path -Value $code
}

Create-BidderPage "$bidderApp\documents\page.tsx" "DocumentAnalysis" 7
Create-BidderPage "$bidderApp\compliance\page.tsx" "ComplianceWorkspace" 7
Create-BidderPage "$bidderApp\discrepancy\page.tsx" "DiscrepancyCenter" 7
Create-BidderPage "$bidderApp\decision\page.tsx" "OfficerDecision" 7
