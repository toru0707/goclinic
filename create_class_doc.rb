#!/usr/bin/ruby

CLASSES_TXT = ARGV[0]

classes_hash = {}
open(CLASSES_TXT) do |f|
  while line = f.gets do
    splited = line.split("/"){|v| v.strip!}
    classes_hash[splited[splited.size - 1]]  ={:path => line.strip}
  end
end

#search parent class for each class
classes_hash.each do |k,v|
  open(v[:path]) do |f|
    while line = f.gets do
      if line =~ /@interface.*/
         pclass = line.scan(/: *([^ ]+)/)
         if pclass.size > 0 then v[:pclass] = pclass[0][0] end
      end
    end
  end
  splitted = k.split(".")
  v[:class] = splitted[0]


  p v[:class] + ","  + ((v[:pclass]) ? v[:pclass] : "-") + "," + "-" + "," + k
end


