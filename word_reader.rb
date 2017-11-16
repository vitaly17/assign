class WordReader

def read_from_file(filename)
  if File.exist?(filename)
    file = File.new(filename, "r")
    lines = file.readlines
    file.close
    return lines.sample.chomp
  else
    return nil
  end
end

end