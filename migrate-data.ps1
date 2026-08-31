$screens = Get-ChildItem -Path "src\screens" -Filter "*.tsx"

foreach ($file in $screens) {
    $content = Get-Content $file.FullName
    $newContent = @()
    $hasDataImport = $false
    $importLine = ""

    foreach ($line in $content) {
        if ($line -match "^import\s+\{.*\}\s+from\s+'\.\./data';$") {
            $hasDataImport = $true
            $importLine = $line
            # Replace the import with DataProvider hook import
            $newContent += "import { useAppStore } from '../services/DataProvider';"
        } else {
            $newContent += $line
            
            # If we just added the component signature, inject the hook
            if ($hasDataImport -and $line -match "^export default function \w+\(.*\) \{") {
                # Extract the variables from the original import line
                $vars = $importLine -replace "^import\s+\{\s*(.*?)\s*\}\s+from\s+'\.\./data';$", '$1'
                $newContent += "  const { $vars } = useAppStore();"
                $hasDataImport = $false # only inject once
            }
        }
    }
    
    Set-Content -Path $file.FullName -Value $newContent
}
