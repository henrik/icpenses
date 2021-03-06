#!/usr/bin/env ruby
#
# ICpenses. Parses ICporter-style YAML files, exported from your bank, and provides expense analysis.
# By Henrik Nyh <http://henrik.nyh.se> 2010-01-24 under the MIT license.

require "yaml"

class Array
  def sum
    inject(0) {|s,i| s += i }
  end
end


CLUSTERS = {
  /\b(ICA|Coop|Prisxtra|Vi T-snabben)\b/ => 'Groceries',
  /\b(restaurang|Dalastugan)\b/i         => 'Restaurant',
  /\bI-tunes\b/i                         => 'iTunes',
}
DEFAULT_CLUSTER = 'Other'


data = YAML.load(ARGF.read)
account = data['account']
transactions = data['transactions']

puts "== ICpenses"
puts
puts "   Account: %s%s" % [account['number'], (account['name'] && " (#{account['name']})")]
puts "   Period:  %s - %s" % [data['from'], data['to']]
puts


def group(transactions, label, all=false, &block)
  puts "   #{label}:"
  puts

  hash = transactions.inject(Hash.new {|h,k| h[k] = [] }) {|h,t|
    g = block.call(t)
    h[g] << t
    h
  }

  transactions = hash.to_a
  if label=="By date"
    transactions = transactions.sort_by {|k,a| k }
  else
    transactions = transactions.sort_by {|k,a| a.map {|t| t['amount'] }.sum }
  end
  transactions.each do |group, ts|
    amount = ts.map {|t| -t['amount'] }.sum
    count  = ts.length
    name = label=="All" ? group['details'] : group.to_s
    text = "#{name.ljust(25)} #{format("%.2f", amount).rjust(10)}"
    text += "  " + (label=="All" ? group['date'].to_s : "(#{count})")
    puts " * #{text}"
  end
  puts
end

group(transactions, "By cluster") { |t| CLUSTERS[ CLUSTERS.keys.find {|re| t['details'].match(re) } ] || DEFAULT_CLUSTER }
group(transactions, "By recipient") { |t| t['details'] }
group(transactions, "By date") { |t| t['date'] }
group(transactions, "All") { |t| t }

sum = transactions.map {|t| -t['amount'] }.sum
puts "   Total:                    #{format("%.2f", sum).rjust(10)}  (#{transactions.length})"
