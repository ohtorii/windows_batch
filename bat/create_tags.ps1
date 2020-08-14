
Param([Parameter(Mandatory=$true)][string]$ConfigFileName,[switch]$DryRun=$false );

$ctags_base_options="--extras=+r";
$gtags_base_options="";

function startMyApp(){
	$body=Get-Content $ConfigFileName | ConvertFrom-Json;
	$script:ignore_dirs=$body.ignore_dirs;	
	
	gather_commands $body | ForEach-Object -Parallel {
		Invoke-Expression $_;
	}
	return 0;
}

function gather_commands($body){
	ForEach ($item in $body.paths){
		$target_dir = [System.Environment]::ExpandEnvironmentVariables($item.path);
		#$target_dir = $target_dir + "\";
		if(ignore_path $target_dir){
			continue;
		}
		foreach($dir in gather_target_dirs $target_dir $item.recurse_depth){
			$command = create_ctags_command $dir $recurse_tags;
			if($command -eq ""){
				continue ;
			}
			if($DryRun){
				Write-Output "Write-Host `"$command`"";
			}else{
				Write-Output "Start-Process -Wait -FilePath `"cmd`" -ArgumentList '$command';";
			}			
		}	
	}
}

function gather_target_dirs($root_dir, $depth){
	$depth_value=0;
	if(-Not([int]::TryParse($depth,[ref]$depth_value))){
		return $root_dir;
	}
	if($depth_value -eq 0){
		return $root_dir;
	}
	foreach($dir in Get-ChildItem -Recurse -Depth $depth_value -Directory $target_dir){
		if(ignore_path $dir){
			continue;
		}
		Write-Output $dir;
	}
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

function create_ctags_command($dir, $recurse_tags){
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
			return "";	
		}
	}
	$command = "/c pushd `"{0}`"&&{1}" -f $dir, $ctags_command;
	return $command;
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

exit startMyApp;
