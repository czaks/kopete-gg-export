# Copyright (C) 2010 by Marcin Łabanowski

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "rubygems"
require "hpricot"

doc = File.open("#{ENV['HOME']}/.kde/share/apps/kopete/contactlist.xml") { |f| Hpricot.XML(f) }

list = doc.at("/kopete-contact-list")

(list/"meta-contact").each do |c|
  (c/"plugin-contact-data[@plugin-id='GaduProtocol']").each do |d|
    puts [
      (d/"plugin-data-field[@key='FirstName']").inner_html,
      (d/"plugin-data-field[@key='LastName']").inner_html,
      (d/"plugin-data-field[@key='prop_QString_nickName']").inner_html,
      (c/"display-name").inner_html,
      "",       # mobile phone number
      "",       # ?
      (d/"plugin-data-field[@key='contactId']").inner_html,
      "",       # ?
      "0",      # ?
      "",       # ?
      "0",      # ?
      "",       # ?
      "0",      # ?
      "",       # ?
    ].join(";")
  end
end

