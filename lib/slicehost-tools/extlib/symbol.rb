class Symbol
  def /(path)
    File.join(self.to_s, path.to_s)
  end
end