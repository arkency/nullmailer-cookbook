#
# Cookbook Name:: nullmailer
# Recipe:: default
#
# Copyright 2013, Arkency
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

package "nullmailer"

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


