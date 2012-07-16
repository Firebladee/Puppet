require 'facter'

pythonversion = nil
if File.exists?("/usr/bin/python")
    pythonversion = %x{python -V 2>&1}.split(" ")[1]
end

Facter.add("pythonversion") do
    setcode do
        pythonversion
    end
end

Facter.add("pythonmmversion") do
    pythonmmversion = nil
    if pythonversion != nil
        pythonversionsplit = pythonversion.split(".")
        pythonmmversion = pythonversionsplit[0] + "." + pythonversionsplit[1]
    end
    setcode do
        pythonmmversion
    end
end
