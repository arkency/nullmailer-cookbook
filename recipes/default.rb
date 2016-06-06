case node['platform_family']
  when "debian", "ubuntu"
   include_recipe "apt"
end

include_recipe "nullmailer::install_from_#{node['nullmailer']['install_method']}"

mailname  = node["nullmailer"]["mailname"] || node.fqdn
adminaddr = node["nullmailer"]["adminaddr"]

file "/etc/mailname" do
  content "#{mailname}\n"
  owner "root"
  group "root"
  mode "644"

  notifies :restart, "service[nullmailer]"
end

template "/etc/nullmailer/remotes" do
  variables :remotes => node["nullmailer"]["remotes"]
  source "etc/nullmailer/remotes"
  owner "root"
  group "root"
  mode "644"

  notifies :restart, "service[nullmailer]"
end

file "/etc/nullmailer/adminaddr" do
  content "#{adminaddr}\n"
  owner "root"
  group "root"
  mode "644"

  notifies :restart, "service[nullmailer]"
end

service "nullmailer" do
  supports :restart => true
  action [:enable, :start]
end
