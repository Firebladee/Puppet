# /etc/puppet/modules/common/manifests/line.pp

define line($file, $line, $ensure = 'present') {
	case $ensure {
		default : { err ( "unknown ensure value ${ensure}" ) }
		 present: {
			exec { "/bin/echo '${line}' >> '${file}'":
				unless => "/bin/grep -qFx '${line}' '${file}'"
			}
		}
		absent: {
			exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
				onlyif => "/bin/grep -qFx '${line}' '${file}'"
			}

			# Use this resource instead if your platform's grep doesn't support -vFx;
			# note that this command has been known to have problems with lines containing quotes.
			# exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
			#     onlyif => "/bin/grep -qFx '${line}' '${file}'"
			# }
		}
		uncomment: {
			exec { "/bin/sed -i -e'/${line}/s/#\+//' ‘${file}’” :
				onlyif => "/bin/grep '${line}' '${file}' | /bin/grep '^#' | /usr/bin/wc -l"
			}
		}
		comment: {
			exec { "/bin/sed -i -e'/${line}/s/\(.\+\)$/#\1/' ‘${file}’" :
				onlyif => "/usr/bin/test `/bin/grep '${line}' '${file}' | /bin/grep -v '^#' | /usr/bin/wc -l` -ne 0"
			}
		}
	}
}
