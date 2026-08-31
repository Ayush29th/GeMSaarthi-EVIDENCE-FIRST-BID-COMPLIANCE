$appDir = "src\app"

# Procurement routes
$procDir = "$appDir\(procurement)\tenders\[tenderId]"
New-Item -Path "$procDir\rules" -ItemType Directory -Force
New-Item -Path "$procDir\bidders\intake" -ItemType Directory -Force
New-Item -Path "$procDir\bidders\[bidderId]\documents" -ItemType Directory -Force
New-Item -Path "$procDir\bidders\[bidderId]\compliance" -ItemType Directory -Force
New-Item -Path "$procDir\bidders\[bidderId]\discrepancy" -ItemType Directory -Force
New-Item -Path "$procDir\bidders\[bidderId]\decision" -ItemType Directory -Force
New-Item -Path "$procDir\audit" -ItemType Directory -Force
New-Item -Path "$procDir\report" -ItemType Directory -Force

# Admin routes
$adminDir = "$appDir\(admin)\admin"
New-Item -Path "$adminDir\dashboard" -ItemType Directory -Force
New-Item -Path "$adminDir\users" -ItemType Directory -Force
New-Item -Path "$adminDir\organizations" -ItemType Directory -Force
New-Item -Path "$adminDir\sandbox" -ItemType Directory -Force
New-Item -Path "$adminDir\templates" -ItemType Directory -Force

# Auth routes
New-Item -Path "$appDir\(auth)\login" -ItemType Directory -Force
