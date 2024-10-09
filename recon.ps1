function Get-Permissions ($folder) {
    try{
        if((get-acl $folder).access | Where-Object -FilterScript {($_.IdentityReference  -eq 'visitor-pc\visitor') -or ($_.IdentityReference  -eq 'BUILTIN\Users') -and $_.FileSystemRights -eq 'FullControl'})
            {
                Write-Output $folder
            }
    }
    catch{
        Write-Output "Error reading permissions for $folder"
    }
}

$list_of_dir = Get-ChildItem -Path "C:\" -Recurse -Directory -ErrorAction SilentlyContinue
$list_of_dir | Foreach-Object{
    Get-Permissions($_.FullName)
}
  
