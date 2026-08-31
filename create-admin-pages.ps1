$adminApp = "src\app\(admin)\admin"

function Create-AdminPlaceholder ($path, $title) {
    $code = @"
export default function AdminPage() {
  return (
    <div className=`"bg-white rounded-md shadow-sm border border-slate-200 p-8`">
      <h2 className=`"text-xl font-medium text-slate-800 mb-2`">$title</h2>
      <p className=`"text-slate-500`">Admin module under construction (Phase 4).</p>
    </div>
  );
}
"@
    Set-Content -LiteralPath $path -Value $code
}

Create-AdminPlaceholder "$adminApp\dashboard\page.tsx" "System Dashboard"
Create-AdminPlaceholder "$adminApp\users\page.tsx" "Users & Roles"
Create-AdminPlaceholder "$adminApp\organizations\page.tsx" "Organizations Management"
Create-AdminPlaceholder "$adminApp\sandbox\page.tsx" "Verification Sandbox"
Create-AdminPlaceholder "$adminApp\templates\page.tsx" "Rule Templates"
