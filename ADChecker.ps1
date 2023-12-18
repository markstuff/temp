Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "AD User Information"
$form.Width = 400
$form.Height = 300
$form.StartPosition = "CenterScreen"

# Create labels and textboxes for input
$labelUsername = New-Object System.Windows.Forms.Label
$labelUsername.Text = "Enter username:"
$labelUsername.Location = New-Object System.Drawing.Point(10, 20)
$labelUsername.AutoSize = $true

$textBoxUsername = New-Object System.Windows.Forms.TextBox
$textBoxUsername.Location = New-Object System.Drawing.Point(150, 20)
$textBoxUsername.Size = New-Object System.Drawing.Size(200, 20)

# Create a button
$buttonFetch = New-Object System.Windows.Forms.Button
$buttonFetch.Text = "Fetch User Information"
$buttonFetch.Location = New-Object System.Drawing.Point(150, 60)
$buttonFetch.Add_Click({
    $username = $textBoxUsername.Text
    $userInformation = Get-ADUser -Filter {SamAccountName -eq $username} -Properties Property1, Property2, Property3 | Select-Object SamAccountName, Property1, Property2, Property3
    Show-MessageBox -Message $userInformation
})

# Function to display a message box
function Show-MessageBox {
    param(
        [string]$Message
    )

    [System.Windows.Forms.MessageBox]::Show($Message, "User Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Add controls to the form
$form.Controls.Add($labelUsername)
$form.Controls.Add($textBoxUsername)
$form.Controls.Add($buttonFetch)

# Show the form
[Windows.Forms.Application]::Run($form)
