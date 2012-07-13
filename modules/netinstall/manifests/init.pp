# /etc/puppet/modules/netinstall/manifests/init.pp

define netinstall (
    $source_path,
    $source_filename,
    $extracted_dir,
    $destination_dir,
    $owner = "root",
    $group = "root",
    $work_dir = "/var/tmp",
    $extract_command = "tar -zxvf",
    $preextract_command = "",
    $postextract_command = ""
    # $postextract_command = "./configure ; make ; make install"
    ) {

	package { wget:	ensure => installed;}

#    $source_filename = urlfilename($url)

if $preextract_command {
    exec {
        "PreExtract $source_filename":
            command => $preextract_command,
            before  => Exec["Extract $source_filename"],
            refreshonly => true,
    }
}

    exec {
        "Retrieve $source_path$source_filename":
            cwd     => "$work_dir",
            command => "wget $source_path$source_filename",
            creates => "$work_dir/$source_filename",
            timeout => 3600,
	    require => Package["wget"],
    }

    exec {
        "Extract $source_filename":
            command => "mkdir -p $destination_dir ; cd $destination_dir ; $extract_command $work_dir/$source_filename",
            unless  => "find $destination_dir | grep $extracted_dir",
            require => Exec["Retrieve $source_path$source_filename"],
    }

if $postextract_command {
    exec {
        "PostExtract $source_filename":
            command => $postextract_command,
            cwd => "$destination_dir/$extracted_dir",
            subscribe => Exec["Extract $source_filename"],
            refreshonly => true,
            timeout => 3600,
            require => Exec["Retrieve $source_path$source_filename"],    
    }
}

}
