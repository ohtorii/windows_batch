$confPath="tags.json";

foreach($item in (Get-Content $confPath | ConvertFrom-Json)){
	$command = "/c pushd `"{0}`"&&ctags {1}" -f $item.path, $item.ctags_options;	
	Write-Host $command;	
	Start-Process -FilePath "cmd" -ArgumentList $command;
}



# komwnkomennto 
<# komennto 
コメントです
# >
#>
<#
foreach ($line in Get-Content tags.conf) {
	if($line.trim() -eq ""){
		#空白行なので無視する
		continue;
	}

	if($line.StartsWith("#")){
		#コメント行なので無視する
		continue;
	}
	
	pusd $line
	ctagを生成する
	popd
	
	Write-Host $line;
}
#>
