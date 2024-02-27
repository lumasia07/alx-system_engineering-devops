#!/usr/bin/env ruby

sender = ARGV[0].scan(/sender:(.*?)\]/)
receiver = ARGV[0].scan(/receiver:(.*?)\]/)
flags = ARGV[0].scan(/flags:(.*?)\]/)
puts [sender, receiver, flags].join(',')
