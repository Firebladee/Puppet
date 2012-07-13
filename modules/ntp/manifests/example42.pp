# Class ntp::example42
#
# Custom project class for example42 project. Use this to adapt the ntp module to your project.
# This class is autoloaded if $my_module == example42
#
# You can use your custom project class to modify the standard behaviour of ntp module
# If you need to override parameters of resources defined in ntp class use a syntax like
# class ntp::example42 inherits ntp {
#     File["ntp.conf"] {
#         source => [ "puppet:///ntp/ntp.conf-$hostname" , "puppet:///ntp/ntp.conf" ],
#     }
#
# You don't need to use class inheritance if you don't override or redefine resources in ntp class
#
# Note that this approach leaves you maximum flexibility on how to manage ntp application in your environment
# You can add custom resources and decide how to provide the contents of the configuration files:
# - Via static sourced files ( source => ) according to the naming convention you need
# - Via custom templates ( content => ) or templates joins
# - Via some kind on infile line modification tools, such as Augeas or the Example42's conf define approach
#
class ntp::example42 {

}
