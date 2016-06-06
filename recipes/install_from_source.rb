include_recipe "build-essential"

case node['platform_family']
when 'debian', 'ubuntu'
    package 'libgnutls-dev'
end

nullmailer_tar = "nullmailer-#{node['nullmailer']['version']}.tar.gz"
nullmailer_src_url = "#{node['nullmailer']['src_url']}/#{nullmailer_tar}"

remote_file "/usr/local/src/#{nullmailer_tar}" do
  source nullmailer_src_url
  checksum node['nullmailer']['checksum']
  mode 0644
  action :create_if_missing
end

execute "tar --no-same-owner -zxf #{nullmailer_tar}" do
  cwd "/usr/local/src"
  creates "/usr/local/src/node-v#{node['nullmailer']['version']}"
end

bash "compile nullmailer" do
  cwd "/usr/local/src/nullmailer-#{node['nullmailer']['version']}"
  code <<-EOH
    ./configure --prefix=#{node['nullmailer']['dir']} #{node['nullmailer']['tls'] ? '--enable-tls' : ''}&& \
    make
  EOH
  creates "/usr/local/src/nullmailer-#{node['nullmailer']['version']}/src/nullmailer-send"
end

execute "nullmailer make install" do
  environment({"PATH" => "/usr/local/bin:/usr/bin:/bin:$PATH"})
  command "make install"
  cwd "/usr/local/src/nullmailer-#{node['nullmailer']['version']}"
end
