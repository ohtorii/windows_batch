
$ctags_base_options="--extras=+r";
$gtags_base_options="";

function startMyApp($confPath){
	$body=Get-Content $confPath | ConvertFrom-Json;
	$script:ignore_dirs=$body.ignore_dirs;

	foreach($item in $body.paths){
		#初めに、Jsonで指定したディレクトリにtagを作る
		$target_dir = [System.Environment]::ExpandEnvironmentVariables($item.path);
		$target_dir = $target_dir + "\";

		if(-Not(ignore_path $target_dir)){
			$make_ctags_result = make_ctags $target_dir $item.recurse_tags;
			if($make_ctags_result -ne 0){
				return 1;			
			}
		}
		#次に、再帰=yes ならば、サブディレクトリにtagを作る
		if($item.recurse_directory -eq "yes"){
			$sub_dirs=Get-ChildItem -Recurse -Directory $target_dir| ForEach-Object {$_.FullName};
			foreach($dir in $sub_dirs){
				$dir=$dir+"\";
				if(-Not(ignore_path $dir)){
					$make_ctags_result = make_ctags $dir $item.recurse_tags;		
					if($make_ctags_result -ne 0){
						return 1;
					}
				}
			}
		}else{
			#pass
		}		
	}
	return 0;
}

function ignore_path($dir){
	$sep="[\\/]";
	foreach ($item in $script:ignore_dirs) {
		$pattern=$sep+$item+$sep;
		if($dir -match $pattern){
			return $TRUE;
		}
	}
	return $FALSE;
}

function make_ctags($dir, $recurse_tags){
	$recurse=parse_recurse_tags $recurse_tags;
	$ctags_command = switch($recurse){
		"yes"{
			#サブディレクトリを含んだtagsを作成する（再帰）
			$ctags_options = $ctags_base_options+" -R";
			"ctags {0}" -f $ctags_options;
		}
		"no"{
			#カレントディレクトリに存在するファイルのみtagsを作成する（非再帰）
			"dir /b *.*|ctags --recurse=no -L -";
		}
		default{
			Write-Host "Unknown option";
			return 1;	
		}
	}
	$command = "/c pushd `"{0}`"&&{1}" -f $dir, $ctags_command;		
	Write-Host $command;
	#Start-Process -FilePath "cmd" -ArgumentList $command;
	return 0;
}
function parse_recurse_tags($option){
	if($null -eq $option){
		return "yes";
	}
	if($option -eq ""){
		return "yes";
	}
	if($option -eq "yes"){
		return "yes";
	}
	if($option -eq "no"){
		return "no";
	}
	return "unknown";
}


startMyApp "tags.json";;
exit;




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
